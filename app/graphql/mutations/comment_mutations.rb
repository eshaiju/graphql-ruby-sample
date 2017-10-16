# encoding: utf-8
module CommentMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'AddComment'

    # Define input parameters
    # input_field :articleId, !types.ID
    # input_field :userId, !types.ID
    # input_field :comment, !types.String
    input_field :comment, !CommentInputObjectType

    # Define return parameters
    return_field :article, ArticleType
    return_field :errors, types.String

    resolve lambda {|_object, inputs, _ctx|
      article = Article.find_by_id(inputs[:comment][:article_id])
      return { errors: 'Article not found' } if article.nil?

      comments = article.comments
      new_comment = comments.build(inputs[:comment].to_h)
      if new_comment.save
        { article: article }
      else
        { errors: new_comment.errors.to_a }
      end
    }
  end

  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateComment'

    # Define input parameters
    input_field :id, !types.ID
    input_field :comment, !CommentInputObjectType


    # Define return parameters
    return_field :comment, CommentType
    return_field :errors, types.String

    resolve lambda { |_object, inputs, _ctx|
      comment = Comment.find_by_id(inputs[:id])
      return { errors: 'Comment not found' } if comment.nil?

      if comment.update_attributes(inputs[:comment].to_h)
        { comment: comment }
      else
        { errors: comment.errors.to_a }
      end
    }
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyComment'
    description 'Delete a comment and return post and deleted comment ID'

    # Define input parameters
    input_field :id, !types.ID

    # Define return parameters
    return_field :deletedId, !types.ID
    return_field :article, ArticleType
    return_field :errors, types.String

    resolve lambda { |_obj, inputs, _ctx|
      comment = Comment.find_by_id(inputs[:id])
      return { errors: 'Comment not found' } if comment.nil?

      article = comment.article
      comment.destroy

      { article: article.reload, deletedId: inputs[:id] }
    }
  end
end
