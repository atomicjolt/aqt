# need to decide if I'm brining this file in or not
class ActiveRecord::Base
  def self.maximum_text_length
    @maximum_text_length ||= 64.kilobytes - 1
  end

  def self.maximum_long_text_length
    @maximum_long_text_length ||= 500.kilobytes - 1
  end

  def self.maximum_string_length
    255
  end

  def self.set_policy; end
end
