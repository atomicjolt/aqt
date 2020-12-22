class CanvasCourse < ApplicationRecord
  has_many :authentications, dependent: :destroy, inverse_of: :canvas_course

  # BEGIN these need to be defined for the controller to function
  has_many :quizzes, dependent: :destroy, class_name: 'Quizzes::Quiz', foreign_key: :context_id

  TAB_QUIZZES = nil

  # This should come from the adheres_to_policy gem
  def grants_right?(user, *args)
    true
  end
  # END
end
