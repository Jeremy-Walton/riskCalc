require './app'
require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

Rack::Handler.default.run(App, Port: 4567)
