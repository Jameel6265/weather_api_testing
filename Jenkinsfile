// Jenkinsfile

pipeline {
    agent any

    environment {
        // Define the name of the Jenkins credential we will create
        OPENWEATHER_API_KEY = credentials('openweathermap-api-key')
    }

    stages {
        stage('Linting') {
            steps {
                echo 'Running code quality checks...'
                // Run the linter. If this fails, the build stops.
                sh 'pip install -r requirements.txt'
                sh 'flake8 src/'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building the Docker image...'
                // Build the image using our multi-stage Dockerfile
                sh 'docker build -t compliant-api-tests .'
            }
        }
        
        stage('Run Tests') {
            steps {
                echo 'Running tests inside the Docker container...'
                // Run the container, securely injecting the API key as an environment variable.
                // The Python code reads this variable via os.getenv("API_KEY").
                sh '''
                    docker run --rm \
                        -e API_KEY=${OPENWEATHER_API_KEY} \
                        compliant-api-tests
                '''
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Clean up the Docker image to save space
            sh 'docker rmi compliant-api-tests || true'
        }
    }
}