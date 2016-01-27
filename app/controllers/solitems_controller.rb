class SolitemsController < ApplicationController
  require 'csv'
  before_action :set_solitem, only: [:show, :edit, :update, :destroy]

  # GET /solitems
  # GET /solitems.json
  def search
#    @solitems = Solitem.search(params[:q1]).
#    paginate(page: params[:page], per_page: 15)
    @solitems = Solitem.search(params[:q1])
#    if @solitems.present?
#      @solitems.paginate(page: params[:page], per_page: 15)
#    end
#      render "index"

  end


  def index
#    @solitems = Solitem.all
    @solitems = Solitem.order("id").
    paginate(page: params[:page], per_page: 15)
  end

  # GET /solitems/1
  # GET /solitems/1.json
  def show
  end

  #20140810=======================================
  def download
    @solitems = Solitem.order(":id, :req_id, :user_id")

    header = ['ID', '要件章節項',  'オーナー', '見積status', '全体status', '次回要確認日', '課題タイトル',
'課題内容', 'レベル', 'ソリューション内容',
'備考', '備考（長文可）', '更新日時' ]
    generated_csv = CSV.generate(row_sep: "\r\n") do |csv|
      csv << header
      @solitems.each do |i|
        @tmpuser = User.find(i.user_id)
        @tmpreq = Req.find(i.req_id)
        tmpc_s_s = sprintf("%s.%s.%s.",@tmpreq.rchap,@tmpreq.rsec,@tmpreq.rsubsec)
        csv << [i.id, tmpc_s_s, @tmpuser.uname, i.sphase,
i.starget, i.sduedate, i.stitle, i.scontent, i.slevel,
i.saction, i.snote, i.snotedetail, i.updated_at ]
      end
    end

    send_data generated_csv.encode(Encoding::CP932, invalid: :replace, undef: :replace),
      filename: 'solitemlist.csv',
      type: 'text/csv; charset=shift_jis'
  end

  def downloadall

#20140811A http://qiita.com/unosk/items/403d0fdaf91ca86aa099ではMy SQLならOK、
#20140811A 確かに検索はOK。しかし他のDBはエラーかも。かつ自分はsolitems以外
#20140811A のテーブルからの列を取れなかった。
#20140811A @soljoin = Solitem.joins("LEFT JOIN reqs on solitems.req_id = reqs.id
#20140811A                    LEFT JOIN users on  solitems.user_id = users.id")

#20140811B これも@soljoinをdebugで見れない、かつCSVにdoで書けないので断念。
#20140811B    @soljoin = Solitem.includes(:req, :user).
#20140811B    where(Req.arel_table[:enable].eq(true).or(User.arel_table[:enable].eq(true)))
#20140811B    logger.debug (@soljoin)

    header = [
    'solのID','要件ID','ユーザID','見積status','全体status',
    'solタイトル','sol課題内容','solレベル','sol内容','sol備考',
    'sol備考(長文)','req章','req節','req項','req条',
    'reqタイトル','req内容','req備考','req備考(長文)','ユーザ名'
    ]
    generated_csv = CSV.generate(row_sep: "\r\n") do |csv|
      csv << header
      caution = [ '制限事項：メモ帳でダブルコーテーションを全てなしに置換してからExcelで開いてください。']
      csv << caution

#OK
#    @soljoin = 
#    ActiveRecord::Base.connection.send(:select,
#    "select solitems.id,solitems.req_id,solitems.user_id,solitems.sphase,solitems.starget,
#   solitems.stitle,solitems.scontent,solitems.slevel,solitems.saction,
#    solitems.snote,solitems.snotedetail,
#    reqs.rchap,reqs.rsec,reqs.rsubsec,reqs.rseqno,reqs.rtitile,reqs.rcontent,
#    reqs.rnote,reqs.rnotedetail,
#    users.uname
#    from solitems
#    left join reqs on solitems.req_id = reqs.id
#    left join users on  solitems.user_id = users.id ;")
#      @soljoin.each do |i|
#        i.each do |row|
#OK 項目名と値が延々          csv << row
#        end
#      end



@results = []
    ActiveRecord::Base.connection.send(:select,
    "select solitems.id,solitems.req_id,solitems.user_id,solitems.sphase,solitems.starget,
    solitems.stitle,solitems.scontent,solitems.slevel,solitems.saction,
    solitems.snote,solitems.snotedetail,
    reqs.rchap,reqs.rsec,reqs.rsubsec,reqs.rseqno,reqs.rtitile,reqs.rcontent,
    reqs.rnote,reqs.rnotedetail,
    users.uname
    from solitems
    left join reqs on solitems.req_id = reqs.id
    left join users on  solitems.user_id = users.id ;").each do |record|
# {:id=>16, :req_id=>47, :user_id=>4, :sphase=>"",
# :starget=>"", :stitle=>"メタディレクトリだてるのか。",
# :scontent=>"", :slevel=>"", :saction=>"", :snote=>"",
# :snotedetail=>"", :rchap=>4, :rsec=>4, :rsubsec=>1,
# :rseqno=>"", :rtitile=>"概要・目的", :rcontent=>"",
# :rnote=>"", :rnotedetail=>"", :uname=>"kuno"}
# と出る。但し      @results.each do |i|
#        csv << [i]
#      endのとき

    @results << {id: record["id"].to_s, req_id: record["req_id"].to_s,
    user_id: record["user_id"].to_s, sphase: record["sphase"],
    starget: record["starget"], stitle: record["stitle"],
    scontent: record["scontent"], slevel: record["slevel"],
    saction: record["saction"], snote: record["snote"],
    snotedetail: record["snotedetail"],
    rchap: record["rchap"].to_s,rsec: record["rsec"].to_s,
    rsubsec: record["rsubsec"].to_s,rseqno: record["rseqno"].to_s,
    rtitile: record["rtitile"],rcontent: record["rcontent"],
    rnote: record["rnote"],rnotedetail: record["rnotedetail"],
    uname: record["uname"]
    }
    end


      @results.each do |i|
        tmpstr01 = sprintf("%s",i)
# OK        /:id=>(.*),.*/ =~tmpstr
# OK        tmpstr2 = tmpstr.gsub(/:id=>/,'')
        tmpstr02 = tmpstr01.sub(/:id=>/,'')
        tmpstr03 = tmpstr02.sub(/:req_id=>/,'')
        tmpstr04 = tmpstr03.sub(/:user_id=>/,'')
        tmpstr05 = tmpstr04.sub(/:sphase=>/,'')
        tmpstr06 = tmpstr05.sub(/:starget=>/,'')
        tmpstr07 = tmpstr06.sub(/:stitle=>/,'')
        tmpstr08 = tmpstr07.sub(/:scontent=>/,'')
        tmpstr09 = tmpstr08.sub(/:slevel=>/,'')
        tmpstr10 = tmpstr09.sub(/:saction=>/,'')
        tmpstr11 = tmpstr10.sub(/:snote=>/,'')
        tmpstr12 = tmpstr11.sub(/:snotedetail=>/,'')
        tmpstr13 = tmpstr12.sub(/:rchap=>/,'')
        tmpstr14 = tmpstr13.sub(/:rsec=>/,'')
        tmpstr15 = tmpstr14.sub(/:rsubsec=>/,'')
        tmpstr16 = tmpstr15.sub(/:rseqno=>/,'')
        tmpstr17 = tmpstr16.sub(/:rtitile=>/,'')
        tmpstr18 = tmpstr17.sub(/:rcontent=>/,'')
        tmpstr19 = tmpstr18.sub(/:rnote=>/,'')
        tmpstr20 = tmpstr19.sub(/:rnotedetail=>/,'')
        tmpstr21 = tmpstr20.sub(/:uname=>/,'')
        tmpstr21a = tmpstr21.sub(/{/,'')
        tmpstr21b = tmpstr21a.sub(/}/,'')
        tmpstr21c = tmpstr21b.gsub(/"""/,'')
        tmpstr21d = tmpstr21c.gsub(/""/,'')
        tmpstr21e = tmpstr21d.gsub(/"/,'')
#A惜しい        tmpstr21c = tmpstr21b.gsub(/""/,'\'')
#A惜しい        tmpstr21d = tmpstr21c.gsub(/"/,'\'')

# OK""はきえたが        tmpstr21c = tmpstr21b.gsub(/"/,'')

# NG        /(.*),(.*),(.*),(.*),(.*),
#         (.*),(.*),(.*),(.*),(.*),
#         (.*),(.*),(.*),(.*),(.*),
#         (.*),(.*),(.*),(.*),(.*)/ =~ tmpstr2
# NG        csv << [$5,$6,$7,$8]
#       @tmp1 = $1
#       @tmp2 = $2
#       @tmp3 = $3
# NG       csv << [tmp1,tmp2,tmp3]

# NG[]が前後に付くだけ        csv << [tmpstr21e.lines.to_a]

        csv << [tmpstr21e] #最初と最後の"は消せない。

      end


#      @soljoin.each do |row|
#          csv << [row[:value],row[1]]
#      end

#NG key,valueしかExcelにかかれない。
#      @soljoin.each do |key, value|
#        data =['#(key):', '#(value)']
#        csv <<  data
#err        csv << value[:id]
#      end


    end  #generated_csv's end

    send_data generated_csv.encode(Encoding::CP932, invalid: :replace, undef: :replace),
      filename: 'solitemjoin.csv',
      type: 'text/csv; charset=shift_jis'
  end
  #20140810終わり===================================

  # GET /solitems/new
  def new
    @solitem = Solitem.new
    #20140822 要件IDをcollectionで表示するため。しかしエラーでやめた。
    #Reqs.allを直接_formでお茶を濁した。
  end

  # GET /solitems/1/edit
  def edit
  end

  # POST /solitems
  # POST /solitems.json
  def create
    @solitem = Solitem.new(solitem_params)

    respond_to do |format|
      if @solitem.save
        format.html { redirect_to @solitem, notice: 'ソリューション課題作成完了。' }
        format.json { render :show, status: :created, location: @solitem }
      else
        format.html { render :new }
        format.json { render json: @solitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solitems/1
  # PATCH/PUT /solitems/1.json
  def update
    respond_to do |format|
      if @solitem.update(solitem_params)
        format.html { redirect_to @solitem, notice: 'ソリューション課題更新完了。' }
        format.json { render :show, status: :ok, location: @solitem }
      else
        format.html { render :edit }
        format.json { render json: @solitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solitems/1
  # DELETE /solitems/1.json
  def destroy
    @solitem.destroy
    respond_to do |format|
      format.html { redirect_to solitems_url, notice: 'ソリューション課題削除完了。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solitem
      @solitem = Solitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solitem_params
      params.require(:solitem).permit(:req_id, :user_id, :sphase, :starget, :stitle, :scontent, :slevel, :saction, :snote, :snotedetail, :sduedate)
    end
end
