"""
Working with files in Python

Always close the files you open.
It is recommended to use the 'with' context definition

Gilberto Echeverria
2021-04-21
"""

# Available open modes are:
# w - write (delete contents of existing files)
# a - append (preserve the content of existing files)
# r - read (default)
fp = open("new_test.txt", "w")
fp.write("Line one\n")
#fp.close()

# If the previous file is not closed, this will not be saved
with open("new_test.txt", "a") as fp1:
    fp1.write("Another test\n")

# This should throw an error if the file has been closed
fp.write("FAIL")
