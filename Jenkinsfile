pipeline{
    agent any
    stages{
        stage("check-out"){
            steps{
                checkout scm
            }
        }

        stage("test"){
            steps{
                sh 'npm install'
            }
        }
       stage("docker image") {
    steps {
        sh 'sudo docker build -t jenkin-container:1.0 .'
    }
}
    stage("Docker Push") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                    sh 'docker tag jenkin-container:1.0 sraja06/jenkin-container:1.0'
                    sh 'docker push sraja06/jenkin-container:1.0'
                    sh 'docker logout'
                }
            }
        }
    }
}