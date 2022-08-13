import time
import socket
from board import SCL, SDA
import busio
from adafruit_pca9685 import PCA9685
UDP_IP = "192.168.1.95"
UDP_PORT = 5005
i2c_bus = busio. I2C(SCL, SDA)
pca = PCA9685(i2c_bus)
pca.frequency = 47.6
s =socket.socket(socket.AF_INET, socket.SOCK_DGRAM,0)
s.bind((UDP_IP,UDP_PORT))
while True:
    data,add = s.recvfrom(1024)
    data = (data.decode()).split(",")
    scope = int(data[0])
    if(scope >100):
       pca.channels[0].duty_cycle = 2500+scope*6
       pca.channels[2].duty_cycle = 2500+scope*6
       print(2500+scope*6)
