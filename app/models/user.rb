class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :tasks, foreign_key: 'client_id', dependent: :destroy
  has_many :tasks, foreign_key: 'admin_id', dependent: :destroy
  has_many :comments, dependent: :destroy
  # number_regex = ((8|\+7)-?)?\(?\d{3}\)?-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}
  validates :phone_number, presence: true, uniqueness: true
  # russian_phone :phone_number
  # russian_phone :validated_phone_number, default_country: 7, validate: true
  validates :first_name, presence: true
  validates :middle_name, presence: true
  validates :last_name, presence: true
  validates :company_name, presence: true
  validates :description, presence: true

  after_create :assign_default_role
  after_update :assign_another_role

  def assign_default_role
    if self.role_ids == 1 || self.roles.blank?
      self.add_role(:client)
    else
      self.add_role(:admin)
    end
  end

  def assign_another_role
    if self.role_ids[0] == 1
      self.remove_role(:admin)
      self.add_role(:client)
    else
      self.remove_role(:client)
      self.add_role(:admin)
    end
  end

  def first_and_last_name
    "#{first_name} #{last_name}"
  end

end
