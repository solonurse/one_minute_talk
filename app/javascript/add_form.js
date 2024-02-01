document.addEventListener("DOMContentLoaded", function () {
  document.addEventListener('turbo:load', function() {
    const elementContainer = document.getElementById("element-container");
    const addButton = document.getElementById("add-button");
    let formNum = 0;
    let elementNum = 1;

    if (addButton) {
      addButton.addEventListener("click",  () => {
        const newForm = document.createElement("input");
        formNum += 1;
        elementNum += 1;
        newForm.setAttribute("id", `element-form_${formNum}`);
        newForm.setAttribute("class", "form-control w-50 mx-auto my-3");
        newForm.setAttribute("type", "text");
        newForm.setAttribute("name", `element_${elementNum}`);
        elementContainer.appendChild(newForm);
      });
    }
  });
});
