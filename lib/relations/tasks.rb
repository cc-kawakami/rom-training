require 'rom'

class Tasks < ROM::Relation[:sql]
  schema(:tasks) do
    associations do
      belongs_to :user
    end

    attribute :id, Types::Serial
    attribute :title, Types::String
    attribute :user_id, Types::ForeignKey(:user)
  end
end
