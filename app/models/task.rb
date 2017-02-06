class Task < ActiveRecord::Base
  resourcify

  has_many :comments, dependent: :destroy
  belongs_to :admin, :class_name => 'User', :foreign_key => 'admin_id'
  belongs_to :client, :class_name => 'User', :foreign_key => 'client_id'
  
  validates :name, :description, presence: true
  validates :status, inclusion: { in: %w(новая просмотрена оплачена выполнена закрыта) }

  STATUS = %w(Новая Просмотрена Оплачена Выполнена Закрыта)

end
