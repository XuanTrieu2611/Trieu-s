import socket
import random
import time
UDP_IP = "192.168.1.154"
UDP_PORT = 5005
s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM, 0)
while True:
    roll = random.randrange(-30,30)
    pitch = random.randrange(-10,10)
    heading = random.randrange(-30,30)
    accroll = random.randrange(-50,50)
    accpitch = random.randrange(-50, 50)
    speedengineL = random.randrange(0, 100)
    speedengineR = random.randrange(0, 100)
    voltage = random.randrange(0,10)
    current = random.randrange(0,10)
    battery = random.randrange(-30, 30)
    distance = random.randrange(-300,0)
    confidence = random.randrange(0,100)
    tempwater = random.randrange(20,30)
    a =str(roll)+","+str(pitch)+","+str(heading)+","+str(accroll)+","+str(accpitch)+","+str(speedengineL)+","+str(speedengineR)+","+str(voltage)+","+str(current)+","+str(battery)+","+str(distance)+","+str(confidence)+","+str(tempwater)
    s.sendto(a.encode('utf-8'), (UDP_IP,UDP_PORT))
    print(a)
    time.sleep(0.01)