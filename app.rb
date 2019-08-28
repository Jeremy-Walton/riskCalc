require 'sinatra/base'
require('sinatra/reloader')
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

    slim :index
  end

  post '/new_player' do
    name = params[:new_name]
    @calculator = settings.calculator
    @calculator.find_or_add_player(name)

    redirect '/'
  end

  post '/new_player' do
    name = params[:new_name]
    @calculator = settings.calculator
    @calculator.find_or_add_player(name) if name && name != ''

    redirect '/'
  end

  post '/roll' do
    raw_input = "#{params[:winner]} #{params[:loser]} #{params[:roll_one]} #{params[:roll_two]}"
    @calculator = settings.calculator
    @calculator.runScenario(raw_input)
    puts raw_input

    redirect '/'
  end
end

MyApp.run! port: 4567 if $PROGRAM_NAME == __FILE__
