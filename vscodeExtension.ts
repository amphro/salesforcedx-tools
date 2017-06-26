'use strict';
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';

const child_process = require('child_process');

// TODO Add valudation and more detailed messages
function push() {
    vscode.window.showInformationMessage('Pusing...');
    child_process.exec('sfdx force:source:push', {
        cwd: vscode.workspace.rootPath
    }, (err, stdout, stderr) => {
        vscode.window.showInformationMessage('Push finished!');
    });
}

// this method is called when your extension is activated
// this extension is activated when vscode launches by changing "activationEvents": ["*"]
export function activate(context: vscode.ExtensionContext) {

    // Use the console to output diagnostic information (console.log) and errors (console.error)
    // This line of code will only be executed once when your extension is activated
    console.log('Congratulations, your extension "sfdx-push-source" is now active!');

    vscode.workspace.onDidSaveTextDocument(() => {
        push();
    });

}