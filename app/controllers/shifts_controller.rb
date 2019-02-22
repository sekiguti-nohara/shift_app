class ShiftsController < ApplicationController
	def index
		@shifts = Shift.where(date: Date.today).includes(:staff) #staffをincludeしておくことにより、N+1問題を解決
	end

	# その日のシフトを保存する
	def create
		Staff.remake_staff_table if Staff.staff_updated?
		today_shifts = Shift.get_today_shifts
		Shift.where(date: Date.today).destroy_all if Shift.last.date == Date.today
		today_shifts.each do |shift|
			shift_new = Shift.new
			shift_new.staff_id = Staff.find_by(air_shift_id: shift["staffId"]).id
			shift_new.parse_shift_time(shift)
			shift_new.date = Date.today
			shift_new.content_of_work = shift["groupId"].to_i
			shift_new.save
		end
		redirect_to shifts_path
	end
	
	private
	def shift_params
		params.require(:shift).permit(:start, :end ,:kind_of_work)
	end
end
