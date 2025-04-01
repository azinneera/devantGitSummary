import ballerina/email;
import ballerina/log;
import ballerinax/github;

email:SmtpClient email = check new (host = smtpHost, username = smtpUsername, password = smtpPassword);

public function main() returns error? {
    do {
        github:Collaborator[] githubCollaborator = check githubClient->/repos/[orgname]/[reponame]/collaborators.get();
        foreach github:Collaborator collaborator in githubCollaborator {
            log:printInfo("id:" + collaborator.id.toString());

        }
        github:Issue[] githubIssue = check githubClient->/repos/[orgname]/[reponame]/issues.get();
        string issueCount = "Total issue count: " + githubIssue.length().toString();
        log:printInfo("Issue count:" + issueCount);
        check email->sendMessage({to: "asmaj@wso2.com", subject: "Github summary", body: "Issue count: " + issueCount});

    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
