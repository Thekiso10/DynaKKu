<div id="header">
    <div class="container">
        <div id="grailsLogo" class="col-sm-12" role="banner">
            <g:link controller="estadisticas" action="index">
                <div class="col-sm-6" id="BannerLogo">
                    <g:img id="LogoLayoutMain" class="col-sm-3" dir="images/imgWeb" file="LogoLayoutMain.png"/>
                    <h1 class="col-sm-9"><g:message code="grailsLogo.bannerLogo.nombrePrograma"/></h1>
                </div>

                <%
                    // Links idiomes
                    def linkCat = request.getForwardURI()
                    def linkEs = request.getForwardURI()
                    def linkEn = request.getForwardURI()

                    StringBuffer parametres = new StringBuffer()
                    Map map = request.getParameterMap()

                    for (String key: map.keySet()) {
                        if (key != "lang") {
                            if (map.get(key) instanceof String){
                                parametres.append("&" + key + "=" + map.get(key))
                            }else{
                                map.get(key).each { it ->
                                    parametres.append("&" + key + "=" + it)
                                }
                            }
                        }
                    }

                    linkCat += "?lang=ca_ES" + parametres.toString()
                    linkEs  += "?lang=es" + parametres.toString()
                    linkEn 	+= "?lang=en_US" + parametres.toString()
                %>

                <div class="col-sm-6" id="BannerI18n">
                    <g:link url="${linkEs}"><span class="borderI18n"><g:message code="grailsLogo.bannerLogo.idiomaLink.es"/></span></g:link>
                    <g:link url="${linkCat}"><span class="borderI18n"><g:message code="grailsLogo.bannerLogo.idiomaLink.cat"/></span></g:link>
                    <g:link url="${linkEn}"><span><g:message code="grailsLogo.bannerLogo.idiomaLink.eng"/></span></g:link>
                </div>
            </g:link>
        </div>
    </div>
</div>