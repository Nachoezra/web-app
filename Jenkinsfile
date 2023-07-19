pipeline {
    agent any
    tools {
        maven 'Maven 3.8.6'
    }
    stages {
        
        stage('Build with Maven'){
            steps{
                echo 'Building with Maven'
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'Github', url: 'https://github.com/Nachoezra/web-app.git']])
                sh 'mvn clean package'
                echo 'Building done'
            }
        }
        stage('Test with Sonarqube'){
            steps{
                echo 'Testing with Sonarqube'
                sh 'mvn sonar:sonar'
                echo 'Testing done'
            }
        }
        stage('Upload to Nexus'){
            steps{
                echo 'Uploading to Nexus'
                sh 'mvn deploy'
                echo 'Uploading done'
            }
        }
        stage('Build Docker Image'){
            steps{
                echo 'Building Docker Image'
                sh 'docker rm -f $(docker ps -aq)'
                sh 'docker rmi -f $(docker images -aq)' 
                sh 'docker build -t nachoezra/my-web-app:latest .'
                echo 'Docker Image built'
            }
        }
        stage('Push Docker Image to Dockerhub'){
            steps{
                withCredentials([string(credentialsId: 'nachoezra', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u nachoezra -p ${dockerhubpwd}'  
                    sh 'docker push nachoezra/my-web-app:latest'
                }
            }
        }
        stage('Deploy to Tomcat'){
            steps{
                echo 'Running a Tomcat Container off my-web-app base image'
                sh 'docker run --name my-app -d -p 1000:8080 nachoezra/my-web-app:latest'
                echo 'Deployment done'
            }
        }
    }

    /*
        stage('deploy'){
            sshagent(['tomcat']) {
                sh "scp -o StrictHostKeyChecking=no target/*war ec2-user@172.31.15.31:/opt/tomcat9/webapps/"
            }
        }
       
    */

}
