require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      # require 'pry'; binding.pry
      application = TrafficSpy::Application.new({ identifier_name: params[:identifier], root_url: params[:rootUrl] })

      # TrafficSpy::Application.create({ identifier_name: params[:identifier], root_url: params[:rootUrl] })
      if application.save 
        status 200
        body JSON.generate(params.select { |k, v| k == 'identifier' })
      else 
        status 400
        body "No identifier provided."
      end
    end

    not_found do
      erb :error
    end
  end
end
