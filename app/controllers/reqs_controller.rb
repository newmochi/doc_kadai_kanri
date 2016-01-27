class ReqsController < ApplicationController
  before_action :set_req, only: [:show, :edit, :update, :destroy]

  # GET /reqs
  # GET /reqs.json
  def index
    @reqs = Req.all
   end

  # GET /reqs/1
  # GET /reqs/1.json
  def show
  end

  # GET /reqs/new
  def new
    @req = Req.new
  end

  # GET /reqs/1/edit
  def edit
  end

  # POST /reqs
  # POST /reqs.json
  def create
    @req = Req.new(req_params)

    respond_to do |format|
      if @req.save
        format.html { redirect_to @req, notice: '要件作成完了。' }
        format.json { render :show, status: :created, location: @req }
      else
        format.html { render :new }
        format.json { render json: @req.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reqs/1
  # PATCH/PUT /reqs/1.json
  def update
    respond_to do |format|
      if @req.update(req_params)
        format.html { redirect_to @req, notice: '要件更新完了。' }
        format.json { render :show, status: :ok, location: @req }
      else
        format.html { render :edit }
        format.json { render json: @req.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reqs/1
  # DELETE /reqs/1.json
  def destroy
    @req.destroy
    respond_to do |format|
      format.html { redirect_to reqs_url, notice: '要件削除完了。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_req
      @req = Req.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def req_params
      params.require(:req).permit(:user_id, :rchap, :rsec, :rsubsec, :rseqno, :rtitile, :rcontent, :rnote, :rnotedetail)
    end
end
