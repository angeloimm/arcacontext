<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<spring:url value="/domande" var="urlJson" />
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<link rel="icon" type="image/png"
	href="<spring:url value="/resources/img/logo-rve.png" />" />

<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/bootstrap/css/bootstrap.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/font-awesome/css/font-awesome.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/bootstrap-select/css/bootstrap-select.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/smartmenus/css/jquery.smartmenus.bootstrap.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/introjs/css/introjs.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/dataTables/DataTables-1.10.16/css/dataTables.bootstrap.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/mark/css/datatables.mark.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/datatables-responsive/responsive.dataTables_v_2.2.0.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/bootstrap-switch/bootstrap-switch.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/vendor/bootstrap-dialog/css/bootstrap-dialog.min.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/css/custom.css" />" />
<link rel="stylesheet"
	href="<spring:url value="/resources/css/style.css" />" />


<script
	src="<spring:url value="/resources/vendor/jquery/jquery-3.2.1.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/moment/moment-with-locales.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/bootstrap-select/js/bootstrap-select.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/bootstrap-select/js/i18n/defaults-it_IT.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/smartmenus/js/jquery.smartmenus.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/smartmenus/js/jquery.smartmenus.bootstrap.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/introjs/js/intro.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/ScrollToFixed/jquery-scrolltofixed-min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/bootpag/jquery.bootpag.min.js" />"></script> 
<script
	src="<spring:url value="/resources/vendor/handlebars/handlebars-v4.0.10.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/bootstrap-validator/validator.min.js" />"></script>
<script src="<spring:url value="/resources/js/slimFormatter.min.js" />"
	type="text/javascript" charset="UTF-8"></script>
<script src="<spring:url value="/resources//js/main.js" />"
	type="text/javascript" charset="UTF-8"></script>
<script src="<spring:url value="/resources//js/main.js" />"
	type="text/javascript" charset="UTF-8"></script>
<script src="<spring:url value="/resources//js/script.js" />"
	type="text/javascript" charset="UTF-8"></script>
<script
	src="<spring:url value="/resources/vendor/blockui/jquery.blockUI.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/dataTables/datatables.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/dataTables/DataTables-1.10.16/js/dataTables.bootstrap.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/datatables-responsive/dataTables.responsive_v_2.2.0.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/bootstrap-switch/bootstrap-switch.min.js" />"></script>
<script
	src='<spring:url value="/resources/vendor/mark/js/jquery.mark.min.js"/>'></script>
<script
	src='<spring:url value="/resources/vendor/mark/js/datatables.mark.min.js"/>'></script>
<script
	src="<spring:url value="/resources/vendor/bootstrap-dialog/js/bootstrap-dialog.min.js" />"></script>
<script
	src="<spring:url value="/resources/vendor/jquery-fileDownload/jquery.fileDownload.js" />"></script>

<script type="text/javascript" charset="UTF-8">
	//Gestione CSRF
	var csfrToken = $("meta[name='_csrf']").attr("content");
	var csfrHeader = $("meta[name='_csrf_header']").attr("content");
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csfrHeader, csfrToken);
	});
</script>
<tiles:insertAttribute name="head" />
</head>

<body>
	<div class="header">
		<!-- Logo Titolo Utente ================================================== -->
		<div class="header_middle clearfix">
			<div class="row-same-height">
				<div
					class="col-sm-3 col-md-3 col-lg-3 col-height col-middle hidden-xs">
					<a class="intestazione" href="/graduatoriaMedici/home"
						title="Homepage"> <img class="logo-regione img-responsive"
						alt="Regione del Veneto"
						src="<spring:url value="/resources/img/logo-rve-lungo.png"/>">
					</a>
				</div>
				<div
					class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-height col-middle text-center">
					<span class="title">GRADUATORIA MEDICI</span>
				</div>
				<sec:authorize access="isAuthenticated()">
					<div
						class="col-xs-6 col-sm-6 col-md-3 col-lg-3 col-height col-middle text-right">
						<div class="row">
							<div class="col-xs-4 col-sm-4 col-md-5 col-lg-3 text-left">
								<span class="utente">Utente:</span>
							</div>
							<div
								class="col-xs-8 col-sm-8 col-md-7 col-lg-9 text-left uppercase">
								<c:set value="${sessionScope.utente.nome}  ${sessionScope.utente.cognome}" var="nominativo" />
								<div class="text_wrap_hidden">${(not empty sessionScope.utente.nome) && (not empty sessionScope.utente.cognome) ? nominativo : sessionScope.utente.idutente}</div>
							</div>
						</div>
					</div>
				</sec:authorize>
			</div>
		</div>
		<tiles:insertAttribute name="menuFunzioni" />
	</div>
<tiles:insertAttribute name="body" />
<tiles:insertAttribute name="footer" />
</body>