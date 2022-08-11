import time
import serial

ser = serial.Serial(
    port='/dev/ttyACM0',
    baudrate=9600,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    bytesize=serial.EIGHTBITS,
    timeout=1
)
while True:
    ser.write(b'hehe')
    ser.flush()
    print("hehe")
    time.sleep(1)
