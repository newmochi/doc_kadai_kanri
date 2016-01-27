class User < ActiveRecord::Base
  has_many :reqs
  has_many :solitems
end
