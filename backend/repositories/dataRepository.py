from repositories.Database import Database


class dataRepository:
    @staticmethod
    def json_or_formdata(request):
        if request.content_type == 'application/json':
            gegevens = request.get_json()
        else:
            gegevens = request.form.to_dict()
        return gegevens

    @staticmethod
    def read_last_sensors_meeting():
        sql = "select s.sensorID, s.name, i.waarde, s.eenheid, i.time from inlezingen as i join sensors as s on i.sensorID = s.sensorID where s.sensorID > 100 group by s.sensorID order by time desc"
        return Database.get_rows(sql)

    @staticmethod
    def create_inlezing(sensorID, time, waarde, actuatorID=None, actuatorstatus=None ):
        sql = "INSERT INTO inlezingen(sensorID, time, waarde, actuatorID, statusactuator) VALUES (%s,%s,%s,%s,%s)"
        params = [sensorID, time, waarde, actuatorID, actuatorstatus]
        return Database.execute_sql(sql, params)

    