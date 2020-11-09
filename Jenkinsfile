pipeline {
	agent any
	stages {
		stage ('Compilation') {
			steps {
				bat 'set classpath=../WebContent/WEB-INF/lib/gson-2.8.6.jar;../WebContent/WEB-INF/lib/servlet-api.jar;../WebContent/WEB-INF/lib/mysql-connector-java-8.0.18;'
				bat 'javac src/Controller/*.java src/Service/*.java src/DAO/*.java src/Model/*.java src/Utilities/*.java'
			}
		}
		stage ('Testing') {
			steps {
				echo 'Hello World'
			}				
		}
	}
}