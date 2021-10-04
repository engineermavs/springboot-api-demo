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
              script {
                step.buildNum()
                step.buildDocker()
              }
            }
        }
    

      stage("Push image") {
        steps {
          script {
                step.pushDocker()
          }
        }
     }
 }
  
}
