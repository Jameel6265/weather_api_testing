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

        stage('Linting') {
            steps {
                sh '''
                python3 -m venv venv
                . venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                flake8 .
                '''
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
                    compliant-api-tests pytest -v
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
