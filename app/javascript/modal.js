document.addEventListener('turbo:load', function() {
  const open = document.querySelector('#open');
  const close = document.querySelector('#close');
  const modal = document.querySelector('#modal');
  const mask = document.querySelector('#mask');

  const pyramidOpen = document.querySelector('#pyramid-open');
  const pyramidClose = document.querySelector('#pyramid-close');
  const pyramidModal = document.querySelector('#pyramid-modal');
  const pyramidMask = document.querySelector('#pyramid-mask');

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

  if (pyramidOpen) {
    pyramidOpen.addEventListener('click', () => {
      pyramidModal.animate(showkeyframes, options);
      pyramidMask.animate(showkeyframes, options);
    });
  }

  if (pyramidClose) {
    pyramidClose.addEventListener('click', () => {
      pyramidModal.animate(hidekeyframes, options);
      pyramidMask.animate(hidekeyframes, options);
    });
  }

  if (pyramidMask) {
    pyramidMask.addEventListener('click', () => {
      pyramidClose.click();
    });
  }
});