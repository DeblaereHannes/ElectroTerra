"use strict";

const lanIP = `${window.location.hostname}:5000`;
const socket = io(`http://${lanIP}`);


const callbackUpdate = function(data) {
  console.log(data);
};

const listenToButten = function () {
    const knoppen = document.querySelectorAll(".js-power-btn");
    console.log(knoppen);
  for (const knop of knoppen) {
    knop.addEventListener("click", function () {
      const status = knop.getAttribute('data-status');
      const jsonObject = {actuatorStatus: status};
      const id = this.dataset.actuatorid;
      console.log(id);
      console.log(jsonObject);
      handleData(`http://127.0.0.1:5000/api/v1/actuators/${id}`, callbackUpdate, null, "PUT", JSON.stringify(jsonObject));
    });
  };
};


const listenToSocket = function () {
    socket.on("connected", function () {
      console.log("verbonden met socket webserver");
    });

    socket.on("B2F_data", function(jsonObject) {
        console.log("antw van back");
        console.log(jsonObject);
        let htmlstring = "";
        for(const sens of jsonObject.data) {
            console.log(sens);
            htmlstring += `<p>${sens.name} met id [${sens.sensorID}] = ${sens.waarde}${sens.eenheid}</p>`;
        } 
        document.querySelector(".js-data").innerHTML = htmlstring;
    });

};


document.addEventListener("DOMContentLoaded", function () {
    console.info("DOM geladen");
    console.info(`${window.location.hostname}`);
    listenToButten();
    listenToSocket();
    
  });
