require 'sinatra'
require 'sinatra/partial'
require 'rack-flash'
require_relative './helpers/current'
require_relative './data_mapper_setup'
require_relative './controllers/homepage'
require_relative './controllers/new_user'
require_relative './controllers/existing_user'
require_relative './controllers/peeps'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
set :partial_template_engine, :erb

#Add a view that if the user is already signed in they see logout button instead of the sign in form