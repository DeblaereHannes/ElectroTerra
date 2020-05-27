from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_socketio import SocketIO

from helpers.Mcp import Mcp

from RPi import GPIO
import time
import threading

GPIO.setmode(GPIO.BCM) #pinnumering volgens t-stuk

sensor_file_name = '/sys/bus/w1/devices/28-0316620ad9ff/w1_slave'
mcp1 = Mcp(0,0)

#pinnen definieren

# Start app
app = Flask(__name__)
app.config['SECRET_KEY'] = 'Hier mag je om het even wat schrijven, zolang het maar geheim blijft en een string is'

socketio = SocketIO(app, cors_allowed_origins="*")
CORS(app)


endpoint = '/api/v1'

# API ENDPOINTS
@app.route('/')
def hallo():
    return "Server is running, er zijn momenteel geen API endpoints beschikbaar."

@socketio.on('connect')
def initial_connection():
    print('A new client connect')



def prog():
    try:
        mcp1 = Mcp(0,0)
        while True:
            waarde = mcp1.read_channel(0)
            waarde = ((1000 - waarde) / 1000) * 100
            print("send licht")
            socketio.emit('B2F_licht', {'data': waarde})
            sensor_file = open(sensor_file_name, 'r')
            for line in sensor_file:
                pos = line.find('t')
                #print(pos)
                if pos != -1:
                    #print(line[pos+2:])
                    temp = float(line[pos+2:])
                    temp = temp/1000
                    #print("het is : {0}°C".format(temp))
            status = temp
            print("send temp")
            socketio.emit('B2F_temp', {'data': status})
            time.sleep(10)

    except:
        mcp1.closespi()

threading.Timer(10, prog).start()


# Start app
if __name__ == '__main__':
    socketio.run(app, debug=False, host='0.0.0.0')
