const express = require('express');
const bodyParser = require('body-parser');
const sqsService = require('./services/sqsService');
const logger = require('./utils/logger');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());

app.post('/nombre', async (req, res) => {
    const { nombre } = req.body;

    if (!nombre) {
        return res.status(400).json({ error: 'El parámetro "nombre" es requerido.' });
    }

    try {
        await sqsService.sendMessage(nombre);
        res.status(200).json({ message: 'Mensaje enviado a la cola SQS.' });
    } catch (error) {
        logger.error('Error al enviar mensaje a SQS:', error);
        res.status(500).json({ error: 'Error interno del servidor.' });
    }
});

app.listen(PORT, () => {
    logger.info(`Servidor escuchando en el puerto ${PORT}`);
});