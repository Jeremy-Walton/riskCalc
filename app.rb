require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require 'sinatra/reloader'

require 'chartkick'
require 'csv'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

# The routes
class App < Sinatra::Base
  set :calculator, RiskCalculator.new

  get '/calculate' do
    @calculator = settings.calculator
    @players = Player.all

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
    @calculator = settings.calculator

    player = Player.create(name: params[:new_name])
    player.save

    redirect '/calculate'
  end

  post '/roll' do
    @calculator = settings.calculator

    roll = Roll.create(risk_calculator_id: 1, winner_id: params[:winner], loser_id: params[:loser], roll1: params[:roll_one], roll2: params[:roll_two])

    if roll.save
      @calculator.run_scenario(params[:winner], params[:loser], params[:roll_one].to_i, params[:roll_two].to_i)
      redirect '/calculate'
    else
      redirect '/calculate'
    end

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
