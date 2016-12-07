center_by = 60

# method printing just the header
def print_header(center_by)
  puts "The students of Villians Academy".center(center_by)
  puts "-------------".center(center_by)
end

# method printing the student name and cohort using .each_with_index
def print(students, center_by)
  students.sort!{|x,y| x[:cohort]<=>y[:cohort]}
  students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(center_by)
  end
end

# method to print the footer
def print_footer(names, center_by)
    puts "Overall, we have #{names.count} great students".center(center_by)
end

# method to get input from user to define the students hash
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice for name input"
  # create and empty array
  students = []
  #get the first name
  name = gets.chomp
  #while the name is  not empty, repeat this code
  while !name.empty?  do
    #get that students cohort
    puts "And the cohort?"
    cohort = gets.chomp.to_sym
    cohort = "November" if cohort.empty?
    #add the student hash to the  array
    students <<  {name: name, cohort: cohort, country_of_birth: :unknown, height: :unknown, hobbies: :unknown}
    puts "Now we have #{students.count} students"
    #get another name from the user
    puts "Another name?"
    name = gets.chomp
  end
  #return the array of students
  students
end

#nothing happens until we call the methods
students = input_students
print_header(center_by)
print(students, center_by)
print_footer(students, center_by)
