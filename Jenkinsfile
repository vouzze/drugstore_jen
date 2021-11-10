pipeline {
	agent any
	tools {
		maven "3.3.9"
	}
	environment {
        	DATE = new Date().format('yy.M')
        	TAG = "${DATE}.${BUILD_NUMBER}"
    	}
	stages {
    		stage('Build') {
       			steps {
            			sh 'mvn clean package'
        		}
    		}
    		stage('Docker Build') {
        		steps {
            			script {
                   			docker.build("vouzze/drugstore_jen:${TAG}")
                		}
            		}
        	}
   		stage('Deploy') {
			steps {
				script {
	            			sh "docker stop drugstore_jen | true"
        				sh "docker rm drugstore_jen | true"
        				sh "docker run --name drugstore_jen -d -p 9004:8080 vouzze/drugstore_jen:${TAG}"
				}
			}
    		}
	}
	post {
		always {
			echo 'Always!!!'
		}
	}
}
