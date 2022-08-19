class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.create_from_provider_data(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Github'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.github_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later'
    redirect_to new_user_registration_url
  end
end
