# let's put  all the students into an array of hashes
#students = [
#  {name: "Dr. Hannibal Lecter", cohort: :november},
#  {name: "Darth Vader", cohort: :november},
#  {name: "Nurse Ratched", cohort: :november},
#  {name: "Michael Corleone", cohort: :november},
#  {name: "Alex DeLarge", cohort: :november},
#  {name: "The Wicked Witch of the West", cohort: :november},
#  {name: "Terminator", cohort: :november},
#  {name: "Freddy Krueger", cohort: :november},
#  {name: "The Joker", cohort: :november},
#  {name: "Joffrey Baratheon", cohort: :november},
#  {name: "Norman Bates", cohort: :november}
#]


center_by = 60

def print_header(center_by)
  puts "The students of Villians Academy".center(center_by)
  puts "-------------".center(center_by)
end

def print(students, center_by)
  students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(center_by)
  end
end

def loop_print(students, center_by)
  #commenting
  i = 0
  while i<students.length
    student = students[i]
    puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(center_by)
    i+=1
  end
end


def print_letter(students, letter, center_by)
  students.each_with_index do |student, index|
    if (student[:name].chars)[0] == letter
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(center_by)
    end
  end
end

def print_upto_12chars(students, center_by)
  students.each_with_index do |student, index|
    if (student[:name].chars).length < 12
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(center_by)
    end
  end
end



def print_footer(names, center_by)
    puts "Overall, we have #{names.count} great students".center(center_by)
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create and empty array
  students = []
  #get the first name
  name = gets.chomp
  #while the name is  not empty, repeat this code
  while !name.empty? do
    #add the student hash to the  array
    students <<  {name: name, cohort: :november, country_of_birth: :unknown, height: :unknown, hobbies: :unknown}
    puts "Now we have #{students.count} students"
    #get another name from the user
    name = gets.chomp
  end
  #return the array of students
  students
end

#nothing happens until we call the methods
students = input_students
print_header(center_by)

#print(students, center_by)
#print_letter(students, "D", center_by)
#print_upto_12chars(students, center_by)
loop_print(students, center_by)

print_footer(students, center_by)
