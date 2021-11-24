import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['workout'];

  connect() { //template for future targets
    console.log(this.workoutTarget);
  }
}
