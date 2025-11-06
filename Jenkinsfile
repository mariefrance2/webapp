pipeline {
    agent any

    stages {

        stage('Clone') {
           
            steps {
                slackSend(channel: "${SLACK_CHANNEL}", message: "🚀 Pipeline déclenché sur la branche dev (Clone en cours...)")
                git branch: "${GITHUB_BRANCH}", url: 'https://github.com/mariefrance2/webapp.git'
                echo '✅ Code cloné avec succès !'
            }
        }

        stage('Build') {
            steps {
                slackSend(channel: "${SLACK_CHANNEL}", message: "⚙️ Build de l’image Docker en cours...")
                script {
                    bat "docker build -t ${IMAGE_NAME}:latest ."
                }
                echo '✅ Build terminé !'
            }
        }

        stage('Deploy') {
            steps {
                slackSend(channel: "${SLACK_CHANNEL}", message: "🚢 Déploiement du conteneur en cours...")
                script {
                    
                    bat "docker run -d --name ${IMAGE_NAME} -p 9080:80 ${IMAGE_NAME}:latest"
                    
                }
                echo '✅ Application déployée sur le port 8080 !'
                slackSend(channel: "${SLACK_CHANNEL}", message: "✅ Déploiement réussi sur le port 9080 🎉")
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
            slackSend(channel: "${SLACK_CHANNEL}", message: "❌ Pipeline échoué à l’étape : ")
        }
        success {
            slackSend(channel: "${SLACK_CHANNEL}", message: "🎯 Pipeline terminé avec succès !")
        }
    }
}
