class Course < ApplicationRecord
  include AjAdheresToPolicy

  # BEGIN these need to be defined for the controller to function
  has_many :quizzes, dependent: :destroy, class_name: 'Quizzes::Quiz', foreign_key: :context_id

  TAB_QUIZZES = nil

  def feature_enabled?(_feature)
    false
  end
  # END
end
