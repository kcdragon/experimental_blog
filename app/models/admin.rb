class Admin
  include Mongoid::Document

  devise :database_authenticatable, :validatable

  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''
end
