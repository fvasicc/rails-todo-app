class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at

  attribute :created_at do |user|
    user && user.created_at.strftime("%d.%m.%Y. %H:%M")
  end
end
