pipeline {

    agent any

    environment {
        registry = "aksacrtcspoc.azurecr.io"
    }

    stages {

        stage ('checkout') {

            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/acr']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/mandlakeerthi/project1.git']]])
            }
        }

        stage ('"Code Analysis"') {

            steps {
                sh '''mvn sonar:sonar \\
                -Dsonar.projectKey=Keerthi \\
                -Dsonar.host.url=http://104.41.136.29:9000 \\
                -Dsonar.login=d7d17ca3cdd88cca1d5e70789158405dc900d324'''
            }
        }

        stage ('Build') {

            steps {

                sh 'mvn clean package'
                
            }
        }

        stage ('Store Artifacts-Nexus') {

            steps {
                sh '''cp webapp/target/webapp.war webapp/target/webapp_$BUILD_ID.war
                curl -uadmin:Pappaya@2025 --upload-file webapp/target/webapp_$BUILD_ID.war "http://104.41.136.29:8081/repository/maven/"'''
                
            }
        }
        
        stage('Acr-Build & Push image'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'acr_cred', passwordVariable: 'acrpswd', usernameVariable: 'aksacrtcspoc')]) {
                    sh "docker login aksacrtcspoc.azurecr.io -u $aksacrtcspoc -p $acrpswd"
                }
                sh '''docker build -t poc-1:v1.$BUILD_ID .
                docker tag poc-1:v1.$BUILD_ID $registry/poc-1:v1.$BUILD_ID
                docker push $registry/poc-1:v1.$BUILD_ID
                docker rmi poc-1:v1.$BUILD_ID
                docker rmi $registry/poc-1:v1.$BUILD_ID'''
            }
        }

    }
}
