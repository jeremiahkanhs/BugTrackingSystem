pipeline {
	agent any
	stages {
		stage ('Compilation') {
			steps {
				bat 'javac -cp ".:.WebContent\WEB-INF\lib\*.jar" src/Controller/*.java src/Service/*.java src/DAO/*.java src/Model/*.java src/Utilities/*.java'
			}
		}
		stage ('Testing') {
			steps {
				echo 'Hello World'
			}				
		}
	}
}