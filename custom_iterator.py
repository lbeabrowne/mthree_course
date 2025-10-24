# simple iterator:

my_list = [1, 2, 3]
my_iterator = iter(my_list)
print(next(my_iterator))
print(next(my_iterator))

# for a custom iterator, create a class with __iter__ and __next__ methods:
# create iterator first, and then can call the iterator
# creating an iterator that returns every second value (skips one):

class skip_iterator:
    def __init__(self, values):
        self.values = values
        self.index = 0
    
    def __iter__(self):
        return self
    
    def __next__(self):
        if self.index < len(self.values):
            result = self.values[self.index]
            self.index += 2
            return result
        else:
            raise StopIteration

# using iterator with list of strings:

words = ["apple", "banana", "cherry", "orange"]

iterator = skip_iterator(words)

for words in iterator:
    print(words)

# using same iterator with list of integers:

numbers = [1, 2, 3, 4, 5, 6]

iterator = skip_iterator(numbers)

for numbers in iterator:
    print(numbers)