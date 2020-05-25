"use strict";

const backend_IP = "http://localhost:5000";
const backend = backend_IP + "/api/v1";


const showtempdata = function(jsonObject) {
    console.log(jsonObject);
    let htmlstring = jsonObject;
    document.querySelector(".js-sensor1").innerHTML = htmlstring;
}
const showlicht = function(jsonObject) {
    console.log(jsonObject);
    let htmlstring = jsonObject;
    document.querySelector(".js-sensor2").innerHTML = htmlstring;
}

const gettempdata = function (){
    handleData("http://127.0.0.1:5000/api/v1/tempdata", showtempdata);
};

const getlichtsensor = function (){
    handleData("http://127.0.0.1:5000/api/v1/lichtsensor", showlicht);
};


document.addEventListener("DOMContentLoaded", function () {
    console.info("DOM geladen");
    console.info(`${window.location.hostname}`);
    gettempdata();
    getlichtsensor();
  });