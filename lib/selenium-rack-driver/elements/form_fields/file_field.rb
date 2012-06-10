require 'mime/types'

module SeleniumRackDriver
  class FileField < FormField

    def field_value
      if form.multipart?
        content_type = MIME::Types.type_for(native[:value]).first.to_s
        Rack::Test::UploadedFile.new(native[:value], content_type)
      else
        File.basename(native[:value])
      end
    end

    def valid_for_submission?(button)
      !native[:value].to_s.empty?
    end

  end
end
