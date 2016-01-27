json.array!(@solitems) do |solitem|
  json.extract! solitem, :id, :req_id, :user_id, :sphase, :starget, :stitle, :scontent, :slevel, :saction, :snote, :snotedetail
  json.url solitem_url(solitem, format: :json)
end
