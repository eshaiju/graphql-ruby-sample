UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, types.Int
  field :name, types.String
  field :email, types.String
  field :comments, types[CommentType] do
    preload :comments
    #resolve -> (user, args, ctx) { Comment.where(user_id: user.id) }
  end
end
