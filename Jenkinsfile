pipeline {
  agent any
  stages {
    stage('Git Checkout') {
      steps {
        git(url: 'https://github.com/Amina-Nk/cicd-pipeline.git', credentialsId: 'github_credentials', branch: 'main', changelog: true)
      }
    }

    stage('Build Application') {
      steps {
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

  }
  environment {
    DOCKER_IMAGE = 'aminank/cicd_pipeline_image'
  }
}