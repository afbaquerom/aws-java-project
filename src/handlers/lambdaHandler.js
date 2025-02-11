const AWS = require('aws-sdk');
const s3 = new AWS.S3();
const cloudwatch = new AWS.CloudWatchLogs();
const logGroupName = 'your-log-group-name'; // Replace with your log group name
const logStreamName = 'your-log-stream-name'; // Replace with your log stream name

exports.lambdaHandler = async (event) => {
    for (const record of event.Records) {
        const { nombre } = JSON.parse(record.body);
        const fileName = `${nombre}.txt`;
        const fileContent = `This file was created for ${nombre}`;

        const params = {
            Bucket: 'my-unique-s3-bucket-name', // Replace with your S3 bucket name
            Key: fileName,
            Body: fileContent,
        };

        try {
            await s3.putObject(params).promise();
            await logToCloudWatch(`File ${fileName} created successfully.`);
        } catch (error) {
            await logToCloudWatch(`Error creating file ${fileName}: ${error.message}`);
            throw error;
        }
    }
};

const logToCloudWatch = async (message) => {
    const params = {
        logGroupName,
        logStreamName,
        logEvents: [
            {
                message,
                timestamp: Date.now(),
            },
        ],
    };

    await cloudwatch.putLogEvents(params).promise();
};