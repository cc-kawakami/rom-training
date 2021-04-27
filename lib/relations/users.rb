require 'rom'

class Users < ROM::Relation[:sql]
  schema(:users) do
    associations do
      has_many :tasks
    end

    attribute :id, Types::Serial
    attribute :name, Types::String
    attribute :email, Types::String
  end

  def alphabetical
    order { name.asc }
  end

  def by_name(name)
    where(name: name)
  end
end
