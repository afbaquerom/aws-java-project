import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class AppTest {

    @Test
    public void testHandleRequest() {
        // Arrange
        App app = new App();
        String testName = "TestName";
        String expectedResponse = "Hello, TestName";

        // Act
        String actualResponse = app.handleRequest(testName);

        // Assert
        assertEquals(expectedResponse, actualResponse);
    }

    @Test
    public void testSendMessageToSQS() {
        // Arrange
        App app = new App();
        String testName = "TestName";
        // Mock SQS client
        SQSClient mockSQSClient = mock(SQSClient.class);
        app.setSQSClient(mockSQSClient);

        // Act
        app.sendMessageToSQS(testName);

        // Assert
        verify(mockSQSClient).sendMessage(any(SendMessageRequest.class));
    }

    @Test
    public void testTriggerLambdaFunction() {
        // Arrange
        App app = new App();
        String testName = "TestName";
        // Mock Lambda client
        LambdaClient mockLambdaClient = mock(LambdaClient.class);
        app.setLambdaClient(mockLambdaClient);

        // Act
        app.triggerLambdaFunction(testName);

        // Assert
        verify(mockLambdaClient).invoke(any(InvokeRequest.class));
    }
}