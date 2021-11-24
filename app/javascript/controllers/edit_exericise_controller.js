import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['exercise'];

  connect() { //template for future targets
    console.log(this.exerciseTarget);
  }
}
