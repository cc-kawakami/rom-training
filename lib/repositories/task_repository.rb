require 'rom-repository'

class TaskRepository < ROM::Repository[:tasks]
  commands :create
end
