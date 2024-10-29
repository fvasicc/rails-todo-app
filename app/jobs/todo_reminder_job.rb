class TodoReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    begin
      todos = Todo.where(important: true, date: Date.today)
      todos.each do |todo|
        Rails.logger.info "IMPORTANT TODO: #{todo.id}"
      end
    rescue StandardError => e
      Rails.logger.error "Error sending bulk emails: #{e.message}"
      raise e
    end
  end
end
