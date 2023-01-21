# Ted Search
- TED Search is a search engine for TED Talks.

The application has two components:
1. The main process - a spring boot "fat jar" application.
2. The cache layer - a Memcached server.

## Requirements
* Deploy an ec2 instance manually and run the files in the lab_structure directory in order to start the necessary containers (Jenkins and GitLab).

* Attach an IAM role with relevant permissions to the ec2 (for the terraform to work).

* Deploy an S3 bucket to store the state files of workspaces (see in the provider.tf and change accordingly).

* You'll have to configure Jenkins (plugins, credentials, MBP job etc.) and GitLab (open repository, ssh credentials, configure integrations etc.) and possibly more.

* I recommend to try setting everything up and handle any problems as they arise. (Obviously for future me)

## Structure
1. ##### lab_structure (directory):
    Contains the docker-compose file and Dockerfile to run the project. This project uses GitLab container as its git repo.

2. ##### terraform (directory):
    Contains all the tf files to deploy infrastructure and run the app on remote ec2, except for a few files that will be copied to the config dir during the pipeline.

3. ##### e2e.sh (file):
    Contains the end to end test to run against the deployed app, in the pipeline.

4. ##### Dockerfile (file):
    Containerizes the app.

5. ##### Jenkinsfile (file):
    The MBP Jenkins pipeline job.

6. ##### env_cron.jenkinsfile (file):
    The cron job to run every 15 minutes. Sends email on the running environments.
