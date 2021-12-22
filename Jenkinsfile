pipeline {
      agent any
      environment{
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
     }
      tools {nodejs "nodejs"}
      
      stages {
          stage('Install dependencies') {
      steps {
        sh 'npm install'
      }
    }     
    stage('Test') {
      steps {
         sh 'ng build --prod --base-href /angular-frontend/'
      }
    }
        stage('SonarQube analysis & Mvn') {
              steps{
                   withSonarQubeEnv('sonarqube'){
                     sh 'mvn clean install -DskipTests sonar:sonar'
                    //-Dsonar.projectKey=sonar-maven \
                    //-Dsonar.host.url=http://192.168.50.104:9000 \
                    ///-Dsonar.login=d33c224155aa7f3777856387ded0dccd7205a02b \
                    //-Dsonar.sources=src/main/java/ \
                    //-Dsonar.java.binaries=target/classes"
                   }
              }
           }
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
        stage('docker push'){
              steps{
                 sh 'whoami'
                 sh 'docker build -t dockerdmantz/ang-repo .'
                 sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                 sh 'docker push dockerdmantz/ang-repo'
              }
         }
              }
          } 
