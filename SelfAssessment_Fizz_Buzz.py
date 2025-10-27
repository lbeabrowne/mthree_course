# Lucy Browne, 27/10/25

print("How many fizzing and buzzing units do you need in your life?\n")

input_value = input("Enter a number:")

str_count = 0

print("0")
x = 1
while True:
    if x % 3 == 0 and x % 5 != 0:
        print("fizz")
        str_count += 1
    elif x % 3 != 0 and x % 5 == 0:
        print("buzz")
        str_count += 1
    elif x % 3 == 0 and x % 5 == 0:
        print("fizz buzz")
        str_count += 1
    else:
        print(x)

    if str_count >= int(input_value):
        break

    x += 1

print("TRADITION!!")


