import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['workout', 'set', 'exercise'];

  connect() { //template future targets
    console.log(this.workoutTarget);
    console.log(this.setTarget);
    console.log(this.exerciseTarget);
  }

  update() {
    console.log("updating!")
  }

}
