require 'mime/types'

module SeleniumRackDriver
  class FileField < FormField

    def field_value
      return if native[:value].to_s.empty?
      if form.multipart?
        content_type = MIME::Types.type_for(native[:value]).first.to_s
        Rack::Test::UploadedFile.new(native[:value], content_type)
      else
        File.basename(native[:value])
      end
    end

    private

    def form
      first(:ancestors, 'form')
    end

  end
end
