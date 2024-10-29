class TodoSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :completed, :important

  attribute :created_at do |todo|
    todo && todo.created_at&.strftime("%d.%m.%Y. %H:%M")
  end

  attribute :completed_at do |todo|
    todo && todo.completed_at&.strftime("%d.%m.%Y. %H:%M")
  end

  attribute :date do |todo|
    todo && todo.date&.strftime("%d.%m.%Y.")
  end
end
