pipeline {
      agent any
      tools {nodejs "nodejs"}
      
      stages {
          stage('Install dependencies') {
      steps {
        sh 'npm i -save express'
      }
    }     
    stage('Test') {
      steps {
         sh 'node server.js'
      }
    }
          stage('Deploy'){
             steps{
                 sh 'sudo systemctl start docker'
                 sh 'sudo docker-compose up -d'
                  }
                          }
              }
          } 
