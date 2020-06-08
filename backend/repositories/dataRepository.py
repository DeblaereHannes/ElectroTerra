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
        sql = "select s.sensorID, s.name, i.waarde, s.eenheid from inlezingen as i join sensors as s on i.sensorID = s.sensorID where s.sensorID = 101 or s.sensorID = 102 or s.sensorID = 103 order by i.time desc limit 3;"
        return Database.get_rows(sql)

    @staticmethod
    def create_inlezing(sensorID, time, waarde, actuatorID=None):
        sql = "INSERT INTO inlezingen(sensorID, time, waarde, actuatorID) VALUES (%s,%s,%s,%s)"
        params = [sensorID, time, waarde, actuatorID]
        return Database.execute_sql(sql, params)

    @staticmethod
    def update_status_actuator(actuatorID, actuatorstatus):
        sql = "update actuators set statusactuator = '%s' where actuatorID = %s"
        params = [actuatorstatus, actuatorID]
        return Database.execute_sql(sql, params)

    @staticmethod
    def read_actuator(actuatorID):
        sql = "select actuatorID, name, statusactuator from actuators where actuatorID = %s"
        params = [actuatorID]
        return Database.get_one_row(sql, params)

    @staticmethod
    def read_voor_grafiek():
        sql = "select i.time, i.waarde, s.eenheid from inlezingen as i left join sensors as s on i.sensorID = s.sensorID where i.sensorID = 103 order by time desc limit 20"
        return Database.get_rows(sql)