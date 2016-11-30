class Attachment < ActiveRecord::Base
  # resourcify
  belongs_to :account
  belongs_to :user
  belongs_to :product,touch: true,counter_cache: true
  belongs_to :shop, touch: true
  has_many :comments

  mount_uploader :file_name_uid, AttachmentUploader

  attr_accessor :rotate
  after_save :rotate_image, if: ->(obj){ obj.rotate.present? } #and obj.rotate? }

  def rotate_image
    self.file_name_uid.recreate_versions!
  end

  def get_originalfile
     file_name_uid.get_originalfile
  end

  def get_filesize
     file_name_uid.get_filesize
  end

  def show_attaimg_paths
    suffix = file_name_uid.to_s.rindex(".")
    atType = file_name_uid.to_s[suffix.to_i+1,file_name_uid.to_s.length]
    imgPath = ""
    simgPath = ""
    showPath = false
    paths = Array.new
    case atType.to_s.downcase
      when "jpg","gif","bmp","jpeg","png"
        imgPath = "/attachments/#{id}/downloadfile"
        simgPath = "/attachments/#{id}/downloadfile/normal"
        showPath = true
      when "ppt","pptx"
        simgPath= imgPath = "icon-ppt.png"
      when "rar"
        simgPath= imgPath = "icon-rar.png"
      when "zip"
        simgPath= imgPath = "icon-zip.png"
      when "pdf"
        simgPath= imgPath = "icon-pdf.png"
      when "doc","odt"
        simgPath= imgPath = "icon-word.png"
      when "xls","ods"
        simgPath= imgPath = "icon-xls.png"
      when "txt"
        simgPath= imgPath = "icon-txt.png"
      when "avi"
        simgPath= imgPath = "icon-avi.png"
      when "css"
        simgPath= imgPath = "icon-css.png"
      when "csv"
        simgPath= imgPath = "icon-csv.png"
      when "dmg"
        simgPath= imgPath = "icon-dmg.png"
      when "docx"
        simgPath= imgPath = "icon-docx.png"
      when "dwg"
        simgPath= imgPath = "icon-dwg.png"
      when "exe"
        simgPath= imgPath = "icon-exe.png"
      when "html"
        simgPath= imgPath = "icon-html.png"
      when "iso"
        simgPath= imgPath = "icon-iso.png"
      when "jar"
        simgPath= imgPath = "icon-jar.png"
      when "java"
        simgPath= imgPath ="icon-java.png"
      when "js"
        simgPath= imgPath = "icon-js.png"
      when "jsp"
        simgPath= imgPath = "icon-jsp.png"
      when "key"
        simgPath= imgPath = "icon-key.png"
      when "mov"
        simgPath= imgPath = "icon-mov.png"
      when "mp3"
        simgPath= imgPath = "icon-mp3.png"
      when "mp4"
        simgPath= imgPath = "icon-mp4.png"
      when "pkg"
        simgPath= imgPath = "icon-pkg.png"
      when "pps"
        simgPath= imgPath = "icon-pps.png"
      when "psd"
        simgPath= imgPath = "icon-psd.png"
      when "rb"
        simgPath= imgPath = "icon-rb.png"
      when "rm"
        simgPath= imgPath = "icon-rm.png"
      when "wav"
        simgPath= imgPath = "icon-wav.png"
      when "xlsx"
        simgPath= imgPath = "icon-xlsx.png"
      when "xml"
        simgPath= imgPath = "icon-xml.png"
      when "yml"
        simgPath= imgPath = "icon-yml.png"
      when "conf"
        simgPath= imgPath = "icon-conf.png"
      when "ini"
        simgPath= imgPath ="icon-ini.png"
      else
        simgPath= imgPath = "icon-nothing.png"
    end
    paths[0] = imgPath
    paths[1] = simgPath
    paths[2] = showPath
    return paths
  end

  def display_name
    self.file_name
  end
end
