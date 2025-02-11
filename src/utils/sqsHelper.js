const AWS = require('aws-sdk');
const sqs = new AWS.SQS();

const sendMessageToQueue = async (queueUrl, messageBody) => {
    const params = {
        QueueUrl: queueUrl,
        MessageBody: JSON.stringify(messageBody),
    };

    try {
        const result = await sqs.sendMessage(params).promise();
        return result.MessageId;
    } catch (error) {
        console.error('Error sending message to SQS:', error);
        throw error;
    }
};

module.exports = {
    sendMessageToQueue,
};