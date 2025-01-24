class PublishedScheduledPostsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Post.scheduled.where('publish_at <= ?',Time.current).update_all(published: true)
  end
end
