# frozen_string_literal: true

class ApplicationError < StandardError
  attr_reader :error, :code

  def initialize(code, error: nil)
    super(code)
    @code = code
    @error = error
  end

  def message
    return @error.message if @error.present?
    super
  end
  def backtrace
    return @error.backtrace if @error.present?
    super
  end
  def inspect
    return @error.inspect if @error.present?
  end
end