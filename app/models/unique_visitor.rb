class UniqueVisitor < ApplicationRecord
  validates_uniqueness_of :ip, :scope => :created_date
end