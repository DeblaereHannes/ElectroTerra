from RPi import GPIO
import time
import serial

ser = serial.Serial('/dev/serial0')

def delay(sec):
    time.sleep(sec)


try:
    while True:
        bericht = input("gegevens: ")
        ser.write(bericht.encode(encoding='utf-8'))
        recv_mesg = ser.readline()
        recv_mesg = str(recv_mesg,encoding='utf-8')
        if (recv_mesg != ""):
            print(recv_mesg)
        mesg = recv_mesg.split('\r')
        lijst = mesg[0].split(" ")
        print(lijst)

except KeyboardInterrupt as e:
    print(e)
    ser.close()