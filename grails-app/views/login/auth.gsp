<!DOCTYPE html>
<html>
<head>
	<meta name='layout' content='layoutSimple'/>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'login.css')}" type="text/css">
	<title><g:message code="springSecurity.login.title"/></title>
</head>
<body>

<div id='login' class="container">
	<div class="">

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

		<form action="${postUrl}" method="POST" id="loginForm" class="form-horizontal loginBox" autocomplete="off">

			<div class="form-group">
				<label for="username" class="col-sm-4 control-label">
					<g:message code="springSecurity.login.username.label"/>:
				</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="j_username" id="username" ${lockedaccount ? 'disabled="disabled"' : ''}/>
				</div>
			</div>

			<div class="form-group">
				<label for="password" class="col-sm-4 control-label">
					<g:message code="springSecurity.login.password.label"/>:
				</label>
				<div class="col-sm-5">
					<input type="password" class="form-control" name="j_password" id="password" ${lockedaccount ? 'disabled="disabled"' : ''}/>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-7">
					<div class="checkbox text-left">
						<label class="remember_me">
							<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me'/>
							<g:message code="springSecurity.login.remember.me.label"/>
						</label>
					</div>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-7 text-left buttons">
					<input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}' class="btn btnLogin"/>
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
