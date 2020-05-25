from flask import Flask, jsonify, request
from flask_cors import CORS

from helpers.Mcp import Mcp

from RPi import GPIO
import time

GPIO.setmode(GPIO.BCM) #pinnumering volgens t-stuk

sensor_file_name = '/sys/bus/w1/devices/28-0316620ad9ff/w1_slave'
mcp1 = Mcp(0,0)

#pinnen definieren

# Start app
app = Flask(__name__)
CORS(app)


endpoint = '/api/v1'

# API ENDPOINTS
@app.route('/')
def hallo():
    return "Server is running, er zijn momenteel geen API endpoints beschikbaar."

@app.route(endpoint + '/tempdata', methods=['GET'])
def get_tempdata():
    if request.method == 'GET':
        sensor_file = open(sensor_file_name, 'r')
        for line in sensor_file:
            pos = line.find('t')
            #print(pos)
            if pos != -1:
                #print(line[pos+2:])
                temp = float(line[pos+2:])
                temp = temp/1000
                print("het is : {0}°C".format(temp))
        s = temp
        return jsonify(s), 200

@app.route(endpoint + '/lichtsensor', methods=['GET'])
def get_lichtdata():
    if request.method == 'GET':
        waarde = mcp1.read_channel(0)
        s = ((1000 - waarde) / 1000) * 100
        return jsonify(s), 200



# Start app
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
