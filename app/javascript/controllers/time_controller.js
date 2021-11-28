import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [''];

  connect() { //template for future targets
    // console.log(this.exerciseTarget);
    const time = new Date();
    console.log(time.getHours() + ":" + time.getMinutes());

  }
}
