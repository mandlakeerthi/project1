pipeline {

    agent any

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
        
        stage('Docker Build image'){
            steps {
                sh "docker login -u 'keerthimandla' -p 'Keerthi@123'"
                sh '''docker build -t poc-1:v1.$BUILD_ID .
                docker tag poc-1:v1.$BUILD_ID keerthimandla/keerthi:$BUILD_ID
                docker push keerthimandla/keerthi:$BUILD_ID
                docker rmi keerthimandla/keerthi:$BUILD_ID''' 
            }
        }

    }
}
