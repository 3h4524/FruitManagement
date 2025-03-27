import model.*;
import dao.GenericDAO;
import jakarta.persistence.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;
import service.ProductService;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ProductServiceTest {

    @Mock
    private GenericDAO<Product> productDAO;

    @Mock
    private EntityManager em;

    @Mock
    private EntityTransaction transaction;

    @InjectMocks
    private ProductService productService;

    @BeforeEach
    void setUp() {
        when(em.getTransaction()).thenReturn(transaction);
    }

    @Test
    void testGetAllProducts() {
        List<Product> products = List.of(new Product(), new Product());
        when(productDAO.getAll()).thenReturn(products);

        List<Product> result = productService.getAllProducts();

        assertEquals(2, result.size());
        verify(productDAO).getAll();
    }

    @Test
    void testGetProductById() {
        Product product = new Product();
        product.setId(1);
        when(productDAO.findById(1)).thenReturn(product);

        Product result = productService.getProductById(1);

        assertNotNull(result);
        assertEquals(1, result.getId());
        verify(productDAO).findById(1);
    }

    @Test
    void testAddProduct() {
        Product product = new Product();
        product.setIsDeleted(false);

        productService.addProduct(product);

        verify(productDAO).insert(product);
        assertFalse(product.getIsDeleted());
    }

    @Test
    void testDeleteProduct() {
        Product product = new Product();
        product.setId(1);
        product.setIsDeleted(false);
        when(productDAO.findById(1)).thenReturn(product);

        productService.deleteProduct(1);

        assertTrue(product.getIsDeleted());
        verify(transaction).begin();
        verify(transaction).commit();
    }

    @Test
    void testDeleteProduct_RollbackOnException() {
        when(productDAO.findById(1)).thenThrow(new RuntimeException("Test exception"));
        when(transaction.isActive()).thenReturn(true);

        assertThrows(RuntimeException.class, () -> productService.deleteProduct(1));
        verify(transaction).rollback();
    }

    @Test
    void testGetSmallSizePrice() {
        BigDecimal price = BigDecimal.valueOf(10.00);
        TypedQuery<BigDecimal> query = mock(TypedQuery.class);
        when(em.createQuery(anyString(), eq(BigDecimal.class))).thenReturn(query);
        when(query.setParameter(anyString(), any())).thenReturn(query);
        when(query.getResultStream()).thenReturn(Stream.of(price));

        BigDecimal result = productService.getSmallSizePrice(1);

        assertEquals(price, result);
    }

    @Test
    void getNumberOfDiscountedProducts_ShouldReturnCount() {
        // Arrange
        TypedQuery<Long> queryMock = mock(TypedQuery.class);
        when(em.createQuery(anyString(), eq(Long.class))).thenReturn(queryMock);
        when(queryMock.getSingleResult()).thenReturn(5L);

        // Act
        int count = productService.getNumberOfDiscountedProducts();

        // Assert
        assertEquals(5, count);
    }

    @Test
    void countFilteredProducts_ShouldReturnFilteredCount() {
        // Arrange
        TypedQuery<Long> queryMock = mock(TypedQuery.class);
        when(em.createQuery(anyString(), eq(Long.class))).thenReturn(queryMock);
        when(queryMock.getSingleResult()).thenReturn(3L);

        // Act
        int count = productService.countFilteredProducts("Test", "1");

        // Assert
        assertEquals(3, count);
    }

}
