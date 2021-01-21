class Course < ApplicationRecord
  include AjAdheresToPolicy

  # BEGIN these need to be defined for the controller to function
  has_many(
    :quizzes,
    -> { order("lock_at, title, id") },
    class_name: "Quizzes::Quiz",
    as: :context,
    inverse_of: :context,
    dependent: :destroy,
  )

  TAB_QUIZZES = nil

  def feature_enabled?(_feature)
    false
  end
  # END
end
