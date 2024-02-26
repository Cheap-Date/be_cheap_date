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

  def update
    @user = User.find(params[:user_id])
    @user_meetup = @user.meetups.find(params[:id])
    if @user_meetup.update(meetup_params)
      render json: MeetupSerializer.new(@user_meetup)
    else
      render json: { error: @user_meetup.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @meetup = Meetup.find(params[:id])
    @meetup.destroy!
  end
  

  private

  def meetup_params
    params.permit(:title, :location, :start_time, :end_time, :first_date)
  end
end