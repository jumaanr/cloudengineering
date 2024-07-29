import sys
#This program checks the python version and prints the message based on that
def print_message():
   if sys.version_info[0] < 3:
     print("Hello old World!")
   else:
     print("Hello new World!")

if __name__ == '__main__':
    print_message()