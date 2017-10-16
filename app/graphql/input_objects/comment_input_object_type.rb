CommentInputObjectType = GraphQL::InputObjectType.define do
  name 'CommentInput'
  input_field :articleId, !types.ID, as: :article_id
  input_field :userId, !types.ID, as: :user_id
  input_field :comment, !types.String
end
