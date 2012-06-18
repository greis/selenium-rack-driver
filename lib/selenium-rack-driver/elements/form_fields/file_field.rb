require 'mime/types'

module SeleniumRackDriver
  class FileField < FormField

    def field_value
      if form.multipart?
        content_type = MIME::Types.type_for(self[:value]).first.to_s
        Rack::Test::UploadedFile.new(self[:value], content_type)
      else
        File.basename(self[:value])
      end
    end

    def valid_for_submission?(button)
      super && !self[:value].to_s.empty?
    end

  end
end
