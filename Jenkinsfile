pipeline {
    agent any
    environment {
        AWS_INSTANCE = "ubuntu@ec2-43-205-43-217.ap-south-1.compute.amazonaws.com"
        SSH_KEY = "/var/lib/jenkins/.ssh/trial1.pem"
        IMAGE_NAME = "aws-jenkin-container:1.0"
        DOCKER_REPO = "sraja06/aws-jenkin-container:1.0"
    }
    stages {
        stage("Checkout") {
            steps {
                checkout scm
            }
        }


        stage("Install Dependencies") {
            steps {
                sh 'npm install'
            }
        }

        stage("Build Docker Image") {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage("Push Docker Image") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    sh '''
                    docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD
                    docker tag $IMAGE_NAME $DOCKER_REPO
                    docker push $DOCKER_REPO
                    docker logout
                    '''
                }
            }
        }

        stage("Deploy on AWS EC2") {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no -i $SSH_KEY $AWS_INSTANCE <<EOF
                sudo apt update
                sudo apt install -y docker.io
                sudo systemctl start docker
                sudo systemctl enable docker

                sudo docker pull $DOCKER_REPO
                sudo docker stop my-app || true
                sudo docker rm my-app || true
                sudo docker run -d --restart always -p 3003:3003 --name my-app $DOCKER_REPO
                '''
            }
        }
    }
}



// pipeline{
//     agent any
//     stages{
//         stage("check-out"){
//             steps{
//                 checkout scm
//             }
//         }

//         stage("test"){
//             steps{
//                 sh 'npm install'
//             }
//         }
//        stage("docker image") {
//     steps {
//         sh 'sudo docker build -t aws-jenkin-container:1.0 .'
//     }
// }
//     stage("Docker Push") {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
//                     sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
//                     sh 'docker tag jenkin-container:1.0 sraja06/aws-jenkin-container:1.0'
//                     sh 'docker push sraja06/aws-jenkin-container:1.0'
//                     sh 'docker logout'
//                 }
//             }
//         }

// stage("Deploy on Server") {
//     steps {
//         sh '''
//         ssh -i ~/.ssh/id_rsa rajas@localhost <<EOF
//         docker pull sraja06/jenkin-container:1.0
//         docker stop my-app || true
//         docker rm my-app || true
//         docker run -d -p 3003:3003 --name my-app sraja06/aws-jenkin-container:1.0
//         EOF
//         '''
//     }
// }

//     }
// }
