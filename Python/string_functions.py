"""
Functions to implement the recursive definitions of string properties
- Length of a string
- Reversal of a string

Gilberto Echeverria
2025-02-17
"""

def string_length(string):
    if string == "":
        return 0
    else:
        return 1 + string_length(string[1:])


def string_reverse(string):
    if string == "":
        return ""
    else:
        return string[-1] + string_reverse(string[:-1])

print(f"Length of 'test': {string_length('test')}")
print(f"Length of 'parangaricutirimicuaro': {string_length('parangaricutirimicuaro')}")
print(f"Reverse of 'test': {string_reverse('test')}")
print(f"Reverse of 'parangaricutirimicuaro': {string_reverse('parangaricutirimicuaro')}")

