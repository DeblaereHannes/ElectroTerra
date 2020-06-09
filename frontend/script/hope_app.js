"use strict";

const lanIP = `${window.location.hostname}:5000`;
const socket = io(`http://${lanIP}`);


const callbackUpdate = function (data) {
  console.log(data);
};

const showGrafiek = function (data) {
  console.log(data);
  let converted_labels = [];
  let converted_data = [];

  for (const data_el of data.grafiekData){
    converted_labels.push(data_el.time);
    converted_data.push(data_el.waarde);
  }
  drawChart(converted_labels, converted_data);
};

const drawChart = function(labels, data) {
  let ctx = document.querySelector('#myChart').getContext('2d');

  let config = {
      type: 'line',
      data: {
          labels: labels,
          datasets: [
              {
                  label: 'vochtigheid', //label boven de diagram
                  backgroundColor: '#49B5AE',
                  borderColor: '#49B5AE',
                  data: data,
                  fill: false,

              },
              {
                label: 'temperatuur', //label boven de diagram
                backgroundColor: '#205955',
                borderColor: '#205955',
                data: null,
                fill: false,

            }
          ]
      },
      options: { //verandert style en behaviour
          responsive: false,
          title: {
              display: true,
              text: ''
          },
          tooltips: {
              mode: 'index',
              intersect: true
          },
          hover: {
              xAxes: [
                  {
                      display: true,
                      scaleLabel: {
                          display: true,
                          labelString: 'tijden'
                      }
                  }
              ],
              yAxes: [
                  {
                      display: true,
                      scaleLabel: {
                          display: true,
                          labelString: 'waardes'
                      }
                  }
              ]
          }
      }
  };

  let myChart = new Chart(ctx, config);
};

const listenToButten = function () {
  const knoppen = document.querySelectorAll(".js-power-btn");
  console.log(knoppen);
  for (const knop of knoppen) {
    knop.addEventListener("click", function () {
      const status = knop.getAttribute('data-status');
      const jsonObject = { actuatorStatus: status };
      const id = this.dataset.actuatorid;
      console.log(id);
      console.log(jsonObject);
      handleData(`http://${window.location.hostname}:5000/api/v1/actuators/${id}`, callbackUpdate, null, "PUT", JSON.stringify(jsonObject));
    });
  };
};

const getData = function () {
  handleData(`http://${window.location.hostname}:5000/api/v1/sensors/grafiek`, showGrafiek);
};


const listenToSocket = function () {
  socket.on("connected", function () {
    console.log("verbonden met socket webserver");
  });

  socket.on("B2F_data", function (jsonObject) {
    console.log("antw van back");
    console.log(jsonObject);
    let htmlstring = "";
    for (const sens of jsonObject.data) {
      console.log(sens);
      if (sens.sensorID == 103){
        htmlstring += `<div class="center"><p>vochtigheid ${sens.waarde}${sens.eenheid} ${sens.time}</p></div>`;
      } else {
      if (sens.sensorID == 102){
        htmlstring += `<div class="center"><p>temperatuur ${sens.waarde}${sens.eenheid} ${sens.time}</p></div>`;
      }
      }
    }
    document.querySelector(".js-data").innerHTML = htmlstring;
  });

};


document.addEventListener("DOMContentLoaded", function () {
  console.info("DOM geladen");
  console.info(`${window.location.hostname}`);
  listenToButten();
  listenToSocket();
  getData();

});

