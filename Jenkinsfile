pipeline {
    agent any

    environment {
        OPENWEATHER_API_KEY = credentials('OPENWEATHER_API_KEY')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t compliant-api-tests .'
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                docker run --rm \
                    -e OPENWEATHER_API_KEY=$OPENWEATHER_API_KEY \
                    compliant-api-tests
                '''
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            sh 'docker rmi compliant-api-tests || true'
        }
    }
}
