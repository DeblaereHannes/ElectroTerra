from RPi import GPIO
from models.PCF import PCF
import time

cursorB = True
display = True

class PFC_LCD:
    def __init__(self, par_E, par_RS, par_SDA, par_SCL, par_address):
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(par_RS,GPIO.OUT)
        GPIO.setup(par_E,GPIO.OUT)
        GPIO.output(par_E,GPIO.HIGH)
        self.E = par_E
        self.RS = par_RS
        self.pcf = PCF(par_SDA, par_SCL, par_address)

    def set_data_bits(self, value):
        self.pcf.start_conditie()
        self.pcf.adres()
        self.pcf.ack()
        #print(f"byte: {value}")
        mask = 0x80
        for i in range(0, 8):
            bit = value & mask
            bit = bit >> 7 - i
            #print(f"bit: {bit}")
            if bit == 1:
                self.pcf.writebit(True)
            elif bit == 0:
                self.pcf.writebit(False)
            mask = mask >> 1
        self.pcf.ack()
        self.pcf.stop_conditie()
        GPIO.output(self.E,GPIO.LOW)
        time.sleep(0.01)
        GPIO.output(self.E,GPIO.HIGH)
        time.sleep(0.01)

    def send_instruction(self, value):
        #print(f"instructie")
        GPIO.output(self.RS,GPIO.LOW)
        self.set_data_bits(value)

    def send_character(self, value):
        #print(f"data")
        GPIO.output(self.RS,GPIO.HIGH)
        self.set_data_bits(value)

    def init_LCD(self):
        global cursorB
        global display
        self.send_instruction(56)
        self.send_instruction(15)
        cursorB = True
        display	= True
        self.send_instruction(1)

    def write_message(self, message, lijn):
        message = str(message)
        aantal = len(message)
        if aantal < 40:
            if lijn == "1":
                self.send_instruction(2)
                for i in range(0, aantal):
                    #print(f"char = {message[i]}")
                    self.send_character(ord(message[i]))
            elif lijn == "2":
                self.send_instruction(168)
                for i in range(0, aantal):
                    self.send_character(ord(message[i]))
            else:
                print("verkeerde lijn!!!!!!!!")
        else:
            print("text te lang!!!!!!!!")


    def cursor_aanpassen(self):
        global cursorB
        if cursorB == True:
            self.send_instruction(14)
            cursorB = False
        elif cursorB == False:
            self.send_instruction(15)
            cursorB = True

    def scroll(self):
        self.send_instruction(24)
        time.sleep(0.01)

    def reverse_scroll(self):
        self.send_instruction(28)
        time.sleep(0.01)

    def display_on_off(self):
        global cursorB
        global display
        if display == True:
            self.send_instruction(8)
            display = False
        elif display == False:
            self.send_instruction(15)
            cursorB = True
            display = True

    def clear_display(self):
        self.send_instruction(1)

    # def test(self):
    #     GPIO.output(self.E,GPIO.LOW)
    #     time.sleep(0.01)
    #     GPIO.output(self.E,GPIO.HIGH)
    #     time.sleep(0.01)