class GeneratedProject < ApplicationRecord
  belongs_to :template
  belongs_to :user
  validates :config_choices, presence: true
end
