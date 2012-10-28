class CustomAuthenticationFailure < Devise::FailureApp 
  protected 
  def redirect_url 
    '/users/auth/yammer'
  end 
end
