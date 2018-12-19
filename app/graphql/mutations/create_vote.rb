module Mutations
  class CreateVote < Mutations::BaseMutation
    argument :link_id, ID, required: true

    type Types::VoteType

    def resolve(link_id:)
      Vote.create(link: Link.find(link_id),user: context[:current_user])
    end
  end
end
