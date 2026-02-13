"""
Iterative program to invert the digits in an integer number

Gilberto Echeverria
2021-09-09
"""


def invert_number(num):
    result = 0
    while num > 0:
        result = result * 10 + num % 10
        num //= 10
    return result


def main():
    num = int(input("Enter a number: "))
    print(invert_number(num))


main()
