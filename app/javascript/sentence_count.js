document.addEventListener('turbo:load', function() {
  const sentenceForm = document.getElementById("sentence-form");
  const sentenceCounter = document.getElementById("sentence-counter");

  sentenceForm.addEventListener("keyup", () => {
    sentenceCounter.textContent = sentenceForm.value.length;

    if (sentenceForm.value.length > 300) {
      sentenceCounter.classList.add('text-danger');
    } else {
      sentenceCounter.classList.remove('text-danger');
    }
  });

  sentenceForm.addEventListener("keydown", () => {
    sentenceCounter.textContent = sentenceForm.value.length;
  });
});