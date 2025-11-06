pipeline {
    agent any

    stages {

        stage('Clone') {
           
            steps {
                slackSend(channel: "${SLACK_CHANNEL}", message: "Pipeline triggered on the dev branch (Cloning in progress...)")
                git branch: "${GITHUB_BRANCH}", url: 'https://github.com/mariefrance2/webapp.git'
                echo 'Code successfully cloned!'
            }
        }

        stage('Build') {
            steps {
                slackSend(channel: "${SLACK_CHANNEL}", message: "Docker image build in progress...")
                script {
                    bat "docker build -t ${IMAGE_NAME}:latest ."
                }
                echo 'Build completed!'
            }
        }

        stage('Deploy') {
            steps {
                slackSend(channel: "${SLACK_CHANNEL}", message: "Container deployment in progress...")
                script {
                    
                    bat "docker run -d --name ${IMAGE_NAME} -p 8090:80 ${IMAGE_NAME}:latest"
                    
                }
                echo ' Application deployed on port 8090!'
                slackSend(channel: "${SLACK_CHANNEL}", message: "Deployment on port 9080")
            }
        }
    }

    post {
        always {
            script {
                bat "docker stop ${IMAGE_NAME} || true"
                bat "docker rm ${IMAGE_NAME} || true"
            }
        }
        failure {
            slackSend(channel: "${SLACK_CHANNEL}", message: "Pipeline failed at stage: ")
        }
        success {
            slackSend(channel: "${SLACK_CHANNEL}", message: "Pipeline completed successfully!")
        }
    }
}
