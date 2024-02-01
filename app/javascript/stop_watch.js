document.addEventListener('turbo:load', function() {
  const time = document.getElementById("timer");
  const startButton = document.getElementById("start-time");
  const stopButton = document.getElementById("stop-time");
  const resetButton = document.getElementById("reset-time");

  let startTime;
  let stopTime = 0;
  let timeoutID;

  function displayTime() {
    const currentTime = new Date(Date.now() - startTime + stopTime);
    const minute = String(currentTime.getMinutes()).padStart(2, "0");
    const second = String(currentTime.getSeconds()).padStart(2, "0");
    const miliSecond = String(currentTime.getMilliseconds()).padStart(3, "0").slice(0, 2);

    time.textContent = `${minute}:${second}.${miliSecond}`;
    timeoutID = setTimeout(displayTime, 10);
  };

  if (startButton) {
    startButton.addEventListener('click', () => {
      startButton.disabled = true;
      stopButton.disabled = false;
      resetButton.disabled = true;
  
      startTime = Date.now();
      displayTime();
    });
  }

  if (stopButton) {
    stopButton.addEventListener('click', () => {
      startButton.disabled = false;
      stopButton.disabled = true;
      resetButton.disabled = false;
      clearTimeout(timeoutID);
      stopTime += (Date.now() - startTime);
    });
  }

  if (resetButton) {
    resetButton.addEventListener('click', () => {
      startButton.disabled = false;
      stopButton.disabled = true;
      resetButton.disabled = true;
      time.textContent = '00:00.00';
      stopTime = 0;
    });
  }
});