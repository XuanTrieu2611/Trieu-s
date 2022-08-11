from mpu6050 import mpu6050
import time
while True:
    print("Temp : "+str(mpu.get_temp()))
    print()
    accel_data = mpu.get_accel_data()
    print("Acc X : "+str(accel_data[0]))
    print("Acc Y : "+str(accel_data[1]))
    print("Acc Z : "+str(accel_data[2]))
    print()

