import grails.util.Holders;

// XXX Revisar rutes
def envs= [
                                            "pre-int"   : ["/home/dynaKKu-pre"]
                                          ]
eventCreateWarStart = { warName, stagingDir ->
    def env = Holders.config.app.rutaConfig.ruta
    for (envMap in envs) {
        if (env.equals(envMap.key.toString()))
            ant.propertyfile(file: "${stagingDir}/WEB-INF/classes/application.properties") {
                entry(key: 'app.rutaConfig', value: envMap.value[0])
            }
    }
}
