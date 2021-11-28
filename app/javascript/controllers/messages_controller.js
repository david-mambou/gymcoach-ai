import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['message'];


  connect() { //template for future targets
    const message = this.messageTargets[this.messageTargets.length - 1]
    message.scrollIntoView();
  }
};
