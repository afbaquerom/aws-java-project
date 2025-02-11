const request = require('supertest');
const app = require('../../src/index'); // Assuming index.js exports an Express app

describe('API Gateway', () => {
    it('should respond with 200 for valid requests', async () => {
        const response = await request(app)
            .post('/your-endpoint') // Replace with your actual endpoint
            .send({ nombre: 'TestName' });

        expect(response.status).toBe(200);
        // Add more assertions based on your response structure
    });

    it('should return 400 for missing nombre parameter', async () => {
        const response = await request(app)
            .post('/your-endpoint') // Replace with your actual endpoint
            .send({}); // No nombre parameter

        expect(response.status).toBe(400);
        // Add more assertions based on your response structure
    });
});