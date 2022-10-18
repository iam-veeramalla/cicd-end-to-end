pipeline {
    
    agent any 
    
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        
        stage('Checkout'){
           steps {
                script {
                    sh '''
                    git branch: 'main', url: 'https://github.com/iam-veeramalla/cicd-end-to-end'
                    '''
                }
            }
        }

        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Buid Docker Image'
                    sh 'docker build -t abhishekf5/cicd-e2e:${BUILD_NUMBER} .'
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    sh '''
                    echo 'Push to Repo'
                     sh 'docker push abhishekf5/cicd-e2e:${BUILD_NUMBER}'
                    '''
                }
            }
        }
        
        stage('Checkout K8S manifest SCM'){
            when {
                branch 'main'
            }
            steps {
                git credentialsId: 'f87a34a8-0e09-45e7-b9cf-6dc68feac670', 
                url: 'https://github.com/iam-veeramalla/cicd-demo-manifests-repo.git',
                branch: 'main'
            }
        }
        
        stage('Update K8S manifest & push to Repo'){
            when {
                branch 'main'
            }
            steps {
                script{
                    withCredentials([usernamePassword(credentialsId: 'f87a34a8-0e09-45e7-b9cf-6dc68feac670', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        cat deployment.yaml
                        sed -i "s/v1/${BUILD_NUMBER}/g" deployment.yaml
                        cat deployment.yaml
                        git add deployment.yaml
                        git commit -m 'Updated the Staging App deployment | Jenkins Pipeline'
                        git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/cicd-demo-manifests-repo.git HEAD:main
                        '''                        
                    }
                }
            }
        }
    }
}
