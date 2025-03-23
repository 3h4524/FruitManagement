import model.ProductVariant;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import dao.GenericDAO;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class ProductVariantServiceTest {
    @Mock
    private GenericDAO<ProductVariant> productVariantDao;

    @InjectMocks
    private ProductVariantService productVariantService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetProductVariantById() {
        // Giả lập một biến thể sản phẩm có ID = 1
        ProductVariant variant = new ProductVariant();
        variant.setId(1);
        variant.setSize("Medium");
        variant.setPrice(new BigDecimal("10.99"));

        // Khi gọi findById(1), giả lập trả về đối tượng variant
        when(productVariantDao.findById(1)).thenReturn(variant);

        // Gọi phương thức getProductVariantById
        ProductVariant result = productVariantService.getProductVariantById(1);

        // Kiểm tra xem kết quả có đúng không
        assertNotNull(result);
        assertEquals(1, result.getId());
        assertEquals("Medium", result.getSize());
    }

    @Test
    void testGetAllProductVariants() {
        // Giả lập danh sách biến thể sản phẩm của một productID cụ thể
        int productId = 100;
        ProductVariant variant1 = new ProductVariant();
        variant1.setId(1);
        variant1.setProductID(productId);
        variant1.setSize("Small");

        ProductVariant variant2 = new ProductVariant();
        variant2.setId(2);
        variant2.setProductID(productId);
        variant2.setSize("Large");

        List<ProductVariant> variantList = Arrays.asList(variant1, variant2);
        when(productVariantDao.findByAttribute("productID", productId)).thenReturn(variantList);

        // Gọi phương thức
        List<ProductVariant> result = productVariantService.getAllProductVariants(productId);

        // Kiểm tra xem danh sách trả về có đúng số lượng và phần tử không
        assertEquals(2, result.size());
        assertEquals("Small", result.get(0).getSize());
        assertEquals("Large", result.get(1).getSize());
    }

    @Test
    void testAddProductVariant() {
        // Tạo một biến thể sản phẩm mới
        ProductVariant variant = new ProductVariant();
        variant.setId(3);
        variant.setSize("Medium");
        variant.setPrice(new BigDecimal("15.99"));

        // Gọi phương thức addProductVariant
        productVariantService.addProductVariant(variant);

        // Kiểm tra xem phương thức insert đã được gọi đúng không
        verify(productVariantDao, times(1)).insert(variant);
    }

    @Test
    void testUpdateVariant() {
        // Tạo một biến thể sản phẩm có sẵn
        ProductVariant variant = new ProductVariant();
        variant.setId(4);
        variant.setSize("Large");
        variant.setPrice(new BigDecimal("20.99"));

        // Giả lập hành động cập nhật
        productVariantService.updateVariant(variant);

        // Kiểm tra xem phương thức update đã được gọi đúng không
        verify(productVariantDao, times(1)).update(variant);
    }

    @Test
    void testDeleteProductVariant() {
        // Giả lập một biến thể sản phẩm chưa bị xóa
        ProductVariant variant = new ProductVariant();
        variant.setId(5);
        variant.setIsDeleted(false);

        // Giả lập khi gọi findById sẽ trả về biến thể sản phẩm này
        when(productVariantDao.findById(5)).thenReturn(variant);

        // Gọi phương thức deleteProductVariant
        productVariantService.deleteProductVariant(5);

        // Kiểm tra xem biến thể sản phẩm đã bị đánh dấu là xóa chưa
        assertTrue(variant.getIsDeleted());
    }
}
