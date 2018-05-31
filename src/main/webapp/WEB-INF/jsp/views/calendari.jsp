<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<spring:url value="/resources/img/busy.gif" var="urlBusyImg" />
		<title><spring:message code="arca.context.web.msgs.calendari.page.title"/></title>
		<style>
			.accordion.accordion-1 p {font-size: 1rem;}
			.accordion.accordion-1 .card {border: 0;}
			.accordion.accordion-1 .card .card-header {border: 0;}
			.accordion.accordion-1 .card .card-body {line-height: 1.4;}
		</style>
		<script type="text/x-handlebars-template" id="templateElencoIncontri">
			<div class="panel-group" id="accordion">
				{{#each this}}
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#collapse${status.index}"><spring:message code="arca.context.web.msgs.titolo.sezione.tipo.campionato" arguments="{{tipologiaCampionato}}"/> <i class="fa fa-angle-down rotate-icon"></i></a>
							</h4>
						</div>						
						<div id="collapse{{@index}}" class="panel-collapse collapse in">
							<div class="panel-body">
								{{#each incontiByData}}
										<h4 class="h4_calendario"><i class="fa fa-calendar"></i>&nbsp;&nbsp;<strong>{{{formattaMillisencondi @key}}} </strong></h4>
										<hr>
										 <ul class="list-group row">
											{{#each this}}
												<li class="list-group-item col-xs-6">
													{{filialeCasa.nomeFiliale}} VS {{filialeFuoriCasa.nomeFiliale}}
												</li> 
											{{/each}}
 										</ul>
								{{/each}}
							</div>
						</div>
					</div>
				{{/each}}
			</div>
		</script>		
		<script type="text/javascript" charset="UTF-8">
		var templateElencoIncontri = Handlebars.compile($("#templateElencoIncontri").html());
		$(document).ready( function(){
			caricaIncontri();
		});
		Handlebars.registerHelper('formattaMillisencondi', function(millis) {
			  return moment(parseInt(millis)).format("DD/MM/YYYY");
			});
		function caricaIncontri()
		{
			$.ajax({
				url : '<spring:url value="/rest/protected/recuperaIncontri.json"/>',
				dataType : 'json',
				contentType : 'application/json; charset=UTF-8',
				type : 'GET',
			    beforeSend : function(){
			    	$.blockUI({ message: '<spring:message code="arca.context.web.msgs.rest.wait.msg" arguments="${urlBusyImg}" />' });				    	 	
			    },
			    complete   : function(){
				    
			    	$.unblockUI();
			    },
			    success : function(data) {
			    	//Controllo se ci sono risultati
			    	if( data.esitoOperazione === 200 && data.numeroOggettiRestituiti > 0 )
			    	{
			    		var html = templateElencoIncontri(data.payload);
			    		$("#elencoIncontri").html(html);
			    	}
			    },
			    error : function(data) {
			    	
			    }
			});
		}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<!-- /.panel-heading -->
					<div class="panel-body">
						<div class="alert alert-info">
							<spring:message code="arca.context.web.msgs.calendari.info.msg"/>
						</div>

                        <!-- /.panel-heading -->
                        <div class="panel-body" id="elencoIncontri">
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