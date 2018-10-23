a=10
puts a
## Integers can be defined with out quotes
## For strings you need to give the input with quotes(Either single or double)
b='xyz' 
puts b

c="xyz"
puts c

## Arrays are used to keep multiple values in single variable

d=[1,2,3]
puts d

puts d.first
puts "First Number in Array is = #{d[0]}"


## Define white space arrays 
e=%w(1 2 3)
puts "First value in white space array = #{e[0]}"

f = { 'first_name' => 'Bob', 'last_name'  => 'Jones' }
puts "First Name = #{f['first_name']}"

### Single quotes 
x=10
puts 'Value of x in Single quotes = #{x}'
puts "Value of x in Double quotes = #{x}"