
from board import SCL, SDA
import busio
from adafruit_pca9685 import PCA9685
i2c_bus = busio. I2C(SCL, SDA)
pca = PCA9685(i2c_bus)
pca. frequency = 47.6 #chu ki 20ms = 2^16

pca.channels[0].duty_cycle = 2800
#pwm chanel 0 2800/2^16
pca.channels[2].duty_cycle = 7800
#pwm chanel 2 2800/2^16
