ArticleInputObjectType = GraphQL::InputObjectType.define do
  name 'ArticleInput'
  input_field :title, !types.String
  input_field :body, !types.String
end
