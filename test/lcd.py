import time
from models.PFC_LCD import PFC_LCD
from subprocess import check_output

lcd = PFC_LCD(6,5,26,19,0x38)

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
        time.sleep(10)


except KeyboardInterrupt as e:
    print(e)

finally:
    print("final")