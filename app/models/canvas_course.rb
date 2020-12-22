class CanvasCourse < ApplicationRecord
  include AjAdheresToPolicy

  has_many :authentications, dependent: :destroy, inverse_of: :canvas_course

  # BEGIN these need to be defined for the controller to function
  has_many :quizzes, dependent: :destroy, class_name: 'Quizzes::Quiz', foreign_key: :context_id

  TAB_QUIZZES = nil
  # END
end
