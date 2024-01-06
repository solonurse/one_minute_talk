document.addEventListener("DOMContentLoaded", function () {
  const elementContainer = document.getElementById("element-container");
  const addButton = document.getElementById("add-button");
  let formNum = 0;
  
  addButton.addEventListener("click",  () => {
    const newForm = document.createElement("input");
    const newButton = document.createElement("button");
    
    formNum += 1
    newForm.setAttribute("id", `element-form_${formNum}`);
    newForm.setAttribute("class", "form-control w-50 mx-auto my-3");
    newForm.setAttribute("type", "text");
    newForm.setAttribute("name", "element");
    elementContainer.appendChild(newForm);
  })
})