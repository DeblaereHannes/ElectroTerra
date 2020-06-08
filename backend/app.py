from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_socketio import SocketIO

from helpers.Mcp import Mcp
from repositories.dataRepository import dataRepository

from RPi import GPIO
import time
import datetime
import threading
import serial

sensor_file_name = '/sys/bus/w1/devices/28-0316620ad9ff/w1_slave'
ser = serial.Serial('/dev/serial0')

#pinnen definieren
motor = 21

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

@app.route(endpoint + '/actuators/<actuatorID>', methods=['PUT'])
def actuator_route(actuatorID):
    print('yoyo')
    if request.method == 'PUT':
        print('test')
        gegevens = dataRepository.json_or_formdata(request)
        print(gegevens)
        return jsonify(actuatorID=actuatorID), 200

@app.route(endpoint + '/sensors/grafiek', methods=['GET'])
def grafiek_route():
    geg = dataRepository.read_voor_grafiek()
    return jsonify(grafiekData=geg), 200



@socketio.on('connect')
def initial_connection():
    print('A new client connect')
    status = dataRepository.read_last_sensors_meeting()
    print(status)
    socketio.emit('B2F_data', {'data': status}, broadcast=True)

def setup():
    GPIO.setmode(GPIO.BCM) #pinnumering volgens t-stuk
    GPIO.setup(motor,GPIO.OUT)

def prog():
    try:
        print("start")
        mcp1 = Mcp(0,0)
        while True:
            waarde = mcp1.read_channel(0)
            waarde = ((1000 - waarde) / 1000) * 100
            print("repo")
            dataRepository.create_inlezing(101, datetime.datetime.now().replace(microsecond=0), waarde)
            print("norepo")
            sensor_file = open(sensor_file_name, 'r')
            for line in sensor_file:
                pos = line.find('t')
                #print(pos)
                if pos != -1:
                    #print(line[pos+2:])
                    temp = float(line[pos+2:])
                    temp = temp/1000
                    #print("het is : {0}°C".format(temp))
            print("repo2")
            dataRepository.create_inlezing(102, datetime.datetime.now().replace(microsecond=0), temp)
            bericht = "dht"
            ser.write(bericht.encode(encoding='utf-8'))
            recv_mesg = ser.readline()
            recv_mesg = str(recv_mesg,encoding='utf-8')
            mesg = recv_mesg.split('\r')
            lijst = mesg[0].split(" ")
            dataRepository.create_inlezing(103, datetime.datetime.now().replace(microsecond=0), lijst[0])
            status = dataRepository.read_last_sensors_meeting()
            print(status)
            socketio.emit('B2F_data', {'data': status}, broadcast=True)
            time.sleep(60)

    except:
        print("er is een fout")
        mcp1.closespi()

setup()
threading.Timer(10, prog).start()


# Start app
if __name__ == '__main__':
    socketio.run(app, debug=False, host='0.0.0.0')
