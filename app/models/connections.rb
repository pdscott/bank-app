class User < ApplicationRecord
  belongs_to :user

  after_initialize :set_default_role, :if => :new_record?

  def set_default
    self.user_id ||= :user
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
