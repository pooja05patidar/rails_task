# frozen_string_literal: true

# registration controller
module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    def create
      # debugger
      build_resource(sign_up_params)

      if resource.save
        sign_up(resource_name, resource)
        UserMailer.welcome_email(resource).deliver_now
        render json: {
          status: { code: 200, message: 'Signed up successfully', data: resource }
        }
      else
        clean_up_passwords resource
        set_minimum_password_length
        render json: {
          status: :unprocessable_entity,
          message: 'User could not be created successfully',
          errors: resource.errors.full_messages.to_json
        }
      end
    end

    def apply_for_owner
      # debugger
      aadhaar_card_number = params[:aadhaar_card_number]
      id_proof = params[:id_proof]
      age = params[:age]
      if aadhaar_card_number.blank? || id_proof.blank?
        render json: { error: 'Please provide aadhaar card number and id proof' }, status: :unprocessable_entity
        return
      end
      current_user.update_columns(role: :owner_pending_approval, aadhaar_card_number: aadhaar_card_number,
                                  id_proof: id_proof, age: age)
      render json: { message: 'Owner request submitted for approval' }
      UserMailer.owner_request(current_user).deliver_now
    end

    private

    def current_user_params
      params.require(:user).permit(:contact)
    end

    def admin_approve_owner
      if current_user.admin?
        user = User.find(params[:user_id])
        user.update(_role: :owner, approved_by_admin: true)
        render json: { message: 'User approved as owner' }
      else
        render json: { message: 'Unauthorized to perform this action' }, status: :unauthorized
      end
    end

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password address contact role username])
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update,
                                        keys: %i[name email password address contact role username])
    end
  end
end
