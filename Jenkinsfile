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
       /* stage('Test with Sonarqube'){
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
        } */
        stage('Build Docker Image'){
            steps{
                echo 'Building Docker Image'
                sh 'docker rm -f my-app'
                sh 'docker rmi -f nachoezra/my-web-app:latest' 
                sh 'docker build -t nachoezra/my-web-app:latest .'
                echo 'Docker Image built'
            }
        }
        stage('Push Docker Image to Dockerhub'){
            steps{
                withCredentials([string(credentialsId: 'nachoezra', variable: 'Dockerhubpwd')]) {
                    sh 'docker login -u nachoezra -p ${Dockerhubpwd}'  
                    sh 'docker push nachoezra/my-web-app:latest'
                }
            }
        }
        stage('Deploy to Kubernetes'){
            steps{
                echo 'deploying to Kubernetes'
                sh 'kubectl apply -f deployment'
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
