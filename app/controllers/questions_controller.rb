class QuestionsController < ApplicationController
  def index
    tenant = Tenant.where(api_key: params[:api_key]).first if params[:api_key]
    if tenant.present? && !tenant.should_throttle?
      collection = Question.all_questions(params[:search_term])
      tenant.log_request(params[:search_term])
      render :json => collection.to_json
    else
      render json: {'status': 'unauthorized'}, status: :unauthorized
    end
  end
end
