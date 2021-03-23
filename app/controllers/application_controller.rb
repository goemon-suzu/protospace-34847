class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?  #もしdeviseに関するコントローラーの処理であれば

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])  #sign_up（新規登録の処理）に対して、記載のキーのパラメーターを新たに許可します
  end

end
