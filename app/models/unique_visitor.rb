class UniqueVisitor < ApplicationRecord
  validates_uniqueness_of :ip
end