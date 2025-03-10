import model.Product;
import service.ProductService;

import java.math.BigDecimal;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        ProductService productService = new ProductService();

        // Kiểm tra lấy danh sách sản phẩm
        List<Product> products = productService.getAllProducts();

        if (products.isEmpty()) {
            System.out.println("Không có sản phẩm nào trong cơ sở dữ liệu.");
        } else {
            System.out.println("Danh sách sản phẩm:");
            for (Product product : products) {
                System.out.println("ID: " + product.getId() +
                        ", Name: " + product.getName() );
            }
        }
    }
}
