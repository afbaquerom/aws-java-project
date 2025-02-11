const AWS = require('aws-sdk');
const s3 = new AWS.S3();
const logger = require('../utils/logger');

exports.lambdaHandler = async (event) => {
    try {
        const records = event.Records;
        for (const record of records) {
            const messageBody = JSON.parse(record.body);
            const nombre = messageBody.nombre;

            const params = {
                Bucket: process.env.BUCKET_NAME,
                Key: `${nombre}.txt`,
                Body: `Hello, ${nombre}!`
            };

            await s3.putObject(params).promise();
            logger.info(`File created for ${nombre}`);
        }
    } catch (error) {
        logger.error('Error processing SQS message:', error);
        throw new Error('Error processing SQS message');
    }
};