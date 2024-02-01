document.addEventListener('turbo:load', function() {
  const menuOpen = document.querySelector('#menu-open');
  const menuClose = document.querySelector('#menu-close');
  const menuPanel = document.querySelector('#menu-panel');
  const menuOptions = {
    duration: 550,
    easing: 'ease',
    fill: 'forwards',
  };

  if (menuOpen) {
    menuOpen.addEventListener('click', () => {
      menuPanel.animate({translate: ['-100vw', 0]} ,menuOptions);
    });
  }

  if (menuClose) {
    menuClose.addEventListener('click', () => {
      menuPanel.animate({translate: [0, '-100vh']} ,menuOptions);
    });
  }
});