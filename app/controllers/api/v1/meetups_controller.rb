class Api::V1::MeetupsController < ApplicationController
  
  def index
    meetups = Meetup.all
    render json: MeetupSerializer.new(meetups)
  end

  def create
    @user = User.find(params[:user_id])
    @meetup = @user.meetups.new(meetup_params)

    if @meetup.save
      render json: MeetupSerializer.new(@meetup), status: :created
    else
      render json: { error: @meetup.errors.full_messages }, status: :unauthorized
    end
  end

  private

  def meetup_params
    params.permit(:title, :location, :start_time, :end_time, :first_date)
  end
end