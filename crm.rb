require_relative 'contact'
require 'sinatra'

get "/" do
    erb :index
end

get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

get "/contacts/new" do
  erb :new
end

get "/show_contact/:id" do
 @contacts = Contact.find_by({id: params[:id].to_i})
    if @contacts != nil
    erb :show_contacts
    else
    raise Sinatra::NotFound
    end
end

post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
  redirect to('/contacts')
end

get '/contacts/:id/edit' do
  @contacts = Contact.find_by(id: params[:id].to_i)
  if @contacts
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

get "/about" do
  erb :about
end

get "/search" do
  erb :search
end




after do
  ActiveRecord::Base.connection.close
end
