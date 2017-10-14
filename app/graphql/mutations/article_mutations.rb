# encoding: utf-8
module ArticleMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'AddArticle'

    input_field :article, !ArticleInputObjectType

    # Define return parameters
    return_field :article, ArticleType
    return_field :errors, types.String

    resolve lambda { |object, inputs, ctx|
      article = Article.new(inputs[:article].to_h)

      if article.save
        { article: article }
      else
        { errors: article.errors.to_a }
      end
    }
  end
end
