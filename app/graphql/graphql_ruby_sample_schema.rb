GraphqlRubySampleSchema = GraphQL::Schema.define do
  query QueryType

  use GraphQL::Batch
end
