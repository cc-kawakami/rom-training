require 'rom-repository'

class UserRepository < ROM::Repository[:users]
  commands :create

  def all_alphabetical_by_name_with_tasks(name:, task_title:)
    users
      .alphabetical
      .by_name(name)
      .combine(:tasks)
      .node(:tasks) { |tasks| tasks.by_title(task_title) }
      .to_a
  end
end
