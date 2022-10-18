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
                    sh 'docker build -t abhishekf5/cicd-e2e:v2 .'
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    sh '''
                    echo 'Push to Repo'
                     sh 'docker push abhishekf5/cicd-e2e:v2'
                    '''
                }
            }
        }
        
        stage('Checkout K8S manifest SCM'){
            when {
                branch 'main'
            }
            steps {
                git credentialsId: '', 
                url: 'https://github.com/shobhans/argocd_app_k8s_manifests.git',
                branch: 'main'
            }
        }
        
        stage('Staging Deploy - Update K8S manifest & push to Repo'){
            when {
                branch 'main'
            }
            steps {
                milestone(1)
                script{
                    withCredentials([usernamePassword(credentialsId: '', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        cd staging
                        cat deployment.yaml
                        sed -i "s/${APP_NAME}.*/${APP_NAME}:${BUILD_NUMBER}/g" deployment.yaml
                        cat deployment.yaml
                        git config --global user.name "shobhan"
                        git config --global user.email "post.shobhan@gmail.com"
                        git add deployment.yaml
                        git commit -m 'Updated the Staging App deployment | Jenkins Pipeline'
                        git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/argocd_app_k8s_manifests.git HEAD:main
                        '''                        
                    }
                }
            }
        }
    }
}
