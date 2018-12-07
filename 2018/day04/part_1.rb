input = File.open("./input.txt", "r").readlines().map(&:strip).sort_by { |x| x.match(/(^\[.*\])/).captures.first }

sleep_duration   = Hash.new(0)
sleep_times      = Hash.new { |h,k| h[k] = [] }
active_guard_id  = nil
action_starttime = nil

input.each do |action|
  case
    when (_, id = action.match(/\[(.*)\] Guard (#[0-9]*) begins shift/)&.captures)
      active_guard_id = id
    when (_day, _hour, minute = action.match(/\[(.*) (.*):(.*)\] falls asleep/)&.captures)
      action_starttime = minute.to_i
    when (_day, _hour, minute = action.match(/\[(.*) (.*):(.*)\] wakes up/)&.captures)
      action_duration = minute.to_i - action_starttime
      sleep_duration[active_guard_id] += action_duration
      sleep_times[active_guard_id] << action_starttime.upto(minute.to_i)
  end
end


sleepiest_guard_id, sleepiest_guard_total_sleeptime = sleep_duration.sort_by { |k, v| v }.reverse[0]

most_common_sleep_time = sleep_times[sleepiest_guard_id].map(&:to_a).flatten.group_by { |n| n }.values.max_by(&:size).first

puts "Part 1: " + (most_common_sleep_time * sleepiest_guard_id.split('#').last.to_i).to_s
# => 84636

