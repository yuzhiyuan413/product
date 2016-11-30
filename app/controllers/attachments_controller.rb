class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.all
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  # POST /attachments.json

  def create
    @attachment = Attachment.new(attachment_params)
    product_id = params[:product_id]
    @attachment[:product_id] = product_id  unless product_id.blank?
    @attachment.update(
      user_id: params[:user_id],
      product_id: product_id, 
      file_type: params[:filetype]
    ) if params[:uploadtype].eql?('bst')
    @attachment.file_name=@attachment.get_originalfile.file_name
    p "params:#{params.to_s}"
    @attachment.rotate = true
    # respond_to do |format|
    path = "/products/#{product_id}" unless product_id.blank?
    respond_to do |format|
      if @attachment.save
        @attachment.update(file_size: @attachment.get_filesize)
        submitType = params[:submittype]
        path = submitType == "remote" ? @attachment : "/products/#{product_id}"
        format.html{ redirect_to path, notice: '上传成功.' }
      else
        format.html{ redirect_to path, notice: '上传成功.' }  
      end
    end
    
  end




  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to @attachment, notice: 'Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @attachment }
      else
        format.html { render :edit }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url, notice: 'Attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def downloadfile
    p "Downloading file ".center(50,'-')
    begin
      atta = Attachment.find(params[:id])
    rescue => e
      atta = Attachment.find(params[:id])
    end
    type = params[:type]
    path = atta.file_name_uid_url
    unless type.nil?
      if type == "large"
        path = atta.file_name_uid_url(:large)
      elsif type == "normal"
        path = atta.file_name_uid_url(:normal)
      elsif type == "small48"
        path = atta.file_name_uid_url(:small48)
      elsif type == "small32"
        path = atta.file_name_uid_url(:small32)
      elsif type == "small24"
        path = atta.file_name_uid_url(:small24)
      elsif type == "big"
        path = atta.file_name_uid_url(:big)
      else
        path = atta.file_name_uid_url(type.to_sym)
      end
    end

    # end
    begin
      if authorize_user 
        response.headers['X-Accel-Redirect'] = path
        response.headers['Content-Type'] = "application/octet-stream"
        response.headers['Content-Dispostion'] = "attachment;filename="+path
        render :nothing => true
        file_path = Rails.root.to_s + path
        send_file(file_path,filename: atta.file_name, dispostion: "inline", status: 200, stream: true, x_sendfile: true )
      else
        redirect_to product_path(atta.product_id),notice: '下载失败!!!'
        # render :file => "#{Rails.root.to_s}/public/404.html"
      end
    rescue =>e
      p e.message
    end
  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def authorize_user
      User.select(:id).map{|x| x.id}.include?(current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:file_name,:file_name_uid, :file_size,:file_type, :version, :product_id, :comment_id, :shop_id, :user_id)
    end
end
