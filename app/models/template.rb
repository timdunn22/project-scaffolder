class Template < ApplicationRecord
  belongs_to :user, optional: true
  has_many :generated_projects, dependent: :destroy
  validates :name, presence: true
  validates :file_structure, presence: true
  scope :public_templates, -> { where(is_public: true) }
end
