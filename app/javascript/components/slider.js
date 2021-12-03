const updateSliderLabel = () => {
  const sliderLabels = document.querySelectorAll('.difficulty-label');
  const sliders = document.querySelectorAll('.difficulty-slider');
  const values = ['Easy', 'Okay', 'Hard', 'Very Hard', 'Failed']
  if (sliderLabels) {
    sliders.forEach((slider) => {
      slider.addEventListener('mouseup', (event) => {
        const label = document.querySelector(`.difficulty-label-${slider.dataset.workoutid}`);
        label.innerHTML = values[slider.value];
      });
    });
  };
};

export { updateSliderLabel };
