// window.addEventListener('DOMContentLoaded', function() {
document.addEventListener('turbo:load', function() {
  const exampleButton = document.querySelector(".example-button");

  if (exampleButton) {
    exampleButton.addEventListener('click', () => {
      const loadingWrap = document.querySelector(".loading-wrap");
      loadingWrap.classList.add("visible");
    });
  }
});
