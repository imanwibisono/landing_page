env.DOCKER_REGISTRY = 'imanwibi'
env.DOCKER_IMAGE_NAME = 'landing_page'
node('master') {
	stage('HelloWorld') {
      echo 'Hello World'
    }
    stage('Git Pull from Github') {
      git credentialsId: 'github_imanwibisono', url: 'https://github.com/imanwibisono/landing_page.git'
    }
      stage('Build Docker Image') {
        def customImage = docker.build("$DOCKER_IMAGE_NAME:${BUILD_NUMBER}")
        // sh "docker build --build-arg APP_NAME=landing_page -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:p-${BUILD_NUMBER} ."   
    }
    //   stage('Push Docker Image to Dockerhub') {
    //       sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:${BUILD_NUMBER}"
    // }
    stage('Push Docker Image') {
        /* Push image using withRegistry. */
        docker.withRegistry('https://docker.io', 'docker_imanwibisono') {
            customImage.push()
            customImage.push("latest")
        }
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
