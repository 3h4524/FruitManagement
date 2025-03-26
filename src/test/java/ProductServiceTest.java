//import static org.mockito.Mockito.*;
//
//import model.Product;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import service.InventoryLogService;
//import service.ProductService;
//import service.ProductStockService;
//import service.ProductVariantService;
//
//import java.math.BigDecimal;
//import java.time.Instant;
//
//public class ProductServiceTest {
//    private ProductService productService;
//    private ProductStockService productStockService;
//    private InventoryLogService inventoryLogService;
//    private ProductVariantService productVariantService;
//    private Product product;
//
//    @BeforeEach
//    void setUp() {
//        productService = new ProductService();
//        productStockService = new ProductStockService();
//        inventoryLogService = new InventoryLogService();
//        productVariantService = new ProductVariantService();
//        product = new Product();
//        product.setId(1);
//        product.setName("Old Name");
//        product.setPrice(BigDecimal.ONE);
//        product.setImageURL("old_url");
//        product.setDescription("Old description");
//        product.setIsDeleted(false);
//        product.setImportDate(Instant.now());
//    }
//
//    @Test
//    void testUpdateProductDetails_ProductNotFound(){
//        when(productService.getProductById(999)).thenReturn(null); // Giả lập trả về null
//
//        productService.updateProductDetails(999, "New Name", "New Description", "new_url", new String[]{"M"}, new String[]{"100"}, new String[]{"10"});
//        verify(productService, never()).updateProduct(any());
//    }
//}
