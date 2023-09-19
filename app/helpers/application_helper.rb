module ApplicationHelper
  def server_time_run
    DateTime.now.strftime("%d-%m-%Y %H:%M")
  end

  def time_now
    Time.now
  end

  # @sinatra-flash errors format
  def sinatra_flash_error(object)
    object.errors.full_messages
  end
end
