const renderCalendar = (date = new Date()) => {
  // const date = new Date();
  date.setDate(1);

  const monthDays = document.querySelector(".days");

  const lastDay = new Date(
    date.getFullYear(),
    date.getMonth() + 1,
    0
  ).getDate();

  const prevLastDay = new Date(
      date.getFullYear(),
      date.getMonth(),
      0
  ).getDate();

  const firstDayIndex = date.getDay();

  const lastDayIndex = new Date(
    date.getFullYear(),
    date.getMonth() + 1,
    0
  ).getDay();

  const nextDays = 7 - lastDayIndex - 1;

  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  document.querySelector(".date h1").innerHTML = months[date.getMonth()];

  document.querySelector(".date p").innerHTML = new Date().toDateString();

  let days = "";

  for (let prevDay = firstDayIndex; prevDay > 0; prevDay--) {
    days += `<div class="prev-date">${prevLastDay - prevDay + 1}</div>`;
  }

  // Here we select the container we want to target
  const finished_workouts = document.querySelector(".calendar-container");
  // Here we get the attribute we assigned in the html (which was to_json ed)
  finished_workouts.getAttribute('data-workouts')
  // Here we use let so we can reassign, but we also parsed/translated the line above to javascript "language"
  let dates = JSON.parse(finished_workouts.getAttribute('data-workouts'))
  // Here we map and assign a new "date" to turn the js date into a readable date and re-asign dates
  dates = dates.map(date => new Date(date))
  // Here we filter just the workout dates that we are looking for
  dates = dates.filter((workout)  => {
  if ( //In these two lines we get and comparing the current date AND current month with workout date/month
    date.getMonth() == workout.getMonth() &&
    date.getYear() == workout.getYear()) {
      // Make sure to return multiline statements
      return workout
    }
  })
  //Here we re-asign dates again by getting the day and return the Date of that day
  dates = dates.map((date) => {
    return  date.getDate()
  })
  // ______________________USE THIS TO PLOT GRAPH_______________________________


  for (let day = 1; day <= lastDay; day++) {
    if (
      day === new Date().getDate() &&
      date.getMonth() === new Date().getMonth()
      ) {
        days += `<div class="today">${day}</div>`;
        // Here we get the the specific date of the day and check if its included in our "array"
    } else if (dates.includes(day)){
      days += `<div class="worked-out-day">${day}</div>`;
    } else {
      days += `<div>${day}</div>`;
    }
  }
  // ______________________USE THIS TO PLOT GRAPH_______________________________
  // pass an array of dates to javascript (data attributes (maps -markers))
  // follow logic above - if the form calendar included in array of workouts, add class
  // ___________________________________________________________________

  for (let nextDay = 1; nextDay <= nextDays; nextDay++) {
    days += `<div class="next-date">${nextDay}</div>`;
  }
  monthDays.innerHTML = days;

  document.querySelector(".prev").addEventListener("click", () => {
    date.setMonth(date.getMonth() - 1);
    const newDate = new Date(date);
    renderCalendar(newDate);
  });

  document.querySelector(".next").addEventListener("click", () => {
    date.setMonth(date.getMonth() + 1);
    const newDate = new Date(date);
    renderCalendar(newDate);
  });

};


// renderCalendar();

export { renderCalendar };
