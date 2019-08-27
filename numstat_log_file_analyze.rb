target_file = ARGV[0]

summary_result = {}
File.open(target_file) do |file|
  author, commit_hash = nil, nil
  file.each_line do |line|
    if line.start_with?('commit')
      m = line.match(/^commit-----"(?<commit_hash>\w+)"-----"(?<commit_date>\d{4}-\d{2}-\d{2})"-----"(?<author>.*)"-----".*"-----".*"/)
      author = m[:author].strip
      summary_result[author] ||= {add: 0, deletion: 0}
      commit_hash = m[:commit_hash]
    elsif m = line.match(/(?<addition>\d+)\t(?<deletion>\d+)\t(?<file_path>.*)/)
      summary_result[author][:add] += m[:addition].to_i
      summary_result[author][:deletion] += m[:deletion].to_i
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
