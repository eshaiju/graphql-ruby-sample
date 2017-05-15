MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  # Add the mutation's derived field to the mutation type
  field :addComment, field: CommentMutations::Create.field
  field :updateComment, field: CommentMutations::Update.field
end
