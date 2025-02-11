const AWS = require('aws-sdk');
const sqsHelper = require('./utils/sqsHelper');

const apiGateway = async (event) => {
    const { nombre } = event.queryStringParameters;

    if (!nombre) {
        return {
            statusCode: 400,
            body: JSON.stringify({ message: 'El parámetro "nombre" es requerido.' }),
        };
    }

    try {
        await sqsHelper.sendMessage(nombre);
        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'Petición recibida y procesada.' }),
        };
    } catch (error) {
        console.error('Error al enviar mensaje a SQS:', error);
        return {
            statusCode: 500,
            body: JSON.stringify({ message: 'Error interno del servidor.' }),
        };
    }
};

exports.handler = apiGateway;