require 'rom-repository'

class TaskRepository < ROM::Repository[:tasks]
  commands :create

  def by_title(title)
    tasks.by_title(title).to_a
  end
end
