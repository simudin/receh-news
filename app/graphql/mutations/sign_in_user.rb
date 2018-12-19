module Mutations
  class SignInUser < Mutations::BaseMutation
    argument :credentials, Types::AuthProviderEmailInput, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(credentials:)
      email = credentials[:email]
      password = credentials[:password]

      user = User.find_by_email(email)


      if user && user.authenticate(password)
        crypt = ActiveSupport::MessageEncryptor.new(
          Rails.application.credentials.secret_key_base.byteslice(0..31)
        )
        token = crypt.encrypt_and_sign("user-id:#{ user.id }")
        context[:session][:token] = token

        {
          user: user,
          token: token,
          errors: []
        }
      else
        {
          errors: ["Can't login"]
        }
      end
    end
  end
end
