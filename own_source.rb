# a program that reads it's own source code
File.open($0) do |file|
  file.each_line do |line|
    line = line.to_s
    puts line
  end
end
