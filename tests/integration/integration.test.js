const request = require('supertest');
const app = require('../../src/index'); // Assuming index.js exports an Express app
const AWS = require('aws-sdk');
const sqs = new AWS.SQS();

jest.mock('aws-sdk', () => {
    const mockSendMessage = jest.fn().mockReturnValue({
        promise: jest.fn().mockResolvedValue({})
    });

    return {
        SQS: jest.fn(() => ({
            sendMessage: mockSendMessage
        }))
    };
});

describe('Integration Tests', () => {
    it('should send a message to SQS and trigger Lambda', async () => {
        const nombre = 'TestName';

        const response = await request(app)
            .post('/api/nombre') // Adjust the endpoint as per your API Gateway setup
            .send({ nombre });

        expect(response.status).toBe(200);
        expect(response.body.message).toBe('Message sent to SQS');

        // Verify that the SQS sendMessage was called with the correct parameters
        expect(sqs().sendMessage).toHaveBeenCalledWith(expect.objectContaining({
            MessageBody: JSON.stringify({ nombre }),
            QueueUrl: expect.any(String) // Replace with your actual Queue URL if needed
        }));
    });
});