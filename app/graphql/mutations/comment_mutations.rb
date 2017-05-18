# encoding: utf-8
module CommentMutations
  Create = GraphQL::Relay::Mutation.define do
    name "AddComment"

    # Define input parameters
    input_field :articleId, !types.ID
    input_field :userId, !types.ID
    input_field :comment, !types.String

    # Define return parameters
    return_field :article, ArticleType
    return_field :errors, types.String

    resolve ->(object, inputs, ctx) {
      article = Article.find_by_id(inputs[:articleId])
      return { errors: 'Article not found' } if article.nil?

      comments = article.comments
      new_comment = comments.build(user_id: inputs[:userId], comment: inputs[:comment])
      if new_comment.save
        { article: article }
      else
        { errors: new_comment.errors.to_a }
      end
    }
  end

  Update = GraphQL::Relay::Mutation.define do
    name "UpdateComment"

    # Define input parameters
    input_field :id, !types.ID
    input_field :comment, types.ID
    input_field :userId, types.ID
    input_field :articleId, types.ID

    # Define return parameters
    return_field :comment, CommentType
    return_field :errors, types.String

    resolve ->(object, inputs, ctx) {
      comment = Comment.find_by_id(inputs[:id])
      return { errors: 'Comment not found' } if comment.nil?

      valid_inputs = ActiveSupport::HashWithIndifferentAccess.new(inputs.instance_variable_get(:@original_values).select { |k, _| comment.respond_to? "#{k}=".underscore }).except(:id)
      if comment.update_attributes(valid_inputs)
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

    resolve ->(_obj, inputs, ctx) {
      comment = Comment.find_by_id(inputs[:id])
      return { errors: 'Comment not found' } if comment.nil?

      article = comment.article
      comment.destroy

      { article: article.reload, deletedId: inputs[:id] }
    }
  end
end
