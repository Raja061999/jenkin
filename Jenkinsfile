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

    }
}