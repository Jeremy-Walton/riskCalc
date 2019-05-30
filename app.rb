require 'sinatra/base'
require 'sass'

class SassHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views/stylesheets'

  get '/css/*.css' do
    filename = params[:splat].first
    scss filename.to_sym
  end
end

class JavascriptHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views/scripts'

  get "/js/*.js" do
    filename = params[:splat].first
    javascript filename.to_sym
  end
end


class MyApp < Sinatra::Base
  use SassHandler
  use JavascriptHandler

  get '/' do
    slim :index
  end
end

if __FILE__ == $0
  MyApp.run! port: 4567
end
