/* パスワードを表示・非表示のボタンをクリック時に設定する関数 */
function bindPasswordToggles() {
  document.querySelectorAll(".toggle_password").forEach(function(button) {
    if (button.dataset.bound === "true") return;
    button.dataset.bound = "true";

    button.style.opacity = "1";
    button.style.visibility = "visible";
    button.style.display = "inline-block";
    button.innerHTML = '<span aria-hidden="true">表示</span>';

    button.addEventListener("mousedown", function(event) {
      event.preventDefault();
    });

    button.addEventListener("click", function(event) {
      event.preventDefault();
      const wrapper = this.closest(".password_field");
      const input = wrapper?.querySelector("input[type='password'], input[type='text']");
      if (!input) return;

      const showing = input.type === "text";
      input.type = showing ? "password" : "text";
      this.innerHTML = showing ? '<span aria-hidden="true">表示</span>' : '<span aria-hidden="true">非表示</span>';
      input.focus();
    });
  });
}

document.addEventListener("turbo:load", function() {
  bindPasswordToggles();
});
/*ログインエラーが発生した場合の処理*/
document.addEventListener("turbo:render", function() {
  bindPasswordToggles();
});