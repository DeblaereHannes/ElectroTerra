"use strict";

const lanIP = `${window.location.hostname}:5000`;
const socket = io(`http://${lanIP}`);


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
    listenToSocket();
  });
