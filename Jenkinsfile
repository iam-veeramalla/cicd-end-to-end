node() {


    currentBuild.result = "SUCCESS"

    try {
      

       stage('Checkout'){

            git branch: 'main', url: 'https://github.com/iam-veeramalla/cicd-end-to-end'
       }


       stage('Build Docker'){

            echo 'Buid Docker Image'
            sh 'docker build -t abhishekf5/cicd-e2e:v2 .'
       }

       stage('Deploy'){

         echo 'Push to Repo'
         sh 'docker push abhishekf5/cicd-e2e:v2'
       }
        
       stage('Update Manifests'){
         
          echo 'Update the Kubernetes Manifest Versions'
          sh 'sh "ls -ltr"'
          sh 'sh "cd \$(basename deploy)"'
          sh 'cat deploy.yaml | yq '.spec.containers[0].image = "abhishekf5/todo-app:v2"''
          sh 'git add . && git commit -m "update tag" && git push'
       }

       stage('Notification'){

         /*
           mail body: 'project build successful',
                     from: 'xxxx@yyyyy.com',
                     replyTo: 'xxxx@yyyy.com',
                     subject: 'project build successful',
                     to: 'yyyyy@yyyy.com'
         */
       }



    }
    catch (err) {

        currentBuild.result = "FAILURE"
        /*
            mail body: "project build error is here: ${env.BUILD_URL}" ,
            from: 'xxxx@yyyy.com',
            replyTo: 'yyyy@yyyy.com',
            subject: 'project build failed',
            to: 'zzzz@yyyyy.com'
        */

        throw err
    }

}
