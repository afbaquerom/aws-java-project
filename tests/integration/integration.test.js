const request = require('supertest');
const app = require('../../src/index'); // Assuming index.js exports an Express app
const AWS = require('aws-sdk');

jest.mock('aws-sdk');

describe('Integration Tests', () => {
    let sqsSendMessageMock;

    beforeAll(() => {
        sqsSendMessageMock = jest.fn().mockReturnValue({
            promise: jest.fn().mockResolvedValue({})
        });
        AWS.SQS.prototype.sendMessage = sqsSendMessageMock;
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    test('should send a message to SQS when a request is made', async () => {
        const nombre = 'testFile';
        const response = await request(app)
            .post('/your-api-endpoint') // Replace with your actual endpoint
            .send({ nombre });

        expect(response.status).toBe(200);
        expect(sqsSendMessageMock).toHaveBeenCalledWith(expect.objectContaining({
            MessageBody: JSON.stringify({ nombre }),
            QueueUrl: expect.any(String) // Replace with your actual queue URL if needed
        }));
    });

    // Additional integration tests can be added here
});