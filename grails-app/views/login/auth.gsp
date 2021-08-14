<!DOCTYPE html>
<html>
<head>
	<meta name='layout' content='layoutSimple'/>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'login.css')}" type="text/css">
	<title><g:message code="springSecurity.login.title"/></title>
</head>
<body>

<div id='login' class="container">
	<div class="container-login">

		<div class="form-group">
			<h2 class="text-center titleLogin">
				<g:message code="springSecurity.login.header"/>
			</h2>
		</div>

		<g:if test="${flash.message}">
			<div class="flash errors iconoError">
				<div class="" role="status">${flash.message}</div>
			</div>
		</g:if>

		<form action="${postUrl}" method="POST" id="loginForm" class="form-horizontal" autocomplete="off">

			<div class="form-group">
				<label for="username" class="col-sm-4 col-sm-offset-1 control-label">
					<g:message code="springSecurity.login.username.label"/>:
				</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="j_username" id="username" ${lockedaccount ? 'disabled="disabled"' : ''}/>
				</div>
			</div>

			<div class="form-group">
				<label for="password" class="col-sm-4 col-sm-offset-1 control-label">
					<g:message code="springSecurity.login.password.label"/>:
				</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" name="j_password" id="password" ${lockedaccount ? 'disabled="disabled"' : ''}/>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-5  col-sm-7">
					<div class="checkbox text-left">
						<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' checked/>
						<label class="remember_me" for="remember_me">
							<g:message code="springSecurity.login.remember.me.label"/>
						</label>
					</div>
				</div>
			</div>

			<div class="form-group padding-top-1">
				<div class="col-sm-offset-5 col-sm-7">
					<input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}' class="button large"/>
				</div>
			</div>

		</form>
		
	</div>
</div>

<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>
