module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :links, [Types::LinkType], null: true
    field :votes, [Types::VoteType], null: true
  end
end
