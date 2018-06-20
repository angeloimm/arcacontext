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
								<a data-toggle="collapse" data-parent="#accordion" href="#collapse{{@index}}"><spring:message code="arca.context.web.msgs.titolo.sezione.tipo.campionato" arguments="{{tipologiaCampionato}}"/> <i class="fa fa-angle-down rotate-icon"></i></a>
							</h4>
						</div>						
						<div id="collapse{{@index}}" class="panel-collapse collapse {{{mostraCollapseIn @index}}} ">
							<div class="panel-body">
								<ul class="list-group">
									{{#each incontiByData}}
										<li class="list-group-item col-xs-6">
										<h4 class="h4_calendario"><i class="fa fa-calendar"></i>&nbsp;&nbsp;<strong>{{{recuperaSettimanaRiferimento @key this}}} </strong></h4>
										<hr>
										 <ul class="list-group ul_calendari" id="elencoCalendariUl">
											{{#each this}}
												<li class="list-group-item ">
													<span><button type="button" class="btn {{{btnType @index}}} nessunaAction f_left" style="font-size: small;">{{filialeCasa.nomeFiliale}} <span class="badge">{{risultatoCasa}}</span> €</button></span>
													<span><button type="button" class="btn {{{btnType @index}}} nessunaAction f_right" style="font-size: small;">{{filialeFuoriCasa.nomeFiliale}} <span class="badge">{{risultatoFuoriCasa}}</span> €</button></span>
													<div class="clearfix"></div>
												</li> 
											{{/each}}
 										</ul>
										</li>

									{{/each}}
								</ul>
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
			
			Handlebars.registerHelper('btnType', function(indice) {
				var isPari = (indice%2==0);
				console.log("Indice "+indice+" pari? "+isPari);
				if( isPari === true )
				{
					return "btn-primary";
				}
				else
				{
					return "btn-info";
				}
			});
			Handlebars.registerHelper('formattaMillisencondi', function(millis) {
			  return moment(parseInt(millis)).format("DD/MM/YYYY");
			});
			Handlebars.registerHelper('recuperaSettimanaRiferimento', function(millis, object) {
				  var inizioSettimana = moment(object[0].inizioSettimana);
				  var fineSettimana = moment(object[0].fineSettimana);
				  var giornoInizioSettimana = inizioSettimana.date();
				  var giornoFineSettimana = fineSettimana.date();
				  var mese = inizioSettimana.format('MMMM');
				  return giornoInizioSettimana+' - '+giornoFineSettimana+' '+mese;
				});			
			Handlebars.registerHelper('mostraCollapseIn', function(value) {
				var result = (value == 0);
				if( result === true )
				{
					return "in";
				}
				return "";
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
			    			$(".nessunaAction").click(function(evt){
			    				evt.preventDefault();
			    			});
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
							<i class="fa fa-info-circle"></i>&nbsp; <spring:message code="arca.context.web.msgs.calendari.info.msg"/>
						</div>
<%-- 						<div class="alert alert-warning">
							<spring:message code="arca.context.web.msgs.calendari.warning.msg"/>
						</div> --%>
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