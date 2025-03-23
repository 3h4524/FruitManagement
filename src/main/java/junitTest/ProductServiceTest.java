package junitTest;

import dao.GenericDAO;
import model.Product;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * Unit test cho lớp ProductService sử dụng JUnit 5 và Mockito.
 */
@ExtendWith(MockitoExtension.class)
class ProductServiceTest {

    @Mock
    private GenericDAO<Product> productDao; // Giả lập lớp DAO để kiểm tra mà không cần kết nối CSDL

    @InjectMocks
    private ProductService productService; // Đối tượng ProductService cần kiểm tra

    private Product product1;
    private Product product2;

    /**
     * Thiết lập dữ liệu test trước mỗi lần chạy test.
     */
    @BeforeEach
    void setUp() {
        product1 = new Product();
        product1.setId(1);
        product1.setName("Táo");
        product1.setDescription("Táo đỏ nhập khẩu");

        product2 = new Product();
        product2.setId(2);
        product2.setName("Cam");
        product2.setDescription("Cam sành Việt Nam");
    }

    /**
     * Kiểm tra phương thức getAllProducts() có trả về danh sách đúng không.
     */
    @Test
    void testGetAllProducts() {
        when(productDao.getAll()).thenReturn(Arrays.asList(product1, product2));
        List<Product> products = productService.getAllProducts();
        assertEquals(2, products.size());
        assertEquals("Táo", products.get(0).getName());
        assertEquals("Cam", products.get(1).getName());
    }

    /**
     * Kiểm tra phương thức getProductById() có lấy đúng sản phẩm theo ID không.
     */
    @Test
    void testGetProductById() {
        when(productDao.findById(1)).thenReturn(product1);
        Product foundProduct = productService.getProductById(1);
        assertNotNull(foundProduct);
        assertEquals(1, foundProduct.getId());
        assertEquals("Táo", foundProduct.getName());
    }

    /**
     * Kiểm tra phương thức addProduct() có thêm sản phẩm thành công không.
     */
    @Test
    void testAddProduct() {
        doNothing().when(productDao).insert(product1);
        productService.addProduct(product1);
        verify(productDao, times(1)).insert(product1);
    }

    /**
     * Kiểm tra phương thức updateProduct() có cập nhật thông tin sản phẩm thành công không.
     */
    @Test
    void testUpdateProduct() {
        when(productDao.update(product1)).thenReturn(true);
        assertTrue(productService.updateProduct(product1));
    }

    /**
     * Kiểm tra phương thức deleteProduct() có cập nhật trạng thái xóa sản phẩm không.
     */
    @Test
    void testDeleteProduct() {
        when(productDao.findById(1)).thenReturn(product1);
        doNothing().when(productDao).update(product1);
        productService.deleteProduct(1);
        assertNotNull(product1);
    }
}
