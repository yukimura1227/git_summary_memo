target_file = ARGV[0]

summary_result = {}
File.open(target_file) do |file|
  file.each_line do |line|
    puts line
    if m = line.match(/(?<commit_hash>\w+)\s(?<file_path>.*)\s*\((?<author>.*)\s*(?<commit_year>\d{4})-(?<commit_month>\d{2})-(?<commit_day>\d{2})\s+(?<line_number>\d+)\)\s(?<contents>.*)/)
      author = m[:author].strip
      summary_result[author] ||= 0
      summary_result[author] += 1
    else
      STDERR.puts '!' * 10 + 'cannot match' + '!' * 10
      STDERR.puts line
      STDERR.puts '!' * 30
    end
  end

  summary_result.each do |author, value|
    puts "#{author} => #{value}"
  end
end
