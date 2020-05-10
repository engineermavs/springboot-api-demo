pipeline {

    agent any
     tools {
         maven 'ADOP Maven'
  //       jdk 'ADOP JDK'

     }

      environment {
        CI = 'true'
    }

    stages {
        stage('SonarQube analysis') {
            steps {
                    withSonarQubeEnv(credentialsId: 'sonar', installationName: 'ADOP Sonar') {
                    sh 'mvn clean install'
                    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.6.0.1398:sonar -Dsonar.projectKey=springboot-api-demo -Dsonar.sources=src/main'
                }
            }
        }

        stage("Quality Gate") {
            steps {
              sleep(10) {
                waitForQualityGate abortPipeline: true
              }
            }
        }

        stage('Deploy') {
            environment {
                pom = readMavenPom file: 'pom.xml'
            }
            steps {
                    script {
                            pom = readMavenPom file: 'pom.xml'
                            echo pom.groupId
                            echo pom.version

                              nexusArtifactUploader(
                              nexusVersion: 'nexus3',
                              protocol: 'http',
                              nexusUrl: 'nexus:8081/nexus',
                              groupId: pom.groupId,
                              version: pom.version,
                              repository: 'spring-boot-api',
                              credentialsId: 'adop-admin',
                              artifacts: [
                                    [artifactId: pom.artifactId,
                                    file: "target/${pom.artifactId}-${pom.version}.jar",
                                    type: 'jar']
                              ]
                        )
                 }
            }
        }

        stage('Build image') {
            steps {
                script {
                    echo "Build image with tag: ${env.BUILD_ID} and version: ${pom.version}"
                    dockerImage = docker.build("192.168.1.168:5000/springboot-api-demo:${env.BUILD_ID}", "--build-arg VERSION='${pom.version}' .")
                }
            }
        }

        stage('Push image to registry') {
            steps {
                script {
                    docker.withRegistry('http://192.168.1.168:5000', 'adop-admin') {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }
        
        stage('Deploy to k8s') {
            steps {
                    //sh "scp -o StrictHostKeyChecking=no deployment.yaml root@192.168.1.166:/home/"
                script {
                 
                    withCredentials([kubeconfigFile(credentialsId: 'k8s-config', variable: 'KUBECONFIG')]) {
                       sh "sed -i 's/latest/${BUILD_ID}/g' springboot-k8s-deployment.yaml"
                       sh "sed -i 's/APPVERSION/\"${pom.version}\"/g' springboot-k8s-deployment.yaml"
                       sh "kubectl --kubeconfig=${KUBECONFIG} apply -f springboot-k8s-deployment.yaml"
                       sh "./pod_check.sh springboot-api-demo ${pom.version} ${KUBECONFIG}"
                    }
                }
            }          
        }
        
        stage('Remove unused docker image') {
            steps {
                sh "docker image rm 192.168.1.168:5000/springboot-api-demo:${env.BUILD_ID}"
            }
        }

    }


}
