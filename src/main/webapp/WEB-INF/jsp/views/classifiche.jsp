<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<spring:message code="arca.context.web.msgs.visualizza.andamenti.filiale.button" var="msgVediAndamenti"/>
<spring:message code="arca.context.web.msgs.crea.campionato.button" var="msgCreazioneCampionatoBtn"/>
<spring:message code="arca.context.web.msgs.upload.add" var="msgAggiungi"/>
<spring:message code="arca.context.web.msgs.creazione.campionato.alert.title.msg" arguments="${dataCampionatoString}" var="creaCampionatoMsg"/>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<spring:url value="/resources/img/busy.gif" var="urlBusyImg" />
		<title><spring:message code="arca.context.web.msgs.classifiche.page.title"/></title>
		<style>
			.accordion.accordion-1 p {font-size: 1rem;}
			.accordion.accordion-1 .card {border: 0;}
			.accordion.accordion-1 .card .card-header {border: 0;}
			.accordion.accordion-1 .card .card-body {line-height: 1.4;}
		</style>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<!-- /.panel-heading -->
					<div class="panel-body">
						<div class="alert alert-info">
							<spring:message code="arca.context.web.msgs.classifiche.info.msg"/>
						</div>

                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<c:choose>
                        		<c:when test="${not empty classifiche}">
                        			<div class="panel-group" id="accordion">
                        				<c:forEach items="${classifiche}" var="classifica" varStatus="status">
                        					<c:choose>
                        						<c:when test="${status.index eq 0 }">
                        							<c:set var="cssMostra" value="in"/>
                        						</c:when>
                        						<c:otherwise>
                        							<c:set var="cssMostra" value=""/>
                        						</c:otherwise>
                        					</c:choose>
                        					<div class="panel panel-default">
            									<div class="panel-heading">
                									<h4 class="panel-title">
                    									<a data-toggle="collapse" data-parent="#accordion" href="#collapse${status.index}"><spring:message code="arca.context.web.msgs.titolo.sezione.tipo.campionato" arguments="${classifica.tipoCampionato}"/> <i class="fa fa-angle-down rotate-icon"></i></a>
                									</h4>
            									</div>
            									<div id="collapse${status.index}" class="panel-collapse collapse ${cssMostra}">
                									<div class="panel-body">
										                <ul class="list-group">
										                	<c:forEach var="filiale" items="${classifica.filaliCampionato}">
										                		<li class="list-group-item">${filiale.nomeFiliale}<span class="badge">${filiale.puntiFiliale}</span></li>
										                	</c:forEach>
										                </ul>
                									</div>
            									</div>
        									</div>
                        				</c:forEach>
                        			</div>
                        		</c:when>
                        		<c:otherwise>
                        			<spring:message code="arca.context.web.msgs.titolo.sezione.no.classifica.campionato"/>
                        		</c:otherwise>
                        	</c:choose>
						</div>
					<div>
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>