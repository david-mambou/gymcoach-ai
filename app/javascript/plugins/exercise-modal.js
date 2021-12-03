const showModal = (event, modalId) => {
  event.preventDefault();
  $(modalId).modal('show');
};

const initExerciseModal = () => {
  const exerciseButtons = document.querySelectorAll('.exercise-button');
  if (exerciseButtons) {
    exerciseButtons.forEach((button) => {
      button.addEventListener('click', (event) => showModal(event, `#instructions-${button.dataset.exerciseid}`));
    });
  };
};

export { initExerciseModal };
