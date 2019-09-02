require 'sinatra/base'
require 'sinatra/reloader'
require 'sass'
require 'chartkick'
require 'csv'

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

  configure :development do
    register Sinatra::Reloader
  end

  set :calculator, RiskCalculator.new

  get '/calculate' do
    @calculator = settings.calculator

    slim :index
  end

  get '/' do
    slim :info
  end

  get '/csv' do
    @calculator = settings.calculator
    content_type 'application/csv'
    attachment "#{params[:name]}.csv"
    CSV.generate do |csv|
      @calculator.rolls.each do |roll|
        csv << [roll.player1.name, roll.player2.name, roll.die1, roll.die2]
      end
    end
  end

  get '/load' do
    slim :load
  end

  get '/save' do
    slim :save
  end

  post '/load' do
    @calculator = settings.calculator
    content = params['file'][:tempfile].read
    content_arr = []
    content.each_line do |line|
        content_arr << [line]
    end
    @calculator.load_game(content_arr)
    redirect '/calculate'
  end

  post '/new_player' do
    name = params[:new_name]
    @calculator = settings.calculator

    if name && name != ''
      @calculator.find_or_add_player(name)
    end

    redirect '/calculate'
  end

  post '/roll' do
    @calculator = settings.calculator
    @calculator.run_scenario(params[:winner], params[:loser], params[:roll_one].to_i, params[:roll_two].to_i)

    redirect '/calculate'
  end

  post '/undo-roll' do
    @calculator = settings.calculator
    @calculator.undo_roll

    redirect '/calculate'
  end

  post '/random' do
    @calculator = settings.calculator
    @calculator.random_scenario(params[:players].to_i, params[:rolls].to_i)

    redirect '/calculate'
  end

  post '/clear' do
    @calculator = settings.calculator
    @calculator.clear()

    redirect '/calculate'
  end
end

MyApp.run! port: 4567 if $PROGRAM_NAME == __FILE__
