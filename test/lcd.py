import time
from models.PCF_LCD import PCF_LCD
from subprocess import check_output

lcd = PCF_LCD(23,24,26,19,112)

try:
    lcd.init_LCD()
    lcd.send_instruction(12)
    while True:
        lcd.clear_display()
        ips = str(check_output(["hostname", "--all-ip-addresses"]))
        ips = ips.replace("b","").replace("'","")
        ips = ips.split(" ")
        print(ips)
        lcd.write_message((ips[0]),"1")
        lcd.write_message((ips[1]),"2")
        time.sleep(10)


except KeyboardInterrupt as e:
    print(e)

finally:
    print("final")