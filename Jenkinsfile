pipeline {
    agent any 
    
    tools{
        nodejs 'nodejs 10:19.0'
    }
    
    stages{
        
        stage("Git Checkout"){
            steps{
                git branch: 'master', changelog: false, poll: false, url: 'https://github.com/jyothi62/nodejs-webapp.git'
            }
        }
        
        stage("Install Dependencies"){
            steps{
                sh "npm install"
            }
        }
        
        stage("OWASP Dependency Check"){
            steps{
                dependencyCheck additionalArguments: '--scan ./ ', odcInstallation: 'DP'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        
        stage("Docker Build & Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: '58be877c-9294-410e-98ee-6a959d73b352', toolName: 'docker') {
                        
                        sh "docker build -t sample-nodejs ."
                        sh "docker tag sample-nodejs jyothi62/sample-nodejs:latest "
                        sh "docker push jyothi62/sample-nodejs:latest "
                    }
                }
            }
        }
        
        stage("Docker Deploy"){
            steps{
               script{
                   withDockerRegistry(credentialsId: '58be877c-9294-410e-98ee-6a959d73b352', toolName: 'docker') {
                        
                        sh "docker run -d --name demo-nodejs -p 8081:8081 jyothi62/sample-nodejs:latest "
                    }
                } 
            }
        }
    }
}