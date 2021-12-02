import { Controller } from "stimulus";

export default class extends Controller {
  // for 'chat' data controller at application.html.rb except message target
  static targets = ['input','chats','form'];

  connect() { 
    // update message 
  }

  update(event) {
    event.preventDefault();
    // console.log(this.formTarget.action);
    // console.log(this.inputTarget.value);

    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    
    Rails.fire(this.formTarget, 'submit')

    // fetch(url, { method: 'POST', headers: { 'Accept': 'text/javascript' } })
    //   .then(response => response.text()) // parse JSON 
    //   // .then(response => response.text()) // 
    //   .then((data) => {

    //     console.log(data);
    //     // this.chatsTarget.outerHTML = data;
    //   })

    // this.formTarget.insertAdjacentHTML('beforeend', this.inputTarget.value);
  }
};
