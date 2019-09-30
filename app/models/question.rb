class Question < ActiveRecord::Base

  has_many :answers
  belongs_to :user

  scope :public_questions ,-> { where(private: false) }

  def self.all_questions(search_term = nil)
    data = []
    questions = Question.public_questions
    if search_term.present?
      search_term.prepend('%')
      search_term += '%'
      questions = questions.where("title LIKE ?", search_term)
    end

    questions.each do |q|
      data << {
        question_id: q.id,
        title: q.title,
        user_id: q.user_id,
        created_at: q.created_at,
        answers: q.answers
      }
    end
    data
  end

end
