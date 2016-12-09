@center_by = 60
@students = []

require 'csv'

# method printing just the header
def print_header
  puts "The students of Villians Academy".center(@center_by)
  puts "-------------".center(@center_by)
end

# method printing the student name and cohort using .each_with_index
def print_students_list
  @students.each_with_index do |student, index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(@center_by)
  end
end

# method to print the footer
def print_footer
    @students.count==1 ? final_word = "student" : final_word = "students"
    puts "Overall, we have #{@students.count} great #{final_word}".center(@center_by)
end

# method to check if string input is one of the entries of the array values
def check_input(input, values)
  input_ok = false
  values.each do |value|
      input_ok = true if input.include?(value)
  end
  return input_ok
end

# method to get cohort or put to default
def get_cohort
  cohort = STDIN.gets.chomp
  cohort = "November" if cohort.empty?
  return cohort
end

# method to get the cohort value from the user and check it, if not okay loop
def get_and_check_cohort
  cohorts = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  puts "And the cohort?"
  cohort = get_cohort
  input_ok = check_input(cohort, cohorts)
  while !input_ok
    puts "That isn't a month....the cohort?"
    cohort = get_cohort
    input_ok = check_input(cohort, cohorts)
  end
  return cohort
end

# method adding hash with name and cohort to the students array
def assign_students(name, cohort)
  @students <<  {name: name, cohort: cohort.to_sym, country_of_birth: :unknown, height: :unknown, hobbies: :unknown}
end

# method to get input from user to define the students hash
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice for name input"
  name = STDIN.gets.chomp
  while !name.empty?  do
    cohort = get_and_check_cohort
    assign_students(name, cohort)
    puts "Now we have #{@students.count} students"
    puts "Another name?"
    name = STDIN.gets.chomp
  end
  puts "Input successful"
end

# method to print the interactive menu
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list to a file"
  puts "9. Exit"
end

# method to show the list of students
def show_students
  print_header
  print_students_list
  print_footer
end

# either gets filename or if file doesn't exist asks user again
def get_filename
  puts "Enter a file you wish to use:"
  filename = STDIN.gets.chomp
  while !(File.exists?(filename))
    puts "Sorry filename not recognised, try again:"
    filename = STDIN.gets.chomp
  end
  return filename
end

# method to process the selection made by the user in interactive menu
def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
      puts "Show successful"
    when "3"
      save_students
    when "4"
      filename = get_filename
      load_students(filename)
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
  filename = get_filename
  File.open(filename, "w") do |file|
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  puts "Saved to #{filename}."
end
end

# method to load the students from the students.csv file
def load_students(filename = 'students.csv')
  #File.open(filename, "r") do |file|
  #    file.readlines.each do |line|
  #      name, cohort = line.chomp.split(',')
  #      assign_students(name, cohort)
  #    end
  #  puts "Load successful"
  #end
  CSV.foreach(filename) do |line|
    name = line[0]
    cohort = line[1]
    assign_students(name, cohort)
  end
end

# method to try load students from the file provided on the command line or the default
def try_load_students

  ARGV.first.nil? ? filename = "students.csv" : filename = ARGV.first

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
