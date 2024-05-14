require 'sinatra'
require 'sinatra/contrib'
require 'httparty'
require 'json'
require 'zache'

class College
  def initialize(attrs={})
    @name = attrs['school.name']
    @place_url = "https://www.google.com/maps/search/?api=1&query=#{attrs['school.name']}%2C#{attrs['school.city']}"
  end

  def to_json(*attrs)
    {
      name: @name,
      place_url: @place_url
    }.to_json(*attrs)
  end
end

class CollegeSearch
  include HTTParty
  base_uri 'api.data.gov/ed/collegescorecard/v1/schools.json'

  def initialize
    @options = { query: {  api_key: ENV['CSD_API_KEY'] , fields: 'id,school.name,school.city'} }
  end

  def get_colleges(college_name, page=0)
    @options[:query].tap do |query|
      query['school.name'] = college_name
      query['page'] = page
    end
    response = JSON.parse(self.class.get('/', @options).body)

    response["results"] = response["results"].map { |sch| College.new(sch) }

    response.to_json
  end
end


def zache
  $zache ||= Zache.new
end

get '/' do
  erb :index
end

get '/colleges' do
  content_type :json
  # reverse cache results for 15 seconds. we could keep this for _way_ longer
  zache.get(params[:college_name], lifetime: 15) do
    CollegeSearch.new.get_colleges(params[:college_name], params[:page])
  end
end
