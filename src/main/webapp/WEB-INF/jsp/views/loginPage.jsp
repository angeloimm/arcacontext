<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="loginPageTemplate">
	<tiles:putAttribute name="head">
		<title><spring:message code="area.vasta.protocollo.web.msgs.login.page.title" /></title>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<div class="login-panel panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title"><spring:message code="area.vasta.protocollo.web.msgs.login.msg" /></h3>
						</div>
						<div class="panel-body">
							<c:if test="${param.error ne null}">
								<div class="alert alert-danger">    
                    				<strong><spring:message code="area.vasta.protocollo.web.msgs.login.error.msg" /></strong>
                				</div>
							</c:if>
							<c:if test="${param.logout ne null}">
								<div class="alert alert-success">    
                    				<strong><spring:message code="area.vasta.protocollo.web.msgs.login.logout.msg" /></strong>
                				</div>
							</c:if>		
							<form role="form" method="post" action='<spring:url value="/login" />'>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>.
								<fieldset>
									<div class="input-group input-sm">
										<label class="input-group-addon" for="username"><i class="fa fa-user"></i></label>
										<input class="form-control" placeholder='<spring:message code="area.vasta.protocollo.web.msgs.login.username.placeholder" />' name="username" id="username"
											type="text" autofocus>
									</div>
									<div class="input-group input-sm">
										<label class="input-group-addon" for="password"><i class="fa fa-lock"></i></label>
										<input class="form-control" placeholder='<spring:message code="area.vasta.protocollo.web.msgs.login.password.placeholder" />'
											name="password" id="password" type="password" value="">
									</div>
									<!-- Change this to a button or input when using this as a form -->
									<!-- <a href="index.html" class="btn btn-lg btn-success btn-block">Login</a> -->
									<button id="accedi" name="accedi" class="btn btn-lg btn-success btn-block"><spring:message code="area.vasta.protocollo.web.msgs.login.button" /></button>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>