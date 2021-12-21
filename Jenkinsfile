pipeline {
      agent any
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
              }
          } 
