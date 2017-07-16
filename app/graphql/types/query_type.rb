QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"

  field :acticle do
    type ArticleType
    argument :id, !types.ID
    description "Find a Article by ID"
    resolve ->(obj, args, ctx) { Article.find_by_id(args["id"]) }
  end

  field :latest_articles, types[ArticleType] do
    argument :limit, types.Int, default_value: Article::DEFAULT_LIMIT
    resolve ->(obj, args, ctx) { Article.limit(args[:limit]) }
  end
end
