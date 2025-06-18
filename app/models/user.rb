class User < ApplicationRecord
   rolify

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :attendances, dependent: :destroy

  after_create :assign_default_role

  private

  def assign_default_role
    self.add_role(:employee) if self.roles.blank?
  end
end
