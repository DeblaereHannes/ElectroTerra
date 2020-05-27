from smbus import SMBus

slave_address = 0x44

from RPi import GPIO
import time

SDA = 23
SCL = 24
sec = 0.002
lijst = []
ack = 1

def delay():
    time.sleep(sec)

def setup():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(SDA,GPIO.OUT)
    GPIO.setup(SCL,GPIO.OUT)
    GPIO.output(SDA,GPIO.HIGH)
    GPIO.output(SCL,GPIO.HIGH)
    

def startconditie():
    delay()
    GPIO.output(SDA,GPIO.LOW)
    delay()
    GPIO.output(SCL,GPIO.LOW)
    delay()
    
def stopconditie():
    delay()
    GPIO.output(SCL,GPIO.HIGH)
    delay()
    GPIO.output(SDA,GPIO.HIGH)
    delay()
    

def acknowledge():
    delay()
    GPIO.setup(SDA,GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.output(SCL,GPIO.HIGH)
    delay()
    status = GPIO.input(SDA)
    print(f"ack = {status}")
    delay()
    GPIO.setup(SDA,GPIO.OUT)
    GPIO.output(SCL,GPIO.LOW)

def acknowledge2():
    global ack
    delay()
    GPIO.setup(SDA,GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.output(SCL,GPIO.HIGH)
    delay()
    status = GPIO.input(SDA)
    print(f"ack = {status}")
    ack = status
    delay()
    GPIO.setup(SDA,GPIO.OUT)
    GPIO.output(SCL,GPIO.LOW)


def writebit(bit):
    if bit == True:
        #print("True")
        GPIO.output(SDA,GPIO.HIGH)
        delay()
        GPIO.output(SCL,GPIO.HIGH)
        delay()
        GPIO.output(SCL,GPIO.LOW)
        delay()
    elif bit == False:
        #print("False")
        GPIO.output(SDA,GPIO.LOW)
        delay()
        GPIO.output(SCL,GPIO.HIGH)
        delay()
        GPIO.output(SCL,GPIO.LOW)
        delay()

def writebyte(byte):
    mask = 0x80
    for i in range(0, 8):
        bitje = mask & byte
        bitje = bitje >> 7 - i
        writebit(bitje)
        mask = mask >> 1

def readbyte():
    global lijst
    delay()
    GPIO.setup(SDA,GPIO.IN, pull_up_down=GPIO.PUD_UP)
    for i in range(0, 8):
        GPIO.output(SCL,GPIO.HIGH)
        delay()
        status = GPIO.input(SDA)
        lijst.append(status)
        delay()
    GPIO.setup(SDA,GPIO.OUT)
    GPIO.output(SCL,GPIO.LOW)

def eig_acknowledge():
    delay()
    GPIO.output(SDA,GPIO.LOW)
    delay()
    GPIO.output(SDA,GPIO.HIGH)

def scl_high():
    delay()
    GPIO.setup(SCL,GPIO.IN, pull_up_down=GPIO.PUD_UP)
    delay()
    status = GPIO.input(SCL)
    print("start while")
    while status == 0:
        time.sleep(1)
        status = GPIO.input(SCL)
    delay()
    GPIO.setup(SCL,GPIO.OUT)
    GPIO.output(SCL,GPIO.LOW)

try:
    setup()
    #while True:
    print('loop')
    startconditie()
    writebyte(0x88) #i2c address + write
    acknowledge()
    writebyte(0x2c) #msb: clk stretching disabled
    acknowledge()
    writebyte(0x10) #lsb: repeatability medium
    acknowledge()

    scl_high()
    # stopconditie()

    # #while ack != 0:
    # print("ff w8ten")
    # time.sleep(5)
    # startconditie()
    # writebyte(0x89) #i2c address + read
    # acknowledge()
    # print(ack)
    # #if ack != 0:
    # stopconditie()

    readbyte()
    eig_acknowledge()
    readbyte()
    eig_acknowledge()
    readbyte()
    eig_acknowledge()
    readbyte()
    eig_acknowledge()
    readbyte()
    eig_acknowledge()
    readbyte()
    acknowledge()
    stopconditie()
    print(lijst)
    print("end")


except KeyboardInterrupt as e:
    print(e)

finally:
    print("final")
    GPIO.cleanup()