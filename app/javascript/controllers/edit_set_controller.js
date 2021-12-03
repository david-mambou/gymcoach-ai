import { Controller } from "stimulus";
import { initExerciseModal } from '../plugins/exercise-modal';
import { updateSliderLabel } from '../components/slider';

export default class extends Controller {
  static targets = ['form'];

  connect() { //template for future targets
  }

  update(event) {
    event.preventDefault();
    const url = this.formTarget.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.element.outerHTML = data;
        initExerciseModal();
        updateSliderLabel();
      })

  }
}
// stimulus not working with form submission
