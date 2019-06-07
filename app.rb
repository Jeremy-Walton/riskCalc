require 'sinatra/base'
require 'sass'

require_relative 'risk_calculator'

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

  set :calculator, RiskCalculator.new

  get '/' do
    @calculator = settings.calculator
    @calculator.runScenario('Jeremy Josh 3 1') # This populates the players so you can actually see something
    slim :index
  end
end

if __FILE__ == $0
  MyApp.run! port: 4567
end
