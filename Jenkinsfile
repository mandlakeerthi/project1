pipeline {

    agent any

    stages {

        stage ('checkout') {

            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/jyothibasu/hello-world.git']]])
            }
        }

        stage ('"Code Analysis"') {

            steps {
                sh '''mvn sonar:sonar \\
                -Dsonar.projectKey=Poc-AKS1 \\
                -Dsonar.host.url=http://52.140.116.20:9000 \\
                -Dsonar.login=e5ae4daa1e4c7cffe91ed213468a069ce581ff69'''
            }
        }

        stage ('Build') {

            steps {

                sh 'mvn clean package'
                
            }
        }

        stage ('Store Artifacts-jfrog') {

            steps {
                sh 'curl -uadmin:AP34mCp3r3nLNeLoHTaGnbrAuEJ -T webapp/target/webapp.war "http://52.140.116.20:8081/artifactory/example-repo-local/"'
            }
        }

        stage ('Build & Push image') {

            steps {
                sh '''docker build -t jyothibasuk/poc-1 .
                docker push jyothibasuk/poc-1'''                
            }
        }

        stage ('K8S Deploy') {

            steps {
                script {
                    
                    kubernetesDeploy(
                    configs: 'aks-deployment.yaml',
                    kubeconfigId: 'AKS_Credentials',
                    enableConfigSubstitution: true
                    ) 
                }
                
            }
        }

    }
}