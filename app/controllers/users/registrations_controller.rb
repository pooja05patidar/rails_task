# frozen_string_literal: true

# registration controller
module Users
  # class Registration controller
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json
    before_action :authenticate_user!
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    # debugger
    def create
      build_resource(sign_up_params)
      if resource.save
        ret_success_response
      else
        ret_failed_response
      end
    end

    def apply_for_owner
      aadhaar_card_number = params[:aadhaar_card_number]
      id_proof = params[:id_proof]
      age = params[:age]
      if aadhaar_card_number.blank? || id_proof.blank?
        render json: { error: 'Please provide aadhaar card number and id proof' }, status: :unprocessable_entity
        return
      end
      current_user = User.last
      if current_user.role == 'customer'
        update_user_column
      else
        render json: { message: 'You are not authorized for this action' }
      end
    end

    def update_user_column
      current_user.update_columns(
        role: :owner_pending_approval,
        aadhaar_card_number: aadhaar_card_number,
        id_proof: id_proof,
        age: age
      )
      render json: { message: 'Owner request submitted for approval' }
      UserMailer.owner_request(current_user).deliver_now
    end

    private

    def current_user_params
      params.require(:user).permit(:contact)
    end

    def ret_success_response
      sign_up(resource_name, resource)
      render json: {
        status: { code: 200, message: 'Signed up successfully', data: resource }
      }
    end

    def ret_failed_response
      clean_up_passwords resource
      set_minimum_password_length
      render json: {
        status: :unprocessable_entity,
        message: 'User could not be created successfully',
        errors: resource.errors.full_messages.to_json
      }, status: :unprocessable_entity
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
