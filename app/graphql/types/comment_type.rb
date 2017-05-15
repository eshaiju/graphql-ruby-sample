CommentType = GraphQL::ObjectType.define do
  name "Comment"
  field :id, types.Int
  field :comment, types.String
  field :user, UserType
end
