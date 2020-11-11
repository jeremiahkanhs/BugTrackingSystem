pipeline {
	agent any
	stages {
		stage ('Compilation') {
			steps {
				bat """
					set classpath=WebContent/WEB-INF/lib/*
					javac src/Controller/*.java src/Service/*.java src/DAO/*.java src/Model/*.java src/Utilities/*.java
				"""
			}
		}
		stage ('Testing') {
			steps {
				echo 'Hello World'
			}				
		}
	}
}