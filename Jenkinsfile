                
                
pipeline{
        agent{
            label "dev"
       }
         stages{
        stage("Pull Code fromSCM"){
            steps{
                git branch: 'master', url: 'https://github.com/jaatbreak/simple_repo.git'
            }
        }
        stage("Build Image Docker"){
            steps{
                sh 'sudo docker build -t insta_app:$BUILD_TAG .'
		sh 'sudo docker tag insta_app:$BUILD_TAG amansingh12/insta_app:$BUILD_TAG'
            }
        }
        stage("push The image Docker-Hub "){
            steps{
                withCredentials([string(credentialsId: 'docker_hub', variable: 'docker_var')]){
                sh 'sudo docker login -u amansingh12 -p $docker_var'
		        sh 'sudo docker push amansingh12/insta_app:$BUILD_TAG'
                 }
            }
        }
        stage("QAT Work"){
            steps{
                 sh 'sudo docker run -dit -p 80:80 amansingh12/insta_app'
            }
        }
        stage("Testing Perfect Ready for Production"){
            steps{
                sh'echo "---------------Testing is Completed-------------------------------------"'
                
                sh'echo "------------------Ready For Production----------------------------------"'
            }
        }
        stage("Permission To Run Web in Production"){
		steps{
		    script{
			 Boolean userInput = input(id: 'Proceed1', message: 'Do You want Run Web in Production Environment?', parameters: [[$class: 'BooleanParameterDefinition', defaultValue: true, description: '', name: 'Please confirm you agree with this']])
                				echo 'userInput: ' + userInput      
	     }	
	   }
        }	 
        stage("Build The Kubernetes Containers For Production"){
            agent{
                label "deploy"
            }
            steps{
                sh"kubectl create deployment kbc --image=amansingh12/insta_app:jenkins-demo-pipe-3"
                sh"kubectl expose deployment kbc --type=NodePort --port=80"
                sh"kubectl get svc"
            }
        }
        stage("Deployment is to be Successful"){
            agent{
                label "deploy"
            }
            steps{
            sh 'echo "--------------------The Website is Running in The Production--------------------------------------"'
            }
        }
        
            
        
    }
}


                

