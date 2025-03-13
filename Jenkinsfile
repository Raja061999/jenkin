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
        stage("build"){
            steps{
                sh 'npm run build'
            }
        }
    }
}