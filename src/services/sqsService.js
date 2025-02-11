const AWS = require('aws-sdk');

const sqs = new AWS.SQS();

const QUEUE_URL = process.env.SQS_QUEUE_URL;

const sendMessage = async (nombre) => {
    const params = {
        MessageBody: JSON.stringify({ nombre }),
        QueueUrl: QUEUE_URL,
    };

    try {
        const result = await sqs.sendMessage(params).promise();
        return result.MessageId;
    } catch (error) {
        console.error('Error sending message to SQS:', error);
        throw new Error('Could not send message to SQS');
    }
};

module.exports = {
    sendMessage,
};