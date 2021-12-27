pipeline {
      agent any
      environment{
        DOCKERHUB_CREDENTIALS = credentials('5402a8e2-7488-4697-afed-2d08e8c99ed0')
     }
      tools {nodejs "nodejs"}
      
      stages {
          stage('Install dependencies') {
      steps {
        sh 'npm install'
        sh 'npm install --save-dev sonar-scanner'
      }
    } 
        stage('Sonarqube Analysis') {
      steps {
        sh 'npm run sonar'
        sh 'ng build --prod --base-href /angular-frontend/'
      }
    }
        stage('Maven build') {
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
        stage('push to repository'){
              steps{
                 sh 'whoami'
                 sh 'docker build -t dockerdmantz/ang-repo .'
                 sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                 sh 'docker push dockerdmantz/ang-repo'
              }
         }
              }
          } 
