import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['progress'];

  connect() { //template for future targets
    // Need to move this code for it to work specifically to one button
    $(document).on("click", function() {
      $("#progress").toggle();
    });
  }
}
