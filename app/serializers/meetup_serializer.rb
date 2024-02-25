class MeetupSerializer
  include JSONAPI::Serializer
  attributes :title, :location, :start_time, :end_time, :first_date
end