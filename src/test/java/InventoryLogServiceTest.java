
import dao.GenericDAO;
import jakarta.persistence.*;
import model.InventoryLog;
import model.Product;
import model.ProductVariant;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import service.InventoryLogService;

import java.time.Instant;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class InventoryLogServiceTest {

    @Mock
    private GenericDAO<InventoryLog> inventoryLogDAO;

    @Mock
    private EntityManagerFactory emf;

    @Mock
    private EntityManager em;

    @Mock
    private EntityTransaction tx;

    @InjectMocks
    private InventoryLogService inventoryLogService;

    private InventoryLog sampleLog;

    @BeforeEach
    void setUp() {
        sampleLog = new InventoryLog();
        sampleLog.setId(1);
        sampleLog.setQuantityChanged(10);
        sampleLog.setActionType("ADD");
        sampleLog.setActionDate(Instant.now());
    }

    @Test
    void testGetAllInventory() {
        when(inventoryLogDAO.getAll()).thenReturn(Collections.singletonList(sampleLog));

        List<InventoryLog> logs = inventoryLogService.getAllInventory();

        assertNotNull(logs);
        assertEquals(1, logs.size());
        verify(inventoryLogDAO, times(1)).getAll();
    }

    @Test
    void testGetInventoryById() {
        when(inventoryLogDAO.findById(1)).thenReturn(sampleLog);

        InventoryLog log = inventoryLogService.getInventoryById(1);

        assertNotNull(log);
        assertEquals(1, log.getId());
        verify(inventoryLogDAO, times(1)).findById(1);
    }

    @Test
    void testDeleteInventoryByProductVariantId() {
        when(emf.createEntityManager()).thenReturn(em);
        when(em.getTransaction()).thenReturn(tx);
        Query mockQuery = mock(Query.class);
        when(em.createQuery(anyString())).thenReturn(mockQuery);
        when(mockQuery.setParameter(anyString(), anyInt())).thenReturn(mockQuery);
        when(mockQuery.executeUpdate()).thenReturn(1);

        inventoryLogService.deleteInventoryByProductVariantId(1);

        verify(tx, times(1)).begin();
        verify(mockQuery, times(1)).executeUpdate();
        verify(tx, times(1)).commit();
        verify(em, times(1)).close();
    }

    @Test
    void testListWithOffset() {
        when(emf.createEntityManager()).thenReturn(em);
        Query mockQuery = mock(Query.class);
        when(em.createQuery(anyString(), eq(Object[].class))).thenReturn((TypedQuery<Object[]>) mockQuery);
        when(mockQuery.setFirstResult(anyInt())).thenReturn(mockQuery);
        when(mockQuery.setMaxResults(anyInt())).thenReturn(mockQuery);
        when(mockQuery.getResultStream()).thenReturn(Collections.singletonList(
                new Object[]{"Apple", "Large", 10, "ADD", Instant.now(), "Warehouse"}
        ).stream());

        List<Map<String, Object>> result = inventoryLogService.listWithOffset(1, 10);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("Apple", result.get(0).get("productName"));

        verify(em, times(1)).close();
    }

    @Test
    void testHasNextPage() {
        when(inventoryLogDAO.hasNextPage(1, 10)).thenReturn(true);

        boolean result = inventoryLogService.hasNextPage(1, 10);

        assertTrue(result);
        verify(inventoryLogDAO, times(1)).hasNextPage(1, 10);
    }
}