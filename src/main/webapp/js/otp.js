document.addEventListener("DOMContentLoaded", function () {
    const otpButton = document.getElementById("otpButton");
    if (otpButton) {
        otpButton.addEventListener("click", function () {
            let type = otpButton.getAttribute("data-type");
            console.log("Type", type);// Lấy type từ thuộc tính data
            requestOTP(type);
        });
    }
});

function requestOTP(type) {
    let email = document.getElementById("email").value;
    let otpField = document.getElementById("otpField");
    let otpButton = document.getElementById("otpButton");
    let errorMessage = document.getElementById("errorMessage");

    if (!email.trim()) {
        errorMessage.innerText = "Vui lòng nhập email trước khi nhận mã OTP!";
        return;
    }

    // Xóa thông báo lỗi trước đó
    errorMessage.innerText = "";

    otpButton.disabled = true;
    otpButton.innerText = "Đang gửi...";

    fetch(contextPath + '/mails?action=sendOtp', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'email=' + encodeURIComponent(email) + '&type=' + encodeURIComponent(type)
    })
        .then(response => response.text())
        .then(data => {
            console.log("Server response:", data); // In phản hồi từ server ra console

            if (data.startsWith("success")) {
                alert("Mã OTP đã được gửi! Vui lòng kiểm tra email.");
                otpField.style.display = "block"; // Hiện ô nhập OTP
                startOTPTimer(otpButton);
            } else if (data.startsWith("error:")) {
                errorMessage.innerText = data.substring(6); // Hiển thị lỗi từ server
                otpButton.disabled = false;
                otpButton.innerText = "Nhận mã";
            } else {
                errorMessage.innerText = "Lỗi không xác định! Vui lòng thử lại.";
                console.log("Unexpected response:", data); // In response ra console để kiểm tra
                otpButton.disabled = false;
                otpButton.innerText = "Nhận mã";
            }
        })
        .catch(error => {
            console.error("Fetch error:", error);
            errorMessage.innerText = "Không thể gửi yêu cầu! Kiểm tra kết nối mạng.";
            otpButton.disabled = false;
            otpButton.innerText = "Nhận mã";
        });
}

function startOTPTimer(button) {
    button.disabled = true;
    otpCooldown = 10;
    otpTimer = setInterval(() => {
        button.innerText = "Nhận mã (" + otpCooldown + "s)";
        otpCooldown--;
        if (otpCooldown < 0) {
            clearInterval(otpTimer);
            button.innerText = "Nhận mã";
            button.disabled = false;
        }
    }, 1000);
}
