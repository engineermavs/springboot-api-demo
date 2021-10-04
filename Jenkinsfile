@Library (shared-library) _

pipeline {
  agent any

  tools {
    maven 'mvn-version'
  }

  stages {
    stage('Build') {
      steps {
        mavenPackage()
      }
    }
    
        stage("Build image") {
            steps {
                script {
                    echo "Build image with tag: ${env.BUILD_ID}"
                    myapp = docker.build("mvllrmnmjc/ledger-service:${env.BUILD_ID}", "--build-arg VERSION=${env.BUILD_ID} .")
                }
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
  
}
