class HomeController < ApplicationController
	skip_before_action :verify_authenticity_token
	def slot
		if Time.now <= params[:attributes][:start_time]
			if params[:attributes][:end_time] >= params[:attributes][:start_time]
				@slot = Slot.create(start_time: params[:attributes][:start_time], end_time: params[:attributes][:end_time], total_capacity: params[:attributes][:total_capacity])
				if @slot.save(validate: false)
					return render json: {message: 'Solt created.'}, status: :ok
				else
					return render json: {errors: [
						{account: "You've entered incorrect details."},
					]}, status: :unprocessable_entity
				end
			else
				render json: {message: 'End time should be greaterthen the start time.'}, status: :ok
			end
		else
			render json: {message: 'Start should not be in past.'}, status: :ok
		end
	end

	def slot_collection
		if params[:attributes][:start_time].last(2) == "15" || params[:attributes][:start_time].last(2) == "30" || params[:attributes][:start_time].last(2) == "45"
			if params[:attributes][:capacity].to_i.is_a? Integer
				@slot = SlotCollection.create(start_time: params[:attributes][:start_time], slot_id: params[:attributes][:slot_id], end_time: params[:attributes][:end_time], capacity: params[:attributes][:capacity])
				if @slot.save(validate: false)
					return render json: {message: 'Solt booked.'}, status: :ok
				else
					return render json: {errors: [
						{account: "You've entered incorrect details."},
					]}, status: :unprocessable_entity
				end
		  else
        return render json: {message: "Capacity should not be float numbers."}, status: :ok
		  end
		else
			render json: {message: "Total minutes cannot be #{params[:attributes][:start_time].last(2)}."}, status: :ok
		end   
	end

	def slot_booking
		@slot = Slot.find(params[:id])
		@slot_collection = @slot.slot_collection
		if @slot_collection.present?
			render json: @slot_collection
		else
			return render json: {message: "No Slots."}, status: :ok
		end 
	end
end
