class SlotCollection < ApplicationRecord
	has_many :slot, class_name: 'Slot'
end
