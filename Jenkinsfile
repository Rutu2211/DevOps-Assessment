pipeline{

	agent any
	tools {
		maven 'MAVEN'
	}
	stages {
        stage('Build Maven') {
            steps{
                #checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '2e870c5a-54bb-4f34-94a1-586d17a32b58', url: 'https://github.com/RajDevO/project002.git']]])
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'Rutu2211', url: 'https://github.com/Rutu2211/DevOps-Assessment.git']]])
		sh "mvn clean install"
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
	    }
	}

	environment {
		DOCKERHUB_CREDENTIALS=credentials('DOCKER_HUB_LOGIN')
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t slkrt2211/testrepo:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push slkrt2211/testrepo:latest'
			}
		}
		
		stage('File transfer into ansible server') {

			steps {
				sh 'scp /var/lib/jenkins/workspace/devassessment/* ubuntu@172.31.31.160:/home/ubuntu/project'
			}
		}
		stage('Login into ansible server and run playbook') {

			steps {
				sh """
				#!/bin/bash
				ssh ubuntu@172.31.31.160 << EOF
				cd project
				ansible-playbook ap.yml
				exit
				<< EOF
				"""
			}
		}
	}

// 	post {
// 		always {
// 			sh 'docker logout '
// 		}
// 	}

}
}
