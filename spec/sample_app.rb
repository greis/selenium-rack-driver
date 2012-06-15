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

  get '/display_params' do
    render(request, params)
  end

  post '/display_params' do
    render(request, params)
  end

  private

  def render(request, params)
    hash = {
      method: request.request_method.downcase,
      params: display_params(params)
    }
    hash.map{|k, v| "[#{k}: #{v}]" }.join
  end

  def display_params(params)
    params.map do |k, v|
      v = v.join(',') if v.is_a?(Array)
      "#{k}=#{v}"
    end.join(' ')
  end

end
