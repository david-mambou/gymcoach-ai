import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['set'];

  connect() { //template for future targets
    console.log(this.setTarget);
  }
}
