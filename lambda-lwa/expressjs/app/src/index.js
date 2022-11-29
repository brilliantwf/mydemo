const express = require('express')
const app = express()
const port = process.env['PORT'] || 8080
const aws = require('aws-sdk');
const queueUrl = "https://sqs.us-east-1.amazonaws.com/544592066775/MyTestSQS";
const receipt = "";
aws.config.loadFromPath(__dirname + '/config.json');
var sqs = new aws.SQS({ apiVersion: '2012-11-05' });
var ddb = new aws.DynamoDB({ apiVersion: '2012-08-10' });
// SIGTERM Handler
process.on('SIGTERM', async () => {
    console.info('[express] SIGTERM received');
    console.info('[express] cleaning up');
    // perform actual clean up work here.
    await new Promise(resolve => setTimeout(resolve, 1000));

    console.info('[express] exiting');
    process.exit(0)
});

app.get('/', (req, res) => {
    res.send('Website is ready!')
});

// Creating a queue.
app.get('/create', function (req, res) {
    var params = {
        QueueName: "MyFirstQueue"
    };

    sqs.createQueue(params, function (err, data) {
        if (err) {
            res.send(err);
        }
        else {
            res.send(data);
        }
    });
});

app.get('/send', function (req, res) {
    var userid = Math.random().toString(36).substring(2)
    console.log(userid)
    var message = "Now time is " + Date.now()
    var params = {
        // Remove DelaySeconds parameter and value for FIFO queues
        DelaySeconds: 1,
        MessageAttributes: {
            "Userid": {
                DataType: "String",
                StringValue: userid
            },
        },
        MessageBody: message,
        QueueUrl: queueUrl
    };
    var ddbparams = {
        TableName: 'User_Table1',
        Item: {
            'userid': { S: userid },
            'Messagebody': { S: message }
        }
    };

    sqs.sendMessage(params, function (err, data) {
        if (err) {
            res.send(err);
        }
        else {
            res.send(data);
        }
    }
    );
    ddb.putItem(ddbparams, function (err, data) {
        if (err) {
            console.log("Error", err);
        } else {
            console.log("Success", data);
        }
    });
});

app.get('/receive', function (req, res) {
    var params = {
        QueueUrl: queueUrl,
        VisibilityTimeout: 600 // 10 min wait time for anyone else to process.
    };

    sqs.receiveMessage(params, function (err, data) {
        if (err) {
            res.send(err);
        }
        else {
            res.send(data.Messages);
        }
    });
});

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})