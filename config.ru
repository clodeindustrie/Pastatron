require 'rubygems'
require "bundler/setup"
require 'sinatra'

# Disable the builtin server
disable :run

require './app/pastatron'

run Sinatra::Application
