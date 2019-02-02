class Shift < ApplicationRecord
	belongs_to :staff

	def self.get_today_shifts
		hash_data = Datum.log_in_air_shift_and_get_data
		shifts = hash_data["app"]["monthlyshift"]["shift"]["shifts"]
		today_shifts = shifts.select { |shift| shift["date"] == Date.today.strftime("%Y%m%d") }
		return today_shifts
	end

	def self.parse_shift_time(shift)
		start_hour = shift["workTime"]["text"][-13,2].to_i
		start_minute = shift["workTime"]["text"][-10,2].to_i
		end_hour = shift["workTime"]["text"][-5,2].to_i
		end_minute = shift["workTime"]["text"][-2,2].to_i
		today = Date.today
		start_time = DateTime.new(today.year,today.month,today.day,start_hour,start_minute,0,'+09:00')
		end_time = DateTime.new(today.year,today.month,today.day,end_hour,end_minute,0,'+09:00')
		return start_time,end_time
	end
end
