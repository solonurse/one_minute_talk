document.addEventListener('turbo:load', function() {
  const open = document.querySelector('#open');
  const close = document.querySelector('#close');
  const modal = document.querySelector('#modal');
  const mask = document.querySelector('#mask');
  const showkeyframes = {
    opacity: [0, 1],
    visibility: 'visible',
  };
  const hidekeyframes = {
    opacity: [1, 0],
    visibility: 'hidden',
  };
  const options = {
    duration: 800,
    easing: 'ease',
    fill: 'forwards',
  };

  if (open) {
    open.addEventListener('click', () => {
      modal.animate(showkeyframes, options);
      mask.animate(showkeyframes, options);
    });
  }

  if (close) {
    close.addEventListener('click', () => {
      modal.animate(hidekeyframes, options);
      mask.animate(hidekeyframes, options);
    });
  }

  if (mask) {
    mask.addEventListener('click', () => {
      close.click();
    });
  }
});