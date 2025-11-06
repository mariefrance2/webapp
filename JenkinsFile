pipeline {
    agent any

    environment {
        SLACK_CHANNEL = '#notifications-jenkins'
        SLACK_CREDENTIAL_ID = 'slack-token'
        GITHUB_BRANCH = 'dev'
        IMAGE_NAME = 'webapp_portfolio'
    }

    triggers {
        githubPush() // 🔔 Déclenche à chaque commit sur la branche liée
    }

    stages {

        stage('Clone') {
            when {
                branch 'dev'
            }
            steps {
                slackSend(channel: "${SLACK_CHANNEL}", message: "🚀 Pipeline déclenché sur la branche *${env.BRANCH_NAME}* (Clone en cours...)")
                git branch: "${GITHUB_BRANCH}", url: 'https://github.com/mariefrance2/webapp.git'
                echo '✅ Code cloné avec succès !'
            }
        }

        stage('Build') {
            steps {
                slackSend(channel: "${SLACK_CHANNEL}", message: "⚙️ Build de l’image Docker en cours...")
                script {
                    sh 'docker build -t ${IMAGE_NAME}:latest .'
                }
                echo '✅ Build terminé !'
            }
        }

        stage('Deploy') {
            steps {
                slackSend(channel: "${SLACK_CHANNEL}", message: "🚢 Déploiement du conteneur en cours...")
                script {
                    sh '''
                    docker stop ${IMAGE_NAME} || true
                    docker rm ${IMAGE_NAME} || true
                    docker run -d --name ${IMAGE_NAME} -p 8080:80 ${IMAGE_NAME}:latest
                    '''
                }
                echo '✅ Application déployée sur le port 8080 !'
                slackSend(channel: "${SLACK_CHANNEL}", message: "✅ Déploiement réussi sur le port 8080 🎉")
            }
        }
    }

    post {
        failure {
            slackSend(channel: "${SLACK_CHANNEL}", message: "❌ Pipeline échoué à l’étape : ${env.STAGE_NAME}")
        }
        success {
            slackSend(channel: "${SLACK_CHANNEL}", message: "🎯 Pipeline terminé avec succès !")
        }
    }
}
