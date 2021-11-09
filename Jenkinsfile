pipeline {
	agent any
	tools {
		maven "3.3.9"
	}
	stages {
    		stage('Git Checkout'){
			steps {
            			git credentialsId: 'github',
        			url: 'https://github.com/vouzze/drugstore_jen',
        			branch: "main"
        		}
		}
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
	    	stage('Pushing Docker Image to Dockerhub') {
            		steps {
                		script {
                    			docker.withRegistry('https://registry.hub.docker.com') {
                        			docker.image("vouzze/drugstore_jen:${TAG}").push()
                        			docker.image("vouzze/drugstore_jen:${TAG}").push("latest")
                    			}
                		}
            		}
        	}
   		stage('Deploy'){
			steps {
            			sh "docker stop drugstore_jen | true"
        			sh "docker rm drugstore_jen | true"
        			sh "docker run --name drugstore_jen -d -p 9004:8080 vouzze/drugstore_jen:${TAG}"
        		}
    		}
	}
	post {
		always {
			echo 'Always!'
		}
	}
}
