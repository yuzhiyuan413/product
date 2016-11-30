module AttachmentsHelper
  #attachment:附件本身
  #tagtype: 'link'=图片所略图和弹出预览,'download'=图片缩略图和下载,'image'=只展示图片
  def image_attach_to(attachment, tagtype='image', html_options ={})
    paths = attachment.show_attaimg_paths
    imgPath = paths[0] #原图
    simgPath = paths[1] #缩略图
    showPath = paths[2] #是否支持弹出原图(仅图片格式支持)
    if 'link'.eql?(tagtype)
      link_to(image_tag(simgPath,html_options),downloadfile_path(attachment),class: "lightbox",rel: "lightbox",title: attachment.file_name)
    elsif 'download'.eql?(tagtype)
      link_to(image_tag(simgPath,html_options),downloadfile_path(attachment),class: "color_green_0")
    elsif 'show'.eql?(tagtype)
      link_to(image_tag(imgPath,html_options),downloadfile_path(attachment),class: "lightbox",rel: "lightbox",title: attachment.file_name)
    elsif 'image'.eql?(tagtype)
      if showPath
        image_tag(simgPath,html_options)
      else
        image_tag(imgPath,html_options)
      end
    end
  end

end
