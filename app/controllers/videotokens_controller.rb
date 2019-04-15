class VideotokensController < ApplicationController
  def create
    # Define User Identity
    # identity = current_user.first_name

    identity = current_user.teachers.empty? ? "#{current_user.first_name} from #{current_user.professionals.first.company}" : current_user.first_name

    # Create Video grant for our token
    video_grant = Twilio::JWT::AccessToken::VideoGrant.new
    video_grant.room = 'premium chat'

    # Create an Access Token
    token = Twilio::JWT::AccessToken.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_API_KEY'],
      ENV['TWILIO_API_SECRET'],
      [video_grant],
      identity: identity
    )

    # Generate the token and send to client
    render json: { identity: identity, token: token.to_jwt }
  end
end
