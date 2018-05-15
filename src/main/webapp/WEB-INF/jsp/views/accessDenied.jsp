<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="loginPageTemplate">
	<tiles:putAttribute name="head">
		<title><spring:message
				code="area.vasta.protocollo.web.msgs.access.denied.page.title" /></title>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="container">
			<div class="login-panel panel panel-danger">
				<div class="panel-body">
					<div class="alert alert-danger">
						<strong><spring:message	code="area.vasta.protocollo.web.msgs.access.denied.page.msg" /></strong>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>