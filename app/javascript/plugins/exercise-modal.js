const showModal = (event, modalId) => {
  event.preventDefault();
  $(modalId).modal('show');
};

// const hideModal = (event, modalId) => {
//   event.preventDefault();
//   $(modalId).modal('hide');
// };

const initExerciseModal = () => {
  const exerciseButtons = document.querySelectorAll('.exercise-button');

  if (exerciseButtons) {
    exerciseButtons.forEach((button) => {
      button.addEventListener('click', (event) => showModal(event, `#instructions-${button.dataset.exerciseid}`));
    });
    // cancelButton.forEach((button) => {
    //   button.addEventListener('click', (event) => hideModal(event, `#new-booking-${button.dataset.serviceid}`));
    // });
  };
};


export { initExerciseModal };
