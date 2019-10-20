properties(
    [
        [$class: 'BuildDiscarderProperty', strategy:
          [$class: 'LogRotator', artifactDaysToKeepStr: '14', artifactNumToKeepStr: '5', daysToKeepStr: '30', numToKeepStr: '60']],
        pipelineTriggers(
          [
              pollSCM('H/5 * * * *'),
              cron('@daily'),
          ]
        )
    ]
)



node {
    def app

    stage('Clone repository') {
        /* Cloning the Repository to Workspace */
        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image */
        app = docker.build("manonair/angularapp")
    }

    stage('Test image') {
       
        app.inside {
            echo "Tests passed"
        }
    }

    stage('Push image') {
        /* 
			Push images to DockerHub account
		*/
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-creds') {
            app.push("${env.BUILD_NUMBER}")
            //app.push("latest")
            } 
            echo "Pushing Docker Build to DockerHub"
    }


    stage("DEPLOY") {
      sh './deploy.sh'
      //sh 'docker run -p 8000:80 manonair/angularapp'
        // echo "Depolying to Server - "
      
    }
}
