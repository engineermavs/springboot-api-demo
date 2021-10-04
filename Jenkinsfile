@Library('shared-library') _

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
                buildNum()
                docker.buildDocker()
            }
        }
    

      stage("Push image") {
        steps {
                docker.pushDocker()
          }
     }
 }
  
}
