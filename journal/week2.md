# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for ruby. It is the primary way to install ruby packages (gems).

#### Install Gems

Need to create a Gemfile and define gems in that file:

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run `bundle install` command to actually install these gems.  
Gems will be installed globally (on the system - unlike nodejs which install packages in place in a folder called node_modules).  
A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bndler

Have to use `bundle exec` to run ruby scripts with rubgems installed - that's the way of setting context.

### Sinatra framework

[Sinatra](https://sinatrarb.com) is a micro web-framework for ruby to build web-apps. It's great for mock or development servers or for very simple projects - a web-app (web-server) can be created in a single file.

## Terratowns Mock Server

### Running the web server

To run the server use:

```sh
bundle install
bundle exes ruby server.rb
```

All of  the code for our server is stored in the `server.rb` file.

### Bearer Auth

[Brearer Authentication](https://swagger.io/docs/specification/authentication/bearer-authentication/) - part of an Open API Guide.

### Anatomy of a HTTP request

> HTTP REQUEST
>
> - Request Line  
>   - GET <https://terratowns.cloud/u/:user_uuid/towns/:uuid?hello=world>  
>    method     URI                                           querystring  
>    params['user_uuid', 'uuid'] (:user_uuid, :uuid are the params)
>    payload = JSON.parse(request.body.read)
> - Headers
>   - Content-Type application/json
> - Message Body
>   - {  
>       user_uuid: 't43ggs'  
>       name: ....  
>       description ...  
>     }  

