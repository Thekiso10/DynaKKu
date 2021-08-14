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

<!-- Header -->
<header id="header">
    <g:link controller="usuario" action="index" class="logo">
        <g:img id="LogoLayoutMain" dir="images/imgWeb" file="LogoLayoutMain.png"/>
        <g:message code="grailsLogo.bannerLogo.nombrePrograma"/>
    </g:link>
    <ul class="icons">
       <g:link url="${linkEs}">
            <span class="label"><g:message code="grailsLogo.bannerLogo.idiomaLink.es"/></span>
        </g:link>
        <g:link url="${linkCat}">
            <span class="label"><g:message code="grailsLogo.bannerLogo.idiomaLink.cat"/></span>
        </g:link>
        <g:link url="${linkEn}">
            <span class="label"><g:message code="grailsLogo.bannerLogo.idiomaLink.eng"/></span>
        </g:link>
    </ul>
</header>