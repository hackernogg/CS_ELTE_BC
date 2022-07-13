x = 2
print(x == 2)
print(x == 3)
print(x < 3)

name = "John"
age = 23
if name == "John" and age == 23:
    print("Your name is John, and you are also 23 years old.")

if name == "John" or name == "Rick":
    print("your name is either John or Rick")

if name in ["John","Rick"]:
    print("Your name is John or Rick")

if x == 2:
    print("x is two")
else:
    print("x is not two")

list_one = [1,2,3]
list_two = [1,2,3]
#list_one = list_two
print(list_one == list_two)
print(list_one is list_two)

print(not False)
print((not False) == False)


#--------------------------------------
# change this code
number = 16
second_number = None
# None is Null in python
first_array = [1,2,3]
second_array = [1,2]

if number > 15:
    print("1")

if first_array:
    print("2")

if len(second_array) == 2:
    print("3")

if len(first_array) + len(second_array) == 5:
    print("4")

if first_array and first_array[0] == 1:
    print("5")

if not second_number:
    print("6")