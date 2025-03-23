document.addEventListener("DOMContentLoaded", function () {
    let phoneInput = document.getElementById("phone");
    let phoneError = document.getElementById("phoneError");
    let form = document.getElementById("userForm"); // Đặt `id="userForm"` vào form

    function validatePhone() {
        let phonePattern = /^(0[1-9][0-9]{8}|84[1-9][0-9]{8})$/; // Định dạng số điện thoại VN
        let phoneValue = phoneInput.value.trim();

        if (phoneValue === "" || phonePattern.test(phoneValue)) {
            phoneError.classList.add("d-none");
            return true;
        } else {
            phoneError.classList.remove("d-none");
            return false;
        }
    }

    // Kiểm tra khi nhập liệu
    phoneInput.addEventListener("input", validatePhone);

    // Kiểm tra khi submit form
    form.addEventListener("submit", function (event) {
        if (!validatePhone()) {
            event.preventDefault(); // Chặn gửi form nếu sai số điện thoại
            alert("Số điện thoại không hợp lệ!"); // Hiển thị thông báo
        }
    });
});
