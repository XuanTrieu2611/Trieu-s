import time
import socket
import base64
import cv2, imutils
UDP_IP = "192.168.1.154"
BUFF_SIZE = 65536
UDP_PORT2 = 5006
s2 = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s2.setsockopt(socket.SOL_SOCKET,socket.SO_RCVBUF,BUFF_SIZE)
socket_address = (UDP_IP,UDP_PORT2)
vid = cv2.VideoCapture(1,cv2.CAP_V4L2) #  replace with 0,1,2,3 for webcam
while True:
    while (vid.isOpened()):
        image, frame = vid.read()
        if image == True:
          # frame = imutils.resize(frame, width=512)
           encoded, buffer = cv2.imencode('.jpg', frame, [cv2.IMWRITE_JPEG_QUAL>
           message = base64.b64encode(buffer)
           s2.sendto(message,socket_address)
           print(message)
