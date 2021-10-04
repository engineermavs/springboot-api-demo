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
                step.buildNum()
                step.buildDocker()
            }
        }
    

      stage("Push image") {
        steps {
                step.pushDocker()
          }
     }
 }
  
}
