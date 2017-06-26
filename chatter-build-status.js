const jsforce = require('jsforce');
const child_process = require('child_process');

const buildNumber = process.argv[2];
const buildStatus = process.argv[3];

child_process.exec('sfdx force:org:display --json -u hub', (err, stdout, stderr) => {
    const { accessToken, instanceUrl } = JSON.parse(stdout).result;

    var jsforce = require('jsforce');
    var conn = new jsforce.Connection({
        instanceUrl,
        accessToken
    });

    conn.chatter.resource('/feed-elements').create({
        body: {
            messageSegments: [{
            type: 'Text',
            text: `The build ${buildNumber} has ${buildStatus}`
            }]
        },
        feedElementType : 'FeedItem',
        subjectId: 'me'
    }, function(err, result) {
        if (err) { return console.error(err); }
        console.log("Id: " + result.id);
        console.log("URL: " + result.url);
        console.log("Body: " + result.body.messageSegments[0].text);
        console.log("Comments URL: " + result.capabilities.comments.page.currentPageUrl);
    });
});