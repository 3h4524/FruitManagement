document.addEventListener("DOMContentLoaded", function () {
    var geocoder = new GoongGeocoder({
        accessToken: '9b93jlj2SkAPiBDgyFHZrZSFU4meMnz1zLp3eGnf'
    });
    geocoder.addTo('#geocoder');

    geocoder.on('result', function (e) {
        console.log("Kết quả từ Goong API:", e);

        // Kiểm tra nếu dữ liệu nằm trong e.result.result
        let data = e.result.result || e.result;

        if (!data || !data.formatted_address || !data.compound) {
            console.error("Không nhận được địa chỉ hợp lệ!");
            return;
        }

        // Lấy địa chỉ từ API Goong
        const street = data.name || "";
        const ward = data.compound.commune || "";
        const district = data.compound.district || "";
        const city = data.compound.province || "";

        // Phát sự kiện để cập nhật địa chỉ trong JSP
        document.dispatchEvent(new CustomEvent("addressSelected", {
            detail: { street, ward, district, city }
        }));
    });

    geocoder.on('clear', function () {
        console.log("Địa chỉ đã bị xóa");
        document.dispatchEvent(new Event("addressCleared"));
    });
});
