# require '../../app/models/question.rb'
require 'rails_helper'
# def self.all_questions(search_term = nil)
#   data = []
#   questions = Question.public_questions
#   if search_term.present?
#     search_term.prepend('%')
#     search_term += '%'
#     questions = questions.where("title LIKE ?", search_term)
#   end

#   questions.each do |q|
#     data << {
#       question_id: q.id,
#       title: q.title,
#       user_id: q.user_id,
#       created_at: q.created_at,
#       answers: q.answers
#     }
#   end
#   data
# end

describe Question do
  describe '#all_questions' do
    let(:question1) { instance_double(Question, title: 'This is a test', id: 1, user_id: 1, created_at: '2019-09-29', answers: nil) }
    let(:question2) { instance_double(Question, title: 'blah', id: 2, user_id: 2, created_at: '2019-09-29', answers: nil) }
    let(:public_questions) { double(ActiveRecord::Relation) }

    context 'when search term is present' do
      it 'matches to questions based on the search term' do
        allow(Question).to receive(:public_questions) { public_questions }
        allow(public_questions).to receive(:where) { [question2] }

        questions = Question.all_questions('blah')
        expect(questions).to eq(
          [{
            answers: nil,
            created_at: '2019-09-29',
            question_id: 2,
            title: "blah",
            user_id: 2
          }]
        )
      end
    end

    context 'when search term is not present' do
      it 'returns all questions' do
        allow(Question).to receive(:public_questions) { [question1, question2] }

        questions = Question.all_questions
        expect(questions).to eq(
          [
            {
              answers: nil,
              created_at: "2019-09-29",
              question_id: 1,
              title: "This is a test",
              user_id: 1
            },
            {
              answers: nil,
              created_at: '2019-09-29',
              question_id: 2,
              title: "blah",
              user_id: 2
            }
          ]
        )
      end
    end
  end
end