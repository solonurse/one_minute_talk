document.addEventListener('turbo:load', function() {
  const attachExampleButtonListener = () => {
    const exampleButton = document.querySelector(".example-button");

    if (exampleButton) {
      exampleButton.addEventListener('click', () => {
        const loadingWrap = document.querySelector(".loading-wrap");
        loadingWrap.classList.add("visible");
      });
    }
  };

  // 初回のページ読み込み時にイベントリスナーをアタッチ
  attachExampleButtonListener();

  document.addEventListener('turbo:render', () => {
    // Turbo Driveが新しいコンテンツを描画した後にイベントリスナーを再度アタッチ
    attachExampleButtonListener();
  });
});
