node {
  stage('Preparation') {
    poll scm// for display purposes
    sh 'ls'
    git 'https://github.com/Amarlanda/jenkins.git'
  }
  stage ('checkout'){
    sh 'mvn test'
  }
}
