node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("layamoorthy/webpage")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * Just an example */

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhubid') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
     stage('Deploy Docker Container') {
            steps {
                ansiblePlaybook credentialsId: 'ansibleid', disableHostKeyChecking: true, extras: '-e TAG=${TAG} -e ENV=${DEPLOY_TO} --tags webpage', installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: '/etc/ansible/docker-deployment.yml'
            }
        }
        
        stage('Clean') {
            steps {
                sh "docker image rm -f ${REGISTRY}/webpage:${TAG}"
                sh "docker system prune -f"
                
            }
        }
}
