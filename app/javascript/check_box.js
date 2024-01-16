document.addEventListener('turbo:load', function() {
  const checkboxes = document.querySelectorAll('.element-checkbox');

  checkboxes.forEach(function(checkbox) {
    checkbox.addEventListener('change', () => {
      let checkedCheckboxes = document.querySelectorAll('.element-checkbox:checked');

      if (checkedCheckboxes.length >= 3) {
        checkboxes.forEach(function(checkbox) {
          if (!checkbox.checked) {
            checkbox.disabled = true;
          }
        });
      } else {
        checkboxes.forEach(function(checkbox) {
          checkbox.disabled = false;
        });
      }
    });
  });
});