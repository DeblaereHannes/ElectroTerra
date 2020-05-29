from RPi import GPIO
import time


motor = 21


GPIO.setmode(GPIO.BCM) #pinnumering volgens t-stuk

#pinnen definieren
GPIO.setup(motor,GPIO.OUT)
#default ingang is pull down => pull up

print("script is running")
try:
    while True:
        inp = input("a - z")
        if inp == "a":
            GPIO.output(motor,GPIO.HIGH)
        elif inp == "z":
             GPIO.output(motor,GPIO.LOW)

except KeyboardInterrupt as e:
    print(e)
    GPIO.output(motor,GPIO.LOW)

finally:
    print("final")
