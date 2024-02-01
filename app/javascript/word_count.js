document.addEventListener('turbo:load', function() {
  const sentenceForm = document.getElementById("sentence-form");
  const sentenceCounter = document.getElementById("sentence-counter");
  const speakingTime = document.getElementById("speaking-time");

  if (sentenceForm) {
    sentenceForm.addEventListener("keyup", () => {
      sentenceCounter.textContent = sentenceForm.value.length;
      if (sentenceForm.value.length > 300) {
        sentenceCounter.classList.add('text-danger');
      } else {
        sentenceCounter.classList.remove('text-danger');
      }
  
      speakingTime.textContent = Math.round(sentenceForm.value.length / 300 * 60);
      if (speakingTime.textContent > 60) {
        speakingTime.classList.add('text-danger');
      } else {
        speakingTime.classList.remove('text-danger');
      }
    });
  
    sentenceForm.addEventListener("keydown", () => {
      sentenceCounter.textContent = sentenceForm.value.length;
    });
  }
});