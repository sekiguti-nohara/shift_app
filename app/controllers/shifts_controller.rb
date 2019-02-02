class ShiftsController < ApplicationController
	def index
		@shifts = Shift.where(date: Date.today)
	end

	def create
		Staff.remake_staff_table if Staff.new_staff?
		today_shifts = Shift.get_today_shifts
		binding.pry
		today_shifts.each do |shift|
			shift_new = Shift.new
			shift_new.staff_id = Staff.find_by(air_shift_id: shift["staffId"]).id
			shift_new.start,shift_new.end = Shift.parse_shift_time(shift)
			shift_new.date = Date.today
			shift_new.kind_of_work = shift["groupId"].to_i
			shift_new.save
		end
		redirect_to shifts_path
	end
end
