require 'rom-repository'

class UserRepository < ROM::Repository[:users]
  commands :create

  def with_tasks
    users.join(:tasks)
  end
end
