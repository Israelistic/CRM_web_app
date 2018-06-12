require_relative 'contact'
require 'sinatra'

get "/" do
    erb :index

end
get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

get "/about" do
  erb :about
end

get "/search" do
  erb :search
end
get "/show_contact/:id" do
 @contacts = Contact.find_by({id: params[:id].to_i})
    if @contacts != nil
    erb :show_contacts
    else
    raise Sinatra::NotFound

    end
end
after do
  ActiveRecord::Base.connection.close
end
