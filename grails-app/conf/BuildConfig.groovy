grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6

info.app.build.date = new Date().format('yyyy-MM-dd')
grails.project.war.file = "target/${appName}-${appVersion}-${info.app.build.date}.war"
/*
grails.project.fork = [
    // configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
    //  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

    // configure settings for the test-app JVM, uses the daemon by default
    test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    // configure settings for the run-app JVM
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the run-war JVM
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the Console UI JVM
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]
*/
grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "info" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        mavenLocal()
        grailsCentral()
        mavenCentral()
        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        mavenRepo "http://repository.codehaus.org"
		mavenRepo 'http://repo.spring.io/milestone'
		// sense aixo no va
		mavenRepo "http://repo.grails.org/grails/core"
		mavenRepo "http://repo.grails.org/grails/plugins"
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
        runtime 'mysql:mysql-connector-java:5.1.29'
        test "org.grails:grails-datastore-test-support:1.0-grails-2.4"
		//Plugins
		compile "commons-io:commons-io:2.4",
                'com.itextpdf:itextpdf:5.5.13.1'
    }

    plugins {
        // plugins for the build system only
        build ":tomcat:7.0.54"

		// plugins needed at runtime but not for compilation
		runtime ":hibernate4:4.3.5.4" // or ":hibernate:3.6.10.16"
		runtime ":database-migration:1.4.0"
		runtime ":jquery:1.11.1"

        // plugins for the compile stept
        compile ":spring-security-core:2.0-RC5"
        compile ":scaffolding:2.1.2",
				':cache:1.1.7',
				":asset-pipeline:1.8.11",
				":twitter-bootstrap:3.3.4"
    }
}
