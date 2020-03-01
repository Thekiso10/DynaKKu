<div id="Footer" class="col-sm-12">
    <div class="container">
        <div class="row">
            <div class="col-sm-4 text-left">
                <g:img dir="images/imgWeb" file="LogoFooter.png" />
            </div>

            <div class="col-sm-4 text-center">
                <h4 class="text-center subTitle"><g:message code="footer.texto.titulo"/></h4>
                <span><g:message code="footer.texto.titulo.subText01"/></span>
                <span><g:message code="footer.texto.titulo.subText02"/>:</span>
                <a href="mailto:${message(code: "footer.texto.mailContacto")}"><g:message code="footer.texto.mailContacto"/></a>
            </div>

            <div class="col-sm-4 text-right">
                <h4><g:message code="footer.texto.version"/>: <span class="boldText">${grailsApplication.config.dynaKKu.version.app}</span></h4>
                <h5>
                    <a href="#"><g:message code="footer.texto.version.notas"/></a>
                </h5>
            </div>
        </div>
    </div>
</div>