require 'rubygems'
require "bundler/setup"
require 'sinatra'

# Disable the builtin server
disable :run

require './app/pastotron'

run Sinatra::Application
