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
        sh 'docker build --progress=plain -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .'
        sh 'docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest'
      }
    }

    stage('Docker Push') {
      steps {
        script {
          def app = docker.build("aminank/cicd_pipeline_image:${env.BUILD_NUMBER}")
        }

        script {
          docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_creds_id') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }

      }
    }

  }
  environment {
    DOCKER_IMAGE = 'aminank/cicd_pipeline_image'
  }
}