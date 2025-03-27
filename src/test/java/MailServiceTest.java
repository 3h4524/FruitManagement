import jakarta.mail.Transport;
import jakarta.mail.MessagingException;
import model.OrderDetail;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import service.MailService;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class MailServiceTest {

    private static final String TEST_EMAIL = "test@example.com";
    private static final String TEST_OTP = "123456";
    private static final String ORDER_ID = "ORD123";
    private static final String CUSTOMER_NAME = "John Doe";
    private static final BigDecimal TOTAL_AMOUNT = BigDecimal.valueOf(100000);

    @BeforeEach
    void setUp() {
        // Mock static methods
        try (MockedStatic<Transport> transportMock = Mockito.mockStatic(Transport.class)) {
            transportMock.when(() -> Transport.send(any())).then(invocation -> null);
        }
    }

    @Test
    void testSendOTP_Success() {
        boolean result = MailService.sendOTP(TEST_EMAIL, TEST_OTP);
        assertTrue(result, "OTP email should be sent successfully");
    }

    @Test
    void testSendOTP_Failure() {
        try (MockedStatic<Transport> transportMock = Mockito.mockStatic(Transport.class)) {
            transportMock.when(() -> Transport.send(any())).thenThrow(new MessagingException("SMTP error"));
            boolean result = MailService.sendOTP(TEST_EMAIL, TEST_OTP);
            assertFalse(result, "OTP email should fail to send");
        }
    }

    @Test
    void testSendOrderConfirmation_Success() {
        List<OrderDetail> orderDetails = Collections.emptyList(); // No items in order
        boolean result = MailService.sendOrderConfirmation(TEST_EMAIL, ORDER_ID, CUSTOMER_NAME, orderDetails, TOTAL_AMOUNT);
        assertTrue(result, "Order confirmation email should be sent successfully");
    }

    @Test
    void testSendOrderConfirmation_Failure() {
        try (MockedStatic<Transport> transportMock = Mockito.mockStatic(Transport.class)) {
            transportMock.when(() -> Transport.send(any())).thenThrow(new MessagingException("SMTP error"));
            List<OrderDetail> orderDetails = Collections.emptyList();
            boolean result = MailService.sendOrderConfirmation(TEST_EMAIL, ORDER_ID, CUSTOMER_NAME, orderDetails, TOTAL_AMOUNT);
            assertFalse(result, "Order confirmation email should fail to send");
        }
    }
}
