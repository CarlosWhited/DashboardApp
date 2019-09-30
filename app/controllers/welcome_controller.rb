class WelcomeController < ApplicationController
  def index
    @num_users = User.all.count
    @num_questions = Question.all.count
    @num_answers = Answer.all.count
    @tenant_request_counts = Tenant.all.order(request_count: :desc).map { |t| {name: t.name, request_count: t.request_count} }
  end
end
