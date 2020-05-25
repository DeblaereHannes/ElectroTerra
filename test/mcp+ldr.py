from models.Mcp import Mcp
from RPi import GPIO
import time

duty_cycle = 0
led = 21

def setup():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(led, GPIO.OUT)

try:
    setup()
    pwm = GPIO.PWM(led, 50)
    pwm.start(duty_cycle)
    mcp1 = Mcp(0,0)
    while True:
        waarde = mcp1.read_channel(0)
        print(((1000 - waarde) / 1000) * 100)
        duty_cycle = ((waarde / 1024) * 100)
        pwm.ChangeDutyCycle(duty_cycle)
        time.sleep(0.05)

except KeyboardInterrupt as e:
    print(e)

finally:
    print("end")
    pwm.stop()
    mcp1.closespi()
    GPIO.cleanup()