"""
Simple examples of list comprehensions in Python
Use these as a reference to compare against the examples in Racket

List comprehensions are used to convert a list into another list
Another way to do the same is with the use of the map function,
generally also with a lambda function

Gilberto Echeverria
2021-09-28
"""

# The source list
data = [1, 2, 3, 4, 5, 6]
print("Source:")
print(data)


# Multiply each element in data by 2
# Using a loop and appending to a new list
result1 = []
for item in data:
    result1.append(item * 2)
print("Regular:")
print(result1)


# Same, using list comprehensions
result2 = [item * 2 for item in data]
print("List comprehension:")
print(result2)


# Same with map and lambda
result3 = list(map(lambda item: item * 2, data))
print("Map and lambda:")
print(result3)
