class NotificationRelayJob < ApplicationJob
  sidekiq_options retry: false

  def perform(chatarea_user_ids, sender_name, channel_name, body)
    chatarea_user_ids.each do |user_id|
      ActionCable.server.broadcast "users:#{user_id}", {
        title: "#{sender_name} has sent a message in #{channel_name}",
        body: body
      }
    end
  end
end
