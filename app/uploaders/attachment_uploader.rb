# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::Test::Matchers

  include ActionView::Helpers::NumberHelper

  permissions 0666

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    product_id = model.try(:product).try(:id) || '100000'
    product_created_month =  model.try(:product).try(:created_at).try(:strftime,"%Y%m") || '198812'
    if model.file_type.eql?("photo")
      "uploads/photo/#{model.created_at.strftime("%Y%m")}/#{model.id}"
    else
      "uploads/#{product_created_month }/#{product_id}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.created_at.strftime("%Y%m")}/#{model.id}"
    end
  end


  version :small24, :if => :is_image? do
    process :resize_to_fill => [24, 24]
  end

  version :small32, :if => :is_image? do  # version :normal, if: :is_image? do
    process :resize_to_fill => [32, 32]
  end

  version :small48, :if => :is_image? do  # version :normal, if: :is_image? do
    process :resize_to_fill => [48, 48]
  end

  version :small96, :if => :is_image? do  # version :normal, if: :is_image? do
    process :resize_to_fill => [96, 96]
  end

  version :normal, :if => :is_image? do
    process :resize_to_fill => [165, 107]
  end

  version :big, :if => :is_image? do
    process :resize_to_fill => [720,600]
  end

  # process :rotate_img #, :if => model.rotate.present and model.rotate?
  #
  # def rotate_img
  #   manipulate! do |img|
  #     img.rotate "90>"
  #     img
  #   end
  # end


  process :auto_orient,:if => :is_image? # this should go before all other "process" steps

  def auto_orient
    manipulate! do |image|
      image.tap(&:auto_orient)
    end
  end

  def is_image? file
    image_exts.include?(file.extension.downcase)
  end

  def image_exts
    %w(jpg jpeg gif png bmp) #["jpg","jpeg","gif","png"]
  end

  AttachmentUploader.enable_processing = true

  # AvatarUploader.enable_processing = true

  # Add a white list of extensions which are allowed to be uploaded.
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  # For images you might use something like this:
  #指定上传文件的格式
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  def filename
    if super.present?
      # current_path 是 Carrierwave 上传过程临时创建的一个文件，有时间标记，所以它将是唯一的
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension.downcase}"
    end
  end

  def get_originalfile
    model.file_name = original_filename
    return model
  end

  def get_filesize
    begin
      fileSize =File.size(File.expand_path(__FILE__).split('/')[0..-4].join('/')+model.file_name_uid.to_s)
    rescue =>e
      Rails.logger.error e.message
      fileSize = 0
    end
  end

  def get_original_filename
    original_filename
  end
end
