const slideCard = () => {
  document.querySelector(".item-drawer-button")
  .addEventListener("click", () => {
    document.querySelector(".item-drawer").classList.toggle("active");
  });
}

export { slideCard }
