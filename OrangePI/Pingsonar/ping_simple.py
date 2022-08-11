from brping import Ping1D
myPing = Ping1D()
myPing.connect_serial("/dev/ttyUSB0", 9600)
data = myPing.get_distance()
distance = data["distance"]
confidence = data["confidence"]
