document.addEventListener('turbo:load', () => {
  const reminderTypeToggle = document.getElementById('reminderTypeToggle');
  const toggleLabel = document.querySelector('.on-off-label');
  if (reminderTypeToggle && toggleLabel) {
    reminderTypeToggle.addEventListener('change', () => {
      if (reminderTypeToggle.checked) {
        toggleLabel.textContent = 'ON';
      } else {
        toggleLabel.textContent = 'OFF';
      }
    });
  }
});