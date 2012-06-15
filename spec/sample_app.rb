require 'sinatra/base'

class SampleApp < Sinatra::Base

  get '/' do
    params[:content]
  end

  get '/result.html' do
    <<-CONTENT
      <html>
      <head>
          <title>#{params[:title] || "We Arrive Here"}</title>
      </head>
      <body>
      <p id="greeting">Success!</p>
      </body>
      </html>
    CONTENT
  end

  post '/display_params' do
    params.map do |k, v|
      v = v.join(',') if v.is_a?(Array)
      "#{k}=#{v}"
    end.join(' ')
  end

end
