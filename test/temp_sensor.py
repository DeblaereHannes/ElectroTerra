from RPi import GPIO
import time

GPIO.setmode(GPIO.BCM) #pinnumering volgens t-stuk

sensor_file_name = '/sys/bus/w1/devices/28-0316620ad9ff/w1_slave'
#pinnen definieren
sensor_file = open(sensor_file_name, 'r')

print("script is running")
try:
    while True:
        sensor_file = open(sensor_file_name, 'r')
        for line in sensor_file:
            pos = line.find('t')
            #print(pos)
            if pos != -1:
                #print(line[pos+2:])
                temp = float(line[pos+2:])
                temp = temp/1000
                print("het is : {0}°C".format(temp))
    

except KeyboardInterrupt as e:
    print(e)

finally:
    print("final")
    GPIO.cleanup    
    sensor_file.close()
