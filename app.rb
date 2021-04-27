require 'rom'
require 'rom-sql'
require_relative './lib/relations/users'
require_relative './lib/relations/tasks'
require_relative './lib/repositories/user_repository'
require_relative './lib/repositories/task_repository'

config = ROM::Configuration.new(:sql, "sqlite::memory")

config.register_relation(Users)
config.register_relation(Tasks)

rom = ROM.container(config)
gateway = rom.gateways[:default]

migration = gateway.migration do
  change do
    create_table(:users) do
      primary_key :id
      column :name , String, null: false
      column :email, String, null: false
    end
  
    create_table(:tasks) do
      primary_key :id
      foreign_key :user_id, :users
      column :title, String, null: false
    end
  end
end

migration.apply(gateway.connection, :up)

user_repo = UserRepository.new(rom)
task_repo = TaskRepository.new(rom)

user = user_repo.create(name: "Jane", email: "jane@doe.org")
task_repo.create(title: "Jane Task", user_id: user.id)
task_repo.create(title: "Fake Task", user_id: user.id)

p task_repo.by_title("Fake Task")
p user_repo.all_alphabetical_by_name_with_tasks(name: "Jane", task_title: "Fake Task")
