from RPi import GPIO
import time

delay = time.sleep(0.002)

class PCF:
    def __init__(self, par_SDA, par_SCL, par_address):
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(par_SDA,GPIO.OUT)
        GPIO.setup(par_SCL,GPIO.OUT)
        GPIO.output(par_SDA,GPIO.HIGH)
        GPIO.output(par_SCL,GPIO.HIGH)
        self.SDA = par_SDA
        self.SCL = par_SCL
        self.address = par_address


    def start_conditie(self):
        time.sleep(0.002)
        GPIO.output(self.SDA,GPIO.LOW)
        time.sleep(0.002)
        GPIO.output(self.SCL,GPIO.LOW)
        time.sleep(0.002)

    def stop_conditie(self):
        time.sleep(0.002)
        GPIO.output(self.SCL,GPIO.HIGH)
        time.sleep(0.002)
        GPIO.output(self.SDA,GPIO.HIGH)
        time.sleep(0.002)

    def writebit(self, bit):
        if bit == True:
            #print("True")
            GPIO.output(self.SDA,GPIO.HIGH)
            time.sleep(0.002)
            GPIO.output(self.SCL,GPIO.HIGH)
            time.sleep(0.002)
            GPIO.output(self.SCL,GPIO.LOW)
            time.sleep(0.002)
        elif bit == False:
            #print("False")
            GPIO.output(self.SDA,GPIO.LOW)
            time.sleep(0.002)
            GPIO.output(self.SCL,GPIO.HIGH)
            time.sleep(0.002)
            GPIO.output(self.SCL,GPIO.LOW)
            time.sleep(0.002)

    def writebyte(self, byte):
        mask = 0x80
        for i in range(0, 8):
            bitje = mask & byte
            bitje = bitje >> 7 - i
            self.writebit(bitje)
            mask = mask >> 1

    def adres(self):
        self.writebyte(self.address)

    def ack(self):
        time.sleep(0.002)
        GPIO.setup(self.SDA,GPIO.IN, pull_up_down=GPIO.PUD_UP)
        GPIO.output(self.SCL,GPIO.HIGH)
        time.sleep(0.002)
        status = GPIO.input(self.SDA)
        #print(f"ack = {status}")
        time.sleep(0.002)
        GPIO.setup(self.SDA,GPIO.OUT)
        GPIO.output(self.SCL,GPIO.LOW)
