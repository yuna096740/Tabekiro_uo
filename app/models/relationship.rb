class Relationship < ApplicationRecord
  belongs_to :subscriber, class_name: "Member"
  belongs_to :subscribed, class_name: "Member"
end
