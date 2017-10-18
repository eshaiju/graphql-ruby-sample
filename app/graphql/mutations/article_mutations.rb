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

  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateArticle'

    # Define input parameters
    input_field :id, !types.ID
    input_field :article, !ArticleInputObjectType

    # Define return parameters
    return_field :article, ArticleType
    return_field :errors, types.String

    resolve lambda { |_object, inputs, _ctx|
      article = Article.find_by_id(inputs[:id])
      return { errors: 'Article not found' } if article.nil?
      if article.update_attributes(inputs[:article].to_h)
        { article: article }
      else
        { errors: article.errors.to_a }
      end
    }
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyArticle'
    description 'Delete a article and return  deleted article ID'

    # Define input parameters
    input_field :id, !types.ID

    # Define return parameters
    return_field :deletedId, !types.ID
    return_field :errors, types.String

    resolve lambda { |_obj, inputs, _ctx|
      article = Article.find_by_id(inputs[:id])
      return { errors: 'Article not found' } if article.nil?

      article.destroy
      { deletedId: inputs[:id] }
    }
  end
end
