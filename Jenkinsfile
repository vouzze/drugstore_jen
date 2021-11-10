pipeline {
	agent any
	tools {
		maven "3.3.9"
	}
	environment {
		PROJECT_ID = 'cogent-reach-331610'
                CLUSTER_NAME = 'harniukcluster'
                LOCATION = 'europe-west3-a'
                CREDENTIALS_ID = 'kubernetes'
    	}
	stages {
    		stage('Build') {
       			steps {
            			sh 'mvn clean package'
        		}
    		}
    		stage('Docker Build') {
        		steps {
				sh 'whoami'
            			script {
					myimage = docker.build("vossi11037/drugstore_jen:${env.BUILD_ID}")
                		}
            		}
        	}
		stage('Push Docker Image') {
                	steps {
                   		script {
                      			docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                      				myimage.push("${env.BUILD_ID}")
                     			}   
                   		}
                	}
            	}
   		stage('Deploy') {
			steps {
				sh 'ls -ltr'
		   		sh 'pwd'
		   		sh "sed -i 's/tagversion/${env.BUILD_ID}/g' deployment.yaml"
                   		step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
		   		echo "Deployment Finished ..."
			}
    		}
	}
	post {
		always {
			echo 'Always!!!'
		}
	}
}
