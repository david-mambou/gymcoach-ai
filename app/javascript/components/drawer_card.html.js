const slideCard = () => {
  document.querySelector(".item-drawer-button")
  .addEventListener("click", (event) => {
    document.querySelector(".item-drawer").classList.toggle("active");
  });
}
