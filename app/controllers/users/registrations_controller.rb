class Users::RegistrationsController < ApplicationController

  def index; end

  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
  end

  def update_resource(resource, params)
    return super if params['password']&.present?
    resource.update_without_password(params.except('current_password'))
  end
end
