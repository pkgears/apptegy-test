# frozen_string_literal: true

# Module for user authentication in controllers
module DeviseAuthHelper
  def token_sign_in(user)
    user.create_new_auth_token
  end
end
