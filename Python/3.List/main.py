mylist = []
mylist.append(1)
print(mylist[0])
mylist.append(2)
print(mylist[1])
mylist.append(3)
print(mylist[2])

for x in mylist:
    print(x)

#error print(mylist[50])

#-------------------------

numbers = []
strings = []
names = ["John", "Eric", "Jessica"]

numbers.append(1)
numbers.append(2)
numbers.append(3)
strings.append("Hello")
strings.append("world")
second_name = names[1]
print(numbers)
print(strings)
print("The second name in the list is : %s" %second_name)
