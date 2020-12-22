module AjAdheresToPolicy
  def grants_right?(user, *args)
    true
  end

  def grants_any_right?(user, *args)
    true
  end
end
