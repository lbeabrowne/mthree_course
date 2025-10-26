class Bridge:
    def __init__(self, id, name, length, height, colour):
        self.id = id
        self.name = name
        self.length = length
        self.height = height
        self.colour = colour
    def getBridgeDetails(self):
        return f"ID: {self.id}, NAME: {self.name}, LENGTH: {self.length}, HEIGHT: {self.height}, COLOUR: {self.colour}"

b1 = Bridge(1, "London Bridge", 262, 104, "blue")
b2 = Bridge(2, "Millennium Bridge", 325, 50, "grey")

bridge_list = [b1, b2]

for bridge in bridge_list:
    print(bridge.getBridgeDetails())

# or to print in table format:
print(f"{'ID':<5}{'NAME':<20}{'LENGTH':<10}{'HEIGHT':<10}{'COLOUR':<10}")
for bridge in bridge_list:
    print(f"{bridge.id:<5}{bridge.name:<20}{bridge.length:<10}{bridge.height:<10}{bridge.colour:<10}")

