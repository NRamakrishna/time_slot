class Slot < ApplicationRecord
	has_many :slot_collection, class_name: 'SlotCollection'
end