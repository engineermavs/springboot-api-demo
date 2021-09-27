pipeline {
  agent any

  tools {
    maven 'mvn-3.5.2'
  }

  stages {
    stage('Build') {
      steps {
        sh 'mvn package'
      }
    }
    
        stage("Build image") {
            steps {
                script {
                    myapp = docker.build("jaganthoutam/ledger-service:${env.BUILD_ID}")
                }
            }
        }
    
    stage('Check Specification') {
      steps {
        sh "chmod o+w *"
        sh "docker-compose up --exit-code-from cucumber --build"
      }
    }
  }

  post {
    always {
      archive 'target/**/*.jar'
      junit 'target/**/*.xml'
      cucumber '**/*.json'
    }
  }


  stage("Push image") {
        steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
               }
          }
     }
}
