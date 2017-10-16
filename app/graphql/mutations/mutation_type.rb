MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  # Add the mutation's derived field to the mutation type
  field :addComment, field: CommentMutations::Create.field
  field :updateComment, field: CommentMutations::Update.field
  field :destroyComment, field: CommentMutations::Destroy.field
  field :addArticle, field: ArticleMutations::Create.field
  field :updateArticle, field: ArticleMutations::Update.field
  field :destroyArticle, field: ArticleMutations::Destroy.field
end
