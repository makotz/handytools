class Questions::create
  include Virtus.model

  attribute :params, Hash
  attribute :user, user

  def call
    @question      = Question.new params
    @question.user = user

    if @question.save
       send_tweet if @question.tweet_it
      true
    else
      false
    end

  private

  def send_tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = current_user.twitter_token
      config.access_token_secret = current_user.twitter_secret
    end
    client.update "#Question: #{@question.title} #{question_url(@question)}"
  end

end
