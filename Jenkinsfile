env.DOCKER_REGISTRY = 'imanwibi'
env.DOCKER_IMAGE_NAME = 'jenkins-landing_page'
node('master') {
	stage('HelloWorld') {
      echo 'Hello World'
    }
    stage('Git Pull from Github') {
      git credentialsId: 'github_imanwibisono', url: 'https://github.com/imanwibisono/landing_page.git'
    }
      stage('Build Docker Image') {
        sh "docker build --build-arg APP_NAME=jenkins-landing_page -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER} ."   
    }
      stage('Push Docker Image to Dockerhub') {
         sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER}"
    }

      stage('DeployTo Kubernetes Cluster') {
        kubernetesDeploy(
          kubeconfigId: 'kube_config',
          configs: 'config_kubernetes.yml',
          enableConfigSubstitution: true
        )
    }
    stage('Remove Docker Image') {
        sh "docker rmi $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER}"   
    }
}
