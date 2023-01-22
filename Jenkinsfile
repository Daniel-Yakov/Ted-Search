def commit_msg
pipeline {
    options {
        timestamps()
        gitLabConnection('gitlab')
    }

    tools {
        maven 'Maven 3.6'
        jdk 'jdk-8'
    }

    agent any

    stages {
        stage('checkout'){
            steps {
                script {
                    // extract the commit message
                    commit_msg = sh(
                        script: "git log -1 --pretty=%B ${GIT_COMMIT}",
                        returnStdout: true
                    ).trim()
                }

                deleteDir()
                checkout scm
                sh "mvn clean"
            }
        }

        stage('build&unit_test'){
            steps {
                sh "mvn verify"
            }
        }

        stage('build_test_env'){
            when { anyOf { branch "main"; branch "stage"; expression { commit_msg.contains('#test') } } }

            steps {
                // prepare necessary files to config the ec2 to run ted search
                sh "docker save -o ./terraform/config/tedsearchimg.tar tedsearchimg"
                sh "mv ./src/main/resources/static ./terraform/config"
                
                // build the test env
                sh """
                    cd terraform 
                    terraform init

                    workspace_env=${GIT_BRANCH}

                    if [ "\$workspace_env" = "main" ]; then
                        workspace_env=prod
                    fi

                    terraform workspace new \${workspace_env}-test || terraform workspace select \${workspace_env}-test
                    terraform apply -auto-approve   
                """ 
            } 
        }

        stage('e2e'){
            when { anyOf { branch "main"; branch "stage"; expression { commit_msg.contains('#test') } } }

            steps {
                // Run the e2e test
                sh """ 
                    cd terraform
                    public_ip=\$(terraform output public_ip | tr -d '"')
                    bash ../e2e.sh \${public_ip}
                """
            }
            post {
                always {
                    // Destroy test env
                    sh "cd terraform && terraform destroy -auto-approve"
                }
            } 
        }

        stage('deploy'){
            when { anyOf { branch "main"; branch "stage" } }

            steps {
                // Deploy the stage/prod env
                sh """ 
                    cd terraform 
                    terraform init

                    workspace_env=${GIT_BRANCH}

                    if [ "\$workspace_env" = "main" ]; then
                        workspace_env=prod
                    fi

                    terraform workspace new \$workspace_env || terraform workspace select \$workspace_env
                    terraform apply -auto-approve -replace="module.ec2.aws_instance.app"   
                """
            }  
        }


    }

    post {
        success{
            updateGitlabCommitStatus name: 'YEA!!! Succuss', state: 'success'
        }
        failure {
            updateGitlabCommitStatus name: 'Failed', state: 'failed'
        }
    }
}