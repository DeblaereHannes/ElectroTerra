import spidev 

spi = spidev.SpiDev()

class Mcp:
    def __init__(self, bus=0, devices=0):
        spi.open(bus,devices)           # Bus SPI0, slave op CE 0
        spi.max_speed_hz = 10 ** 5      # 100 kHz

    def read_channel(self,ch):
        lijst_bytes = [0b00000001,0b00000000,0b00000000]
        if ch == 0:
            lijst_bytes[1] = 0b10000000
        elif ch == 1:
            lijst_bytes[1] = 0b10010000
        elif ch == 2:
            lijst_bytes[1] = 0b10100000
        elif ch == 3:
            lijst_bytes[1] = 0b10110000
        elif ch == 4:
            lijst_bytes[1] = 0b11000000
        elif ch == 5:
            lijst_bytes[1] = 0b11010000
        elif ch == 6:
            lijst_bytes[1] = 0b11100000
        elif ch == 7:
            lijst_bytes[1] = 0b11110000
        
        bytes_out = spi.xfer(lijst_bytes)
        waarde = (bytes_out[1]<<8) + bytes_out[2]
        return waarde

    def closespi(self):
        spi.close()
