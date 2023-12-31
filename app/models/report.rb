class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Member"
  belongs_to :reported, class_name: "Member"

  validates :reason,  presence: :true

  enum is_supported: { waiting: 0, keep: 1, done: 2 }
  enum genre:        { inappropriate_content: 0, aggressive: 1, spam: 2, others: 3 }
end
