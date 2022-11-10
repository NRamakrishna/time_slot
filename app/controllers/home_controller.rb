class HomeController < ApplicationController
 skip_before_action :verify_authenticity_token
 def slot
  if Time.now <= params[:attributes][:start_time]
	 if params[:attributes][:end_time] >= params[:attributes][:start_time]
	  @slot = Slot.new(start_time: params[:attributes][:start_time], end_time: params[:attributes][:end_time], total_capacity: params[:attributes][:total_capacity])
		if params[:attributes][:total_capacity].to_i.is_a? Integer
		 @slot.save
		 return render json: {message: 'Solt created.'}, status: :ok
		else
		 return render json: {message: "Capacity should be integer."}, status: :ok
		end
	 else
		render json: {message: 'End time should be greater then the start time.'}, status: :ok
	 end
	else
	 render json: {message: 'Start time should not be in past.'}, status: :ok
	end
 end

 def slot_collection
	if params[:attributes][:start_time].last(2) == "15" || params[:attributes][:start_time].last(2) == "30" || params[:attributes][:start_time].last(2) == "45"
	 @slot = SlotCollection.new(start_time: params[:attributes][:start_time], slot_id: params[:attributes][:slot_id], end_time: params[:attributes][:end_time], capacity: params[:attributes][:capacity])
	 if params[:attributes][:capacity].to_i.is_a? Integer
	  @slot.save
		return render json: {message: 'Solt booked.'}, status: :ok
	 else
		return render json: {message: "Capacity should be integer."}, status: :ok
	 end
	else
	 render json: {message: "Interval cannot be #{params[:attributes][:start_time].last(2)}."}, status: :ok
	end
 end

 def slot_booking
	@slot = Slot.find_by(params[:id])
	@slot_collection = @slot.slot_collection
	if @slot_collection.present?
	 render json: @slot_collection
	else
	 return render json: {message: "No slots available."}, status: :ok
	end
 end
end
