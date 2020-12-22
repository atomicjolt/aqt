# This file is defined in Canvas, but at this point I'm just hardcoding
# everything because it will require bringing in lots of dependencies
module AssignmentUtil
  def self.assignment_max_name_length(_context)
    nil
  end

  def self.post_to_sis_friendly_name(_context)
    "SIS"
  end

  def self.due_date_required_for_account?(_context)
    false
  end

  def self.name_length_required_for_account?(_context)
    false
  end

  def self.sis_integration_settings_enabled?(_context)
    false
  end
end
