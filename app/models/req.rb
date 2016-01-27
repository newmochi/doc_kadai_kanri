class Req < ActiveRecord::Base
  belongs_to :user
  has_many :solitems
  validates :user, :presence => true
end
