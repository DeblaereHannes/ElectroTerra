"use strict";

const lanIP = `${window.location.hostname}:5000`;
const socket = io(`http://${lanIP}`);


const callbackUpdate = function (data) {
  console.log(data);
};

const showGrafiek = function (data) {
  console.log(data);
  let converted_labels1 = [];
  let converted_data1 = [];
  let converted_labels2 = [];
  let converted_data2 = [];

  for (const data_el of data.grafiekData[0]) {
    converted_labels1.push(data_el.time);
    converted_data1.push(data_el.waarde);
  }
  for (const data_el of data.grafiekData[1]) {
    converted_labels2.push(data_el.time);
    converted_data2.push(data_el.waarde);
  }
  drawChart(converted_labels1, converted_data1, converted_data2);
};

const drawChart = function (labels1, data1, data2) {
  let ctx = document.querySelector('#myChart').getContext('2d');

  let config = {
    type: 'line',
    data: {
      labels: labels1,
      datasets: [
        {
          label: 'vochtigheid', //label boven de diagram
          backgroundColor: '#49B5AE',
          borderColor: '#49B5AE',
          data: data1,
          fill: false,
          yAxisID: 'y-axis-1',
        },
        {
          label: 'temperatuur', //label boven de diagram
          backgroundColor: '#205955',
          borderColor: '#205955',
          data: data2,
          fill: false,
          yAxisID: 'y-axis-2',
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
      scales: {
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
            type: 'linear',
            position: 'left',
            id: 'y-axis-1',
            display: true,
            scaleLabel: {
              display: true,
              labelString: 'vochtigheid [%]'
            }
          },
          {
            type: 'linear',
            position: 'right',
            id: 'y-axis-2',
            display: true,
            scaleLabel: {
              display: true,
              labelString: 'temperatuur [°C]'
            }
          }
        ]
      }
    }
  };

  let myChart = new Chart(ctx, config);
};

const listenToButten = function () {
  const knoppen = document.querySelectorAll(".js-ventilator");
  console.log(knoppen);
  for (const knop of knoppen) {
    knop.addEventListener("click", function () {
      const status = knop.getAttribute('data-status');
      const jsonObject = { actuatorStatus: status };
      const id = "101"
      console.log(id);
      console.log(jsonObject);
      handleData(`http://${window.location.hostname}:5000/api/v1/actuators/${id}/${status}`, callbackUpdate, null, "PUT", JSON.stringify(jsonObject));
    });
  };
};

const listenToButtenss = function () {
  const knoppen = document.querySelectorAll(".js-led");
  console.log(knoppen);
  for (const knop of knoppen) {
    knop.addEventListener("click", function () {
      const status = knop.getAttribute('data-status');
      const jsonObject = { actuatorStatus: status };
      const id = "102"
      console.log(id);
      console.log(jsonObject);
      handleData(`http://${window.location.hostname}:5000/api/v1/actuators/${id}/${status}`, callbackUpdate, null, "PUT", JSON.stringify(jsonObject));
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
    let htmlstring = `<div class="o-layout o-layout--gutter o-layout--justify-space-between">`;
    for (const sens of jsonObject.data) {
      console.log(sens);
      if (sens.sensorID == 103) {
        htmlstring += `<div class="o-layout__item u-flex-basis-auto"> <div class="o-layout"> <div class="o-layout__item">${sens.time}</div><div class="o-layout__item">Vochtigheid</div><div class="o-layout__item"><h3>${sens.waarde}${sens.eenheid}</h3></div></div></div>`;
      } else {
        if (sens.sensorID == 102) {
          htmlstring += `<div class="o-layout__item u-flex-basis-auto"> <div class="o-layout"> <div class="o-layout__item">${sens.time}</div><div class="o-layout__item">Temperatuur</div><div class="o-layout__item"><h3>${sens.waarde}${sens.eenheid}</h3></div></div></div>`;
        }
      }
    }
    htmlstring += `</div>`
    document.querySelector(".js-data").innerHTML = htmlstring;
  });

};


document.addEventListener("DOMContentLoaded", function () {
  console.info("DOM geladen");
  console.info(`${window.location.hostname}`);
  listenToButten();
  listenToButtenss();
  listenToSocket();
  getData();

});

