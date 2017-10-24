GraphqlRubySampleSchema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType

  use GraphQL::Batch
  enable_preloading
  max_depth 12
  max_complexity 1000
end

GraphqlRubySampleSchema.middleware << GraphQL::Schema::TimeoutMiddleware.new(max_seconds: 10) do |err, query|
  Rails.logger.info("GraphQL Timeout: #{query.query_string}")
end

log_query_complexity = GraphQL::Analysis::QueryComplexity.new { |query, complexity| Rails.logger.info("[GraphQL Query Complexity] #{complexity}")}
GraphqlRubySampleSchema.query_analyzers << log_query_complexity

GraphqlRubySampleSchema.query_analyzers << GraphQL::Analysis::FieldUsage.new { |query, used_fields, used_deprecated_fields|
  puts "Used GraphQL fields: #{used_fields.join(', ')}"
  puts "Used deprecated GraphQL fields: #{used_deprecated_fields.join(', ')}"
}
