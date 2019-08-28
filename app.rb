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
    @calculator.runScenario('Jeremy Josh 3 1')
    slim :index
  end

  post '/new_player' do
    name = params[:new_name]
    @calculator = settings.calculator
    @calculator.find_or_add_player(name)
    redirect '/'
  end

  post '/roll' do
    @num1 = params[:roll_one]
    @num2 = params[:roll_two]
    @winner = params[:winner]
    @loser = params[:loser]
    @rawInput = "#{@winner} #{@loser} #{@num1} #{@num2}"
    puts @rawInput
    @calculator = settings.calculator
    @calculator.runScenario(@rawInput)
    redirect '/'
  end
end

if __FILE__ == $0
  MyApp.run! port: 4567
end
