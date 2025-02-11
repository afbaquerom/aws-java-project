const request = require('supertest');
const app = require('../../src/index'); // Assuming index.js exports an Express app

describe('API Gateway', () => {
    it('should send a message to SQS when a request is made', async () => {
        const response = await request(app)
            .post('/your-endpoint') // Replace with your actual endpoint
            .send({ nombre: 'testName' });

        expect(response.status).toBe(200);
        expect(response.body).toEqual({ message: 'Message sent to SQS' });
    });

    it('should return 400 if nombre is not provided', async () => {
        const response = await request(app)
            .post('/your-endpoint') // Replace with your actual endpoint
            .send({});

        expect(response.status).toBe(400);
        expect(response.body).toEqual({ error: 'nombre is required' });
    });
});