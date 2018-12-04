input = File.open("./input.txt", "r").readlines().map(&:strip).sort_by { |x| x.match(/(^\[.*\])/).captures.first }

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
      sleep_times[active_guard_id] << action_starttime.upto(minute.to_i).to_a
  end
end

zzz = sleep_times.map { |x, y|
  sleep_mins = y.flatten.sort.group_by {|n| n }.values.max_by(&:size)

  [x, [sleep_mins.first, sleep_mins.length]]
}.sort_by { |x| x.last.last }.last

puts zzz[0].split("#").last.to_i * zzz[1][0].to_i

