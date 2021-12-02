const date = new Date();

const renderCalendar = () => {
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


        const finished_workouts = document.querySelector(".calendar-container");
        finished_workouts.getAttribute('data-workouts')
        let dates = JSON.parse(finished_workouts.getAttribute('data-workouts'))
        dates = dates.map(date => new Date(date))
        dates = dates.filter((workout)  => {
          if (
            date.getMonth() == workout.getMonth() &&
            date.getYear() == workout.getYear()) {
              return workout
            }
          })
          // ______________________USE THIS TO PLOT GRAPH_______________________________


          for (let day = 1; day <= lastDay; day++) {
            if (
              day === new Date().getDate() &&
              date.getMonth() === new Date().getMonth()
              ) {
                days += `<div class="today">${day}</div>`;
              } else if (){
              } else {
                days += `<div>${day}</div>`;
              }
            }
            // ______________________USE THIS TO PLOT GRAPH_______________________________
            // pass an array of dates to javascript (data attributes (maps -markers))
            // follow logic above - if the form calendar included in array of workouts, add class
            // ___________________________________________________________________



            console.log(dates)


            // ___________________________________________________________________

            for (let nextDay = 1; nextDay <= nextDays; nextDay++) {
              days += `<div class="next-date">${nextDay}</div>`;
            }
            monthDays.innerHTML = days;
          };

          document.querySelector(".prev").addEventListener("click", () => {
            date.setMonth(date.getMonth() - 1);
            renderCalendar();
          });

          document.querySelector(".next").addEventListener("click", () => {
            date.setMonth(date.getMonth() + 1);
            renderCalendar();
          });

          renderCalendar();

          export { renderCalendar };
