@center_by = 60
@students = []

# method printing just the header
def print_header
  puts "The students of Villians Academy".center(@center_by)
  puts "-------------".center(@center_by)
end

# method printing the student name and cohort using .each_with_index
def print_students_list
#### MISSING SORTING BY COHORT
if @students.count > 1
  @students.sort!{|x, y| x[:cohort]<=> y[:cohortß]}
end
    @students.each_with_index do |student, index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(@center_by)
    end

end

# method to print the footer
def print_footer
    @students.count==1 ? final_word = "student":final_word = "students"
    puts "Overall, we have #{@students.count} great #{final_word}".center(@center_by)
end

# method to get the cohort value from the user
def get_cohort
  puts "And the cohort?"
  cohort = STDIN.gets.chomp
  cohort = default if cohort.empty?
  value = cohort
  month = value.include?("January")||value.include?("February")||value.include?("March")||value.include?("April")||value.include?("May")||value.include?("June")||value.include?("July")||value.include?("August")||value.include?("September")||value.include?("October")||value.include?("November")||value.include?("December")
  while !month
    puts "That isn't a month....the cohort?"
    cohort = STDIN.gets.chomp
    cohort = "November" if cohort.empty?
    value = cohort
    month = value.include?("January")||value.include?("February")||value.include?("March")||value.include?("April")||value.include?("May")||value.include?("June")||value.include?("July")||value.include?("August")||value.include?("September")||value.include?("October")||value.include?("November")||value.include?("December")
  end
  return cohort
end

# method to get input from user to define the students hash
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice for name input"
  name = STDIN.gets.chomp
  while !name.empty?  do
    cohort = get_cohort
    @students <<  {name: name, cohort: cohort, country_of_birth: :unknown, height: :unknown, hobbies: :unknown}
    puts "Now we have #{@students.count} students"
    puts "Another name?"
    name = STDIN.gets.chomp
  end
end

# method to print the interactive menu
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

# method to show the list of students
def show_students
  print_header
  print_students_list
  print_footer
end

# method to process the selection made by the user in interactive menu
def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

# method to run the interactive menu
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

# method to save the students array into a file students.csv
def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

# method to load the students from the students.csv file
def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
