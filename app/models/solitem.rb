class Solitem < ActiveRecord::Base
  belongs_to :req
  belongs_to :user
  validates :user, :presence => true
  validates :req, :presence => true

  class << self
# add on search ユーザ名
# 以下は断念 rel = rel.where("ownername LIKE ?","%#{query2}%")
    def search(query1)
      @ttt = User.find_by( uname: query1)
      if @ttt != nil
        rel = where(user_id: @ttt.id )
        rel = rel.order("id, req_id")
      end
    end
  end

end
