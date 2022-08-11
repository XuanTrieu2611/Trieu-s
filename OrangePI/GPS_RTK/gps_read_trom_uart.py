
import serial
ser = serial.Serial('/dev/ttyACM0', 9600,timeout=1)
while True:
    x = ser.readline()
    pos1 = x.find(b'$GNGLL')
    pos2 = x.find(b'E', pos1)
    latitude = 0
    longitude = 0
    loc  = x[pos1:pos2]
    data = loc.split(b',')
    if data[0] == b'$GNGLL':
        rawlat = float(data[1].decode())
        rawlong = float(data[3].decode())
            # rawlat = round(float(list[1]), 8)
            # rawlong = round(float(list[3]), 8)
        latitude = round(int(rawlat / 100) + (rawlat % 100) / 60, 8)
        longitude = round(int(rawlong / 100) + (rawlong % 100) / 60, 8)
        print(latitude,longitude)
