pipeline {
  agent any
  stages {
    stage('Git Checkout') {
      steps {
        script {
          checkout([
            $class: 'GitSCM',
            branches: [[name: '*/main']],
            userRemoteConfigs: [[
              url: 'https://github.com/Amina-Nk/cicd-pipeline.git',
              credentialsId: 'github_credentials'
            ]]
          ])
        }

      }
    }

    stage('Build Application') {
      steps {
        sh 'chmod +x scripts/build.sh'
        sh 'whoami'
        sh './scripts/build.sh'
      }
    }

    stage('Run Tests') {
      steps {
        sh './scripts/test.sh'
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t ${DOCKER_IMAGE}:${env.BUILD_NUMBER} .'
        sh 'docker tag ${DOCKER_IMAGE}:${env.BUILD_NUMBER} ${DOCKER_IMAGE}:latest'
      }
    }

    stage('Docker Push') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_creds_id') {
            sh "docker push ${DOCKER_IMAGE}:${env.BUILD_NUMBER}"
            sh "docker push ${DOCKER_IMAGE}:latest"
          }
        }

      }
    }

  }
  environment {
    DOCKER_IMAGE = 'aminank/cicd_pipeline_image'
  }
}