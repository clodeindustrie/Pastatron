require 'rubygems'
require 'sinatra'
require 'haml'
require 'dm-core'
require 'dm-validations'
require 'dm-migrations/adapters/dm-sqlite-adapter'
require "dm-migrations"
require "dm-serializer"
require "json"
require "albino"

#
### CONFIGURATION
#

configure :development do
    DataMapper.setup(:default, 'sqlite3:db/pastotron.db')
    set :logging, true
    set :raise_errors, true
    DataMapper::Logger.new(STDOUT, :debug)
end

configure :production do
    # DataMapper.setup(:default, ENV['DATABASE_URL'])

    # set :raise_errors, true
end

#
# #
# ### MODELS
# #
#

class Pasta
  include DataMapper::Resource

  property :id,       Serial
  property :content,  Text
  property :paster,   String
  property :title,    String
  property :language, String

  property :created_at, DateTime
  property :updated_at, DateTime

end

DataMapper.finalize


# create a pasta
post '/pasta' do
  params[:updated_at] = params[:created_at]= Time.now
  p = Pasta.new(params)
  if !p.save
    @message = "no Worky"
    haml :index
  else
    redirect "/pasta/#{p.id}"
  end
end

get '/' do
  haml :index
end

get '/list' do
  @ps = Pasta.all
  haml :list
end

# get a pasta
get '/pasta/:id' do
    @p = Pasta.first(:id => params[:id])
    haml :pasta
end

# Delete a Pasta
delete '/pasta/:id' do
    p = Pasta.first(params)

    if !p.nil?
        p.destroy
    end
end
