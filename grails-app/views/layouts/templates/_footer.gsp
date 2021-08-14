<footer>
    <div id="Footer" class="col-sm-12">
        <div class="container">
            <div class="row">
                <div class="col-sm-4 text-left imgLogo">
                    <g:img id="imgLogoFooter" dir="images/imgWeb" file="LogoFooter.png" />
                </div>

                <div class="col-sm-4 text-center textCentral">
                    <h4 class="text-center subTitle"><g:message code="footer.texto.titulo"/></h4>
                    <span><g:message code="footer.texto.titulo.subText01"/></span>
                </div>

                <div class="col-sm-4 text-right textVersion">
                    <h4><g:message code="footer.texto.version"/>: <span class="boldText">${grailsApplication.config.dynaKKu.version.app}</span></h4>
                    <h5>
                        <a href="${grailsApplication.config.dynaKKu.version.notas.url}" target="_blank"><g:message code="footer.texto.version.notas"/></a>
                    </h5>
                </div>
            </div>
        </div>
    </div>
</footer>