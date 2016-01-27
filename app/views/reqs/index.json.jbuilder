json.array!(@reqs) do |req|
  json.extract! req, :id, :user_id, :rchap, :rsec, :rsubsec, :rseqno, :rtitile, :rcontent, :rnote, :rnotedetail
  json.url req_url(req, format: :json)
end
