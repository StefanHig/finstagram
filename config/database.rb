configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  

  set :database, {
    adapter: "sqlite3",
    database: "db/db.sqlite3"
  }
  else
   db = URI.parse(ENV['DATABASE_URL'] || 'postgres://bntxhwrtrzpaem:43f9ea63086381a69d6ba89b4b46c3b38f5fcf49c47a9a20b6d43b2adcd3b1a1@ec2-54-235-196-250.compute-1.amazonaws.com:5432/d5uvgs54v2rte6')
   set :database, {
    adapter: "postgresql",
    host: db.host,
    username: db.username,
    password: db.password,
    database: db.path[1..-1],
    encoding: "utf8"
   }
  end
 
  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
