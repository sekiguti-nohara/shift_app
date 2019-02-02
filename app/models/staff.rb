class Staff < ApplicationRecord
	has_many :shifts

	def self.remake_staff_table
		Staff.destroy_all
		hash_data = Datum.log_in_air_shift_and_get_data
		staffs = hash_data["app"]["staffList"]["staff"]
		staffs.each do |staff|
			staff_new = Staff.new
			staff_new.air_shift_id = staff["id"]
			staff_new.name = staff["name"]["family"] + staff["name"]["first"]
			staff_new.save
		end
	end

	def self.new_staff?
		hash_data = Datum.log_in_air_shift_and_get_data
		staffs = hash_data["app"]["staffList"]["staff"]
		return staffs.count != Staff.all.count
	end
end
