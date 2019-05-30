pipeline {
  agent any
  stages {
    stage('gitclone') {
      steps {
        git(poll: true, url: 'https://github.com/Amarlanda/publis-spaient-demo.git')
      }
    }
  }
}
