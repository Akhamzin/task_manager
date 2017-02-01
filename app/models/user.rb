class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :tasks, dependent: :destroy, :foreign_key => 'client_id'
  has_many :comments, dependent: :destroy
  # number_regex = ((8|\+7)-?)?\(?\d{3}\)?-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}
  # validates :phone_number,  with: number_regex
  validates :first_name, presence: true
  validates :middle_name, presence: true
  validates :last_name, presence: true
  validates :company_name, presence: true
  validates :description, presence: true

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:client) if self.roles.blank?
  end

  def first_and_last_name
    "#{first_name} #{last_name}"
  end

end
