# DB setup

require 'sequel'

Sequel.connect(adapter: 'mysql2', host: 'localhost', database: 'sample_assignment_db',
               user: 'root', password: '12345678', logger: Logger.new($stdout))

Sequel::Model.plugin :association_dependencies
