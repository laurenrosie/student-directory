@center_by = 60
@students = []

# method printing just the header
def print_header
  puts "The students of Villians Academy".center(@center_by)
  puts "-------------".center(@center_by)
end

# method printing the student name and cohort using .each_with_index
def print

    @students.sort!{|x,y| x[:cohort]<=>y[:cohort]}
    @students.each_with_index do |student, index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(@center_by)
    end

end

# method to print the footer
def print_footer
    @students.count==1 ? final_word = "student":final_word = "students"
    puts "Overall, we have #{@students.count} great #{final_word}".center(@center_by)
end

# method to get input from user to define the students hash
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice for name input"
  # create and empty array
  #@students = []
  #get the first name
  name = gets.strip!
  #while the name is  not empty, repeat this code
  while !name.empty?  do
    #get that students cohort
    puts "And the cohort?"
    cohort = gets.strip!.to_sym
    cohort = "November" if cohort.empty?
    cohort=cohort.to_s
    month = cohort.include?("January")||cohort.include?("February")||cohort.include?("March")||cohort.include?("April")||cohort.include?("May")||cohort.include?("June")||cohort.include?("July")||cohort.include?("August")||cohort.include?("September")||cohort.include?("October")||cohort.include?("November")||cohort.include?("December")
    while !month
      puts "That isn't a month....the cohort?"
      cohort = gets.strip!.to_sym
      cohort = "November" if cohort.empty?
      cohort=cohort.to_s
      month = cohort.include?("January")||cohort.include?("February")||cohort.include?("March")||cohort.include?("April")||cohort.include?("May")||cohort.include?("June")||cohort.include?("July")||cohort.include?("August")||cohort.include?("September")||cohort.include?("October")||cohort.include?("November")||cohort.include?("December")
    end
    #add the student hash to the  array
    @students <<  {name: name, cohort: cohort, country_of_birth: :unknown, height: :unknown, hobbies: :unknown}
    puts "Now we have #{@students.count} students"
    #get another name from the user
    puts "Another name?"
    name = gets.strip!
  end
  #return the array of students
  #students
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print
  print_footer
end

def interactive_menu
  #students = []
  loop do
    print_menu

    selection = gets.chomp

    case selection
    when "1"
      input_students
    when "2"
      if @students.length == 0
        puts "No students to print".center(center_by)
      else
      show_students
      end
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
    end
  end
end

interactive_menu
