<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authorize access="isAuthenticated()">
    <% response.sendRedirect("home"); %>
</sec:authorize>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Accedi</title>
	</tiles:putAttribute>
	<tiles:putAttribute name="menuFunzioni">
		<p></p>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="sfondo_body">
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<div class="login-panel panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">Accedi per favore</h3>
						</div>
						<div class="panel-body">
							<c:if test="${param.error ne null}">
								<div class="alert alert-danger">    
                    				<strong>Spiacente! Nome utente e/o password errati</strong>
                				</div>
							</c:if>
							<c:if test="${param.logout ne null}">
								<div class="alert alert-success">    
                    				<strong>Ti sei disconnesso con successo</strong>
                				</div>
							</c:if>		
							<form role="form" id="loginForm" method="post" action='<spring:url value="/login" />'>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>.
								<fieldset>
									<div class="input-group input-sm">
										<label class="input-group-addon" for="username"><i class="fa fa-user"></i></label>
										<input class="form-control" placeholder="Nome utente" data-error="Campo obbligatorio" name="username" id="username"	type="text" required>
										 <div class="help-block with-errors"></div>
									</div>
									<div class="input-group input-sm">
										<label class="input-group-addon" for="password"><i class="fa fa-lock"></i></label>
										<input class="form-control" placeholder="Password" data-error="Campo obbligatorio" name="password" id="password" type="password" value="" required>
										 <div class="help-block with-errors"></div>
									</div>
									<button id="accedi" name="accedi" class="btn btn-lg btn-success btn-block btn-primary">
										Accedi
									</button>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>