pipeline {
	agent any
	stages {
		stage ('Compilation') {
			steps {
				bat 'javac *.java'
			}
		}
		stage ('Testing') {
			steps {
				echo 'Hello World'
			}				
		}
	}
}