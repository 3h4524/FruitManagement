import model.OrderDetail;
import model.Product;
import service.OrderService;
import service.ProductService;

import java.math.BigDecimal;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        OrderService orderService = new OrderService();
        int userId = 4;
        System.out.println("Lấy danh sách đơn hàng của user ID: " + userId);

        // Gọi hàm getOrderDetailsByUserId()
        List<OrderDetail> orderDetails = orderService.getOrderDetailsByUserId(userId);

        // Kiểm tra kết quả
        if (orderDetails.isEmpty()) {
            System.out.println("Không có đơn hàng nào cho User ID: " + userId);
        } else {
            for (OrderDetail detail : orderDetails) {
                System.out.println("Ảnh: " + detail.getProductVariantID().getProductID().getImageURL());
                System.out.println("Sản phẩm: " + detail.getProductVariantID().getProductID().getName());
                System.out.println("Số lượng: " + detail.getQuantity());
                System.out.println("Giá: " + detail.getProductVariantID().getPrice());
                System.out.println("-------------------------------");
            }
        }
    }
}
