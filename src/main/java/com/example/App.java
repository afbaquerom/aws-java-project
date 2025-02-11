package com.example;

import com.amazonaws.services.lambda.AWSLambda;
import com.amazonaws.services.lambda.AWSLambdaClientBuilder;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.SendMessageRequest;
import com.amazonaws.services.sqs.model.SendMessageResult;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.lambda.model.InvokeRequest;
import com.amazonaws.services.lambda.model.InvokeResult;
import com.amazonaws.services.lambda.AWSLambdaAsync;
import com.amazonaws.services.lambda.AWSLambdaAsyncClientBuilder;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

public class App {
    private static final String SQS_QUEUE_URL = "your-sqs-queue-url";
    private static final String LAMBDA_FUNCTION_NAME = "your-lambda-function-name";
    private static final String S3_BUCKET_NAME = "your-s3-bucket-name";

    public static void main(String[] args) {
        String nombre = args.length > 0 ? args[0] : "defaultName";

        // Send message to SQS
        sendMessageToSQS(nombre);

        // Trigger Lambda function
        triggerLambda(nombre);
    }

    private static void sendMessageToSQS(String nombre) {
        AmazonSQS sqs = AmazonSQSClientBuilder.defaultClient();
        SendMessageRequest sendMsgRequest = new SendMessageRequest()
                .withQueueUrl(SQS_QUEUE_URL)
                .withMessageBody(nombre);
        SendMessageResult sendMessageResult = sqs.sendMessage(sendMsgRequest);
        System.out.println("Message sent to SQS: " + sendMessageResult.getMessageId());
    }

    private static void triggerLambda(String nombre) {
        AWSLambda lambda = AWSLambdaClientBuilder.defaultClient();
        InvokeRequest invokeRequest = new InvokeRequest()
                .withFunctionName(LAMBDA_FUNCTION_NAME)
                .withPayload("{\"nombre\": \"" + nombre + "\"}");
        InvokeResult invokeResult = lambda.invoke(invokeRequest);
        System.out.println("Lambda invoked: " + invokeResult.getStatusCode());
    }
}