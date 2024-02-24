class Api::V1::MeetupsController < ApplicationController
  
  def index
    meetups = Meetup.all

    render json: MeetupSerializer.new(meetups)
  end
end