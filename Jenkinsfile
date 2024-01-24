pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "docker-djngo:v${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'bbc69362-59e8-44be-95c6-39f5109027cf',
                url: 'https://github.com/livevil8/cicd-end-to-end',
                branch: 'main'
            }
        }
        stage('Debug') {
            steps {
                script {
                    echo "Jenkins Home: ${env.JENKINS_HOME}"
                    echo "Jenkins User: ${env.USER}"
                    echo "Groups: ${sh(script: 'groups', returnStdout: true).trim()}"
                    sh 'docker --version'
                    sh 'docker info'
                    sh 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock hello-world'
                }
            }
        }
    }
        stage('Build Docker') {
            steps {
                script {
                    sh '''
                    echo 'Building Docker Image'
                    docker build -t livevil8/${DOCKER_IMAGE} .
                    '''
                }
            }
        }
        stage ('Deploy Locally') {
            steps {
                script {
                    sh "docker compose up -d"
                }
            }
        }
        stage ('Cleanup Locally') {
            steps {
                script {
                    sh "docker compose down"
                }
            }
        }
    }
    post {
        success {
            script {
                echo "Build succeeded! Build ID: ${BUILD_ID}"
            }
        }
        failure {
            script {
                echo "Failed Pipeline: ${currentBuild.fullDisplayName}"
            }
        }
    }
}
