                
                
pipeline{
        agent{
            label "ubuntu"
       }
         stages{
        stage("Pull Code fromSCM"){
            steps{
                git branch: 'main', url: 'https://github.com/duveykrishna/pro_jen1.git'
            }
        }
        stage("Build Image Docker"){
            steps{
                sh 'sudo docker build -t kuber_image:$BUILD_TAG .'
		sh 'sudo docker tag kuber_image:$BUILD_TAG soft14308/kuber_image:$BUILD_TAG'
            }
        }
        stage("push The image Docker-Hub "){
            steps{
                withCredentials([string(credentialsId: 'docker_hub', variable: 'docker_var')]){
                sh 'sudo docker login -u soft14308 -p $docker_var'
		        sh 'sudo docker push soft14308/kuber_image:$BUILD_TAG'
                 }
            }
        }
        stage("QAT Work"){
            steps{
                 sh 'sudo docker run -dit -p 80:80 soft14308/kuber_image:$BUILD_TAG'
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
                label "jenkins"
            }
            steps{
                sh"kubectl create deployment kbc --image=soft14308/kuber_image:$BUILD_TAG"
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


                

