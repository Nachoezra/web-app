pipeline {
    agent any
    tools {
        maven 'Maven 3.8.6'
    }
    stages {
        stage ('Cloning from Github'){
            steps {
                echo 'Cloning from Github'
                git 'https://github.com/Nachoezra/web-app.git'
                echo 'Cloning done'
            }
        }
        stage('Build with Maven'){
            steps{
                echo 'Building with Maven'
                sh 'mvn package'
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
        stage('Building Docker Image'){
            steps{
                script{
                   sh 'docker build -t nachoezra/my-app .' 
                }
            }
        }
        stage('Push Docker Image to Dockerhub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'Dockerhub_cred', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u nachoezra -p ${dockerhubpwd}'  
                    sh 'docker push nachoezra/'
                    }
                }
            }
        }
        stage('Deploy to Tomcat'){
            steps{
                echo 'Deploying to Tomcat'
                deploy adapters: [tomcat9(credentialsId: 'Tomcat_new', path: '', url: 'http://18.191.136.126:1005')], contextPath: null, onFailure: false, war: 'target/*war'
                echo 'Deployment successful'
                
            }
        }
    }
}
    /*
    stage('deploy'){
  sshagent(['tomcat']) {
  sh "scp -o StrictHostKeyChecking=no target/*war ec2-user@172.31.15.31:/opt/tomcat9/webapps/"
}
}
stage('email'){
emailext body: '''Build is over

Acada
437212483''', recipientProviders: [developers(), requestor()], subject: 'Build', to: 'tdapp@gmail.com'
}
    */
}
