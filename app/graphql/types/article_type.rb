ArticleType = GraphQL::ObjectType.define do
  name 'Article'
  field :id, types.Int
  field :title, types.String
  field :body, types.String
  field :comments, types[CommentType] do
    preload :comments
  end
  field :image, types.String do
    resolve lambda { |obj, _args, _ctx|
      obj.image.current_path
    }
  end
end
