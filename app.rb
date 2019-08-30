require 'sinatra/base'
require 'sass'
require 'chartkick'

require_relative 'models/risk_calculator'

# Parse Sass styles
class SassHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views/stylesheets'

  get '/css/*.css' do
    filename = params[:splat].first
    scss filename.to_sym
  end
end

# Parse Javascript styles
class JavascriptHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views/scripts'

  get "/js/*.js" do
    filename = params[:splat].first
    javascript filename.to_sym
  end
end

# The routes
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

    if name && name != ''
      @calculator.find_or_add_player(name)
    end

    redirect '/'
  end

  post '/roll' do
    @calculator = settings.calculator
    @calculator.run_scenario(params[:winner], params[:loser], params[:roll_one].to_i, params[:roll_two].to_i)

    redirect '/'
  end

  post '/undo-roll' do
    @calculator = settings.calculator
    @calculator.undo_roll

    redirect '/'
  end

  post '/random' do
    @calculator = settings.calculator
    @calculator.random_scenario(4, 200)

    redirect '/'
  end
end

MyApp.run! port: 4567 if $PROGRAM_NAME == __FILE__
