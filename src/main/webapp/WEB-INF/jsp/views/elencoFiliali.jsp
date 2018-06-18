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
	<style>
		.material-switch > input[type="checkbox"] {display: none;}
		.material-switch > label {cursor: pointer;height: 0px;position: relative;width: 40px;}
		.material-switch > label::before {background: rgb(0, 0, 0);box-shadow: inset 0px 0px 10px rgba(0, 0, 0, 0.5);border-radius: 8px;content: '';height: 16px;margin-top: -8px;position:absolute;opacity: 0.3;transition: all 0.4s ease-in-out;width: 40px;}
		.material-switch > label::after {background: rgb(255, 255, 255);border-radius: 16px;box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.3);content: '';height: 24px;left: -4px;margin-top: -8px;position: absolute;top: -4px;transition: all 0.3s ease-in-out;width: 24px;}
		.material-switch > input[type="checkbox"]:checked + label::before {background: inherit;opacity: 0.5;}
		.material-switch > input[type="checkbox"]:checked + label::after {background: inherit;left: 20px;}	
	</style>
		<spring:url value="/resources/img/busy.gif" var="urlBusyImg" />
		<title><spring:message code="arca.context.web.msgs.elenco.filiali.page.title"/></title>
		<!-- DataTables CSS -->
		<link
			href="<spring:url value="/adminWebTheme/vendor/datatables-plugins/dataTables.bootstrap.css" />"
			rel="stylesheet">
		<!-- DataTables Responsive CSS -->
		<link
			href="<spring:url value="/adminWebTheme/vendor/datatables-responsive/dataTables.responsive.css" />"
			rel="stylesheet">
		<!-- DataTables JavaScript -->
		<script
			src="<spring:url value="/adminWebTheme/vendor/datatables/js/jquery.dataTables.min.js" />"></script>
		<script
			src="<spring:url value="/adminWebTheme/vendor/datatables-plugins/dataTables.bootstrap.min.js" />"></script>
		<script
			src="<spring:url value="/adminWebTheme/vendor/datatables-responsive/dataTables.responsive.js" />"></script>
	<script type="text/x-handlebars-template" id="templateAzioniFiliale">
    	<div class="nowrap"> 
      		<button class="dettagliFiliale dettaglio btn btn-primary btn-xs" type="button" data-toggle="tooltip" title='<spring:message code="arca.context.web.msgs.visualizza.info.dati.filiale.title" />'> 
        		<i class="fa fa-info-circle" aria-hidden="true"></i> 
      		</button>
			{{!--
				<button class="cancellazioneFiliale dettaglio btn btn-danger btn-xs" type="button" data-toggle="tooltip" title="<spring:message code="arca.context.web.msgs.cancella.filiale.title" />">
					<i class="fa fa-trash-o" aria-hidden="true"></i>
				</button>
			--}}
		</div>
	</script>
	<script type="text/x-handlebars-template" id="templateSceltaFiliale">
    	<div class="nowrap"> 
			<div class="material-switch pull-left">
        		<input id="someSwitchOptionPrimary{{id}}" data-id-filiale="{{id}}" data-nome-filiale="{{nomeFiliale}}" name="someSwitchOption001{{id}}" type="checkbox" class="selezionaFiliale" {{#if selezionato}} checked {{/if}} />
            	<label for="someSwitchOptionPrimary{{id}}" class="label-primary"></label>
        	</div> 
		</div>
	</script>
	<script type="text/x-handlebars-template" id="templateFilialeSelezionata">
			<span class="label label-info" id="label_{{idFiliale}}">{{nomeFiliale}}</span> 
	</script>	
	<script type="text/x-handlebars-template" id="templateDettagliFiliale">
    	<div class="alert alert-info">
			Dati filiale <strong>{{nomeFiliale}}</strong>
		</div>					
		<table	class="datatables-table table table-striped table-bordered table-hover" id="tabellaDatiFiliali" cellspacing="0"  style="width: 100%;">
			<thead>
				<tr>
					<th><spring:message code="arca.context.web.msgs.visualizza.info.dati.filiale.table.th.data" /></th>
					<th><spring:message code="arca.context.web.msgs.visualizza.info.dati.filiale.table.th.re" /></th>
					<th><spring:message code="arca.context.web.msgs.visualizza.info.dati.filiale.table.th.auto" /></th>
					<th><spring:message code="arca.context.web.msgs.visualizza.info.dati.filiale.table.th.totale" /></th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</script>
	<script type="text/x-handlebars-template" id="templateCancellazioneFiliale">
    	<div class="alert alert-danger">
			<spring:message code="arca.context.web.msgs.cancellazione.filiale.panel.title" />
		</div>
		<div class="nowrap"> 
      		<button class="dettaglio btn btn-danger" type="button"> 0
        		<i class="fa fa-trash-o" aria-hidden="true"></i><spring:message code="arca.context.web.msgs.cancellazione.filiale.btn.msg" /> 
      		</button>
			<button class="dettaglio btn btn-default" type="button"> 
        		<i class="fa fa-times-circle-o" aria-hidden="true"></i><spring:message code="arca.context.web.msgs.annulla.cancellazione.filiale.btn.msg" /> 
      		</button>  
		</div>		
	</script>
	<script type="text/x-handlebars-template" id="templateCreazioneCampionato">
    	<div class="alert alert-info">
			 <i class="fa fa-info-circle"></i>&nbsp;${creaCampionatoMsg}
		</div>
		<div class="alert alert-warning">
			<i class="fa fa-warning"></i>&nbsp;<spring:message code="arca.context.web.msgs.creazione.campionato.alert.info" arguments="${produzioneMinima}, ${numeroFilialiCampionato}" />
		</div>
		<div class="container">
			<div class="col-md-8">
				<div class="form-group"> 
					<label for="dal"><spring:message code="arca.context.web.msgs.creazione.campionato.from" /></label>
        			<div class='input-group date' id='dataFrom'>
            			<input type='text' id="dal" class="form-control" />
                		<span class="input-group-addon">
                			<span class="glyphicon glyphicon-calendar"></span>
                		</span>
        			</div>
				</div>
			</div>
			{{!--
			<div class="col-md-4">
				<div class="form-group"> 
        			<label for="al"><spring:message code="arca.context.web.msgs.creazione.campionato.to" /></label>
					<div class='input-group date' id='dataTo'>
            			<input type='text' id="al" class="form-control" />
                		<span class="input-group-addon">
                			<span class="glyphicon glyphicon-calendar"></span>
                		</span>
        			</div>
				</div>
			</div>
			--}}
		</div>	
		<div class="container">
			<div class="col-md-4">
				<div class="form-group"> 
					<label for="produzioneMinima"><spring:message code="arca.context.web.msgs.creazione.campionato.produzione.minima" /></label>
        			<div class='input-group date' id='dataFrom'>
            			<input type='number' id="produzioneMinima" value="${produzioneMinima}" class="form-control" />
                		<span class="input-group-addon">
                			<span class="fa fa-euro"></span>
                		</span>
        			</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group"> 
        			<label for="numeroSquadre"><spring:message code="arca.context.web.msgs.creazione.campionato.numero.squadre" /></label>
					<div class='input-group date' id='dataTo'>
            			<input type='number' id="numeroSquadre" value="${numeroFilialiCampionato}" class="form-control" />
                		<span class="input-group-addon">
                			<span class="fa fa-flag-checkered"></span>
                		</span>
        			</div>
				</div>
			</div>
		</div>
	</div>
		<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_SUPER_ADMIN')">	
			<div class="nowrap"> 
      			<button class="dettaglio btn btn-primary" id="creaCampionatoBtn" type="button">
        			<span class="bootstrap-dialog-button-icon glyphicon glyphicon-send" id="spinner"></span><spring:message code="arca.context.web.msgs.creazione.campionato.btn.msg" /> 
      			</button>
				<button class="dettaglio btn btn-default" id="chiudiCreazioneCampionatoBtn" type="button"> 
					<spring:message code="arca.context.web.msgs.annulla.cancellazione.filiale.btn.msg" /> 
      			</button>
			</div>
			<div class="alert alert-success hide margin_t_10" id="divCampionatoOk">
				<spring:message	code="arca.context.web.msgs.campionato.ok"/>
			</div>
			<div class="alert alert-danger hide margin_t_10" id="divCampionatoKo">
				<spring:message	code="arca.context.web.msgs.campionato.ko" />
			</div>
		</security:authorize>
	</script>	
		<script type="text/javascript" charset="UTF-8">
		var svuotaGrafico = false;
		var dataFineMs = 0;
		var dataInizioMs = 0;
		var idFilialiSelezionati = [];
		var templateFilialeSelezionata = Handlebars.compile($("#templateFilialeSelezionata").html());
		var templateAzioniFiliale = Handlebars.compile($("#templateAzioniFiliale").html());
		var templateSceltaFiliale = Handlebars.compile($("#templateSceltaFiliale").html());
		var templateDettagliFiliale = Handlebars.compile($("#templateDettagliFiliale").html());
		var templateCancellazioneFiliale = Handlebars.compile($("#templateCancellazioneFiliale").html());
		var templateCreazioneCampionato = Handlebars.compile($("#templateCreazioneCampionato").html());
		var tabellaFiliali = null;
		var campionatiAttivi = ${campionatiAttivi};
		var creazioneCampionato = ${creazioneCampionato};
			$(document).ready( function(){
				$("#divFilialiSelezionate").hide();
				$("#testoFilialiSelezionate").hide();
				if( campionatiAttivi )
				{
					$("#creazioneCampionato").prop("disabled",true);
				}
				$("#sezioneGraficoAndamento").hide();
				$("#visualizzaAndamenti").prop("disabled",true);
				$("#creazioneCampionato").click( function(evt){
					evt.preventDefault();
					creazioneCampionatoFunction();
				} );
				if( creazioneCampionato === false )
				{
					$("#creazioneCampionato").prop("disabled",true);
				}
				$('[data-toggle="tooltip"]').tooltip();
				tabellaFiliali = $("#tabellaFiliali")
				.DataTable(
						{
							"processing" : true,
							"serverSide" : true,
							"searching" : true,
							"responsive" : true,
							"pagingType": "full_numbers",
							"ordering":false,
							"mark"      : true,
							"language" : {
								"url" : '<spring:url value="/adminWebTheme/vendor/datatables/i18n/Italian.lang"/>'
							},
							"drawCallback": function( settings ) {
								$('[data-toggle="tooltip"]').tooltip();
								handleCheckboxSelection();
							},									
							"ajax" : {
								"url" : '<spring:url value="/rest/protected/elencoFiliali.json" />',
								"dataSrc" : "payload"
							},
							"deferRender" : true,
							"columnDefs" : 
							[
								{
									"render" : 	function(data, type, row) 
												{
													if( $.inArray(row.id, idFilialiSelezionati)>-1 )
													{
														row.selezionato = true;
													}
													return templateSceltaFiliale(row);
												},
									
									"targets" : 0
								},								
								{
									"render" : 	function(data, type, row) 
												{
													if (row.nomeFiliale && row.nomeFiliale !== "") 
													{
														return row.nomeFiliale;
													}
													return "-";
												},
									"name" : "nomeFiliale",
									"sortable" : false,
									"targets" : 1
								},			
									{
										"render" : 	function(data, type, row) 
													{
														return templateAzioniFiliale(row);
													},
										"sortable" : false,
										"targets" : 2
									}
							]
						});
				$('#tabellaFiliali tbody').on(
						'click',
						'td button.cancellazioneFiliale',
						function(evt) {
							evt.preventDefault();									
							var tr = $(this).closest('tr');
							var row = tabellaFiliali.row(tr);
							if(row.data() == undefined){
								var tr = $(this).closest('tr').prev('.parent');
								var row = tabellaFiliali.row(tr);
							}
							var dati = row.data();
							var idFiliale = dati.id;
							
							BootstrapDialog.show({
					            title: 'Cancellazione filiale',
					            message: function(dialog) {							            	
					                var $message = templateCancellazioneFiliale(row.data());
					                return $message;
					            },
					            size: 'size-wide',
					            type: BootstrapDialog.TYPE_DANGER,
					            closable: true, 
					            draggable: false,
					            nl2br:false,
					            onshown: function(dialogRef){
					            	recuperaDatiFiliale(idFiliale);
					            }
							});
					            	
						});				
 					$('#tabellaFiliali tbody').on(
						'click',
						'td button.dettagliFiliale',
						function(evt) {
							evt.preventDefault();									
							var tr = $(this).closest('tr');
							var row = tabellaFiliali.row(tr);
							if(row.data() == undefined){
								var tr = $(this).closest('tr').prev('.parent');
								var row = tabellaFiliali.row(tr);
							}
							var dati = row.data();
							var idFiliale = dati.id;
							
							BootstrapDialog.show({
					            title: 'Dati filiale',
					            message: function(dialog) {							            	
					                var $message = templateDettagliFiliale(row.data());
					                return $message;
					            },
					            size: 'size-wide',
					            type: BootstrapDialog.TYPE_INFO,
					            closable: true, 
					            draggable: false,
					            nl2br:false,
					            onshown: function(dialogRef){
					            	recuperaDatiFiliale(idFiliale);
					            }
							});
					            	
						});
 					$("#visualizzaAndamenti").click(function(evt){
 						evt.preventDefault();
 						visualizzaAndamenti(idFilialiSelezionati);
 					});
         	});	
			
			function recuperaDatiFiliale(idFiliale)
			{
				$("#tabellaDatiFiliali")
				.DataTable(
						{
							"processing" : true,
							"serverSide" : true,
							"searching" : false,
							"responsive" : true,
							"pagingType": "full_numbers",
							"ordering":false,
							"mark"      : true,
							"language" : {
								"url" : '<spring:url value="/adminWebTheme/vendor/datatables/i18n/Italian.lang"/>'
							},
							"drawCallback": function( settings ) {
								$('[data-toggle="tooltip"]').tooltip();
							},									
							"ajax" : {
								"url" : '<spring:url value="/rest/protected/dettagliFiliale.json" />',
								"dataSrc" : "payload",
								"data":{
									
									"idFiliale":idFiliale
								}
							},
							"deferRender" : true,
							"columnDefs" : 
							[
								{
									"render" : 	function(data, type, row) 
												{
													if (row.dataDatiLong && row.dataDatiLong !== 0) 
													{
														return new moment(row.dataDatiLong).format('DD/MM/YYYY');
													}
													return "-";
												},
									"name" : "dataDatiLong",
									"sortable" : false,
									"targets" : 0
								},			
								{
									"render" : 	function(data, type, row) 
												{
													
													return row.re;
												},
									"sortable" : false,
									"name":"re",
									"targets" : 1
								},
								{
									"render" : 	function(data, type, row) 
												{
												
													return row.auto;
												},
									"sortable" : false,
									"name":"auto",
									"targets" : 2
								},
								{
									"render" : 	function(data, type, row) 
												{
								
													return row.totaleReAuto;
												},
									"sortable" : false,
									"name":"totaleReAuto",
									"targets" : 3
								}								
							]
						});
			}
			function visualizzaAndamenti(idFiliali)
			{
				if( svuotaGrafico === true )
		    	{
		    		$("#graficoAndamentoFiliale").empty();
		    	}
				var filiali = new Object();
				filiali.idFiliali = idFiliali;
				$.ajax({
					url : '<spring:url value="/rest/protected/visualizzaAndamenti.json"/>',
					dataType : 'json',
					contentType : 'application/json; charset=UTF-8',
					type : 'POST',
					data: JSON.stringify(filiali),
				    beforeSend : function(){
				    	$.blockUI({ message: '<spring:message code="arca.context.web.msgs.rest.wait.msg" arguments="${urlBusyImg}" />' });				    	 	
				    },
				    complete   : function(){
					    
				    	$.unblockUI();
				    	$("#sezioneGraficoAndamento").show();
				    },
				    success : function(data) {
				    	//Controllo se ci sono risultati
				    	if( data.esitoOperazione === 200 && data.numeroOggettiRestituiti > 0 )
				    	{
				    		var datiGrafico = data.payload[0];
				    		var etichette = datiGrafico.etichette;
				    		var yKeys = datiGrafico.yaxesKeys;
				    		var dati = datiGrafico.data;
				    		Morris.Line({
				    			  element: 'graficoAndamentoFiliale',
				    			  data: dati,
				    			  ymin:0,
				    			  xkey: 'dataDati',
				    			  ykeys: yKeys,
				    			  labels: yKeys,
				    			  xLabelAngle: 45,
				    			  dateFormat: function(data){
				    				  return new moment(data).format('DD/MM/YYYY');
				    			  },
				    			  xLabels: "week",
				    			  xLabelFormat: function(d){
				    				  
				    				  return moment(d).format('DD/MM/YYYY');
				    			  },
				    			  yLabelFormat: function(y){
				    				  return y.toFixed(2);
				    				  //return new moment(d).format('dd/mm/yy');
				    			  },
				    			  resize:true
				    			});
				    		svuotaGrafico = true;
				    	}
				    },
				    error : function(data) {
				    	
				    }
				});
			}
			function handleCheckboxSelection()
			{
				$('.material-switch :checkbox').change(function() {
				    // this will contain a reference to the checkbox   
				    if (this.checked) {
				       idFilialiSelezionati.push($(this).attr("data-id-filiale"));
				       var dati = new Object();
				       dati.nomeFiliale = $(this).attr("data-nome-filiale");
				       dati.idFiliale = $(this).attr("data-id-filiale");
				       $("#divFilialiSelezionate").append(templateFilialeSelezionata(dati));
				       $("#divFilialiSelezionate").show();
				       $("#testoFilialiSelezionate").show();
				    } else {
				    	
				    	var idFiliale = $(this).attr("data-id-filiale");
				    	var indice = $.inArray(idFiliale, idFilialiSelezionati);
				    	idFilialiSelezionati.splice(indice,1);
				    	if( indice > -1 )
				    	{
				    		$("#label_"+idFiliale).remove();	
				    	}
				    }
				    if( idFilialiSelezionati.length === 0 )
				    {
				    	$("#visualizzaAndamenti").prop("disabled",true);
				    	$("#divFilialiSelezionate").empty();
				    	$("#divFilialiSelezionate").hide();
				    	$("#testoFilialiSelezionate").hide();
				    }
				    else if( idFilialiSelezionati.length > 0 )
				    {
				    	$("#visualizzaAndamenti").prop("disabled",false);
				    }
				});
			}
			function creazioneCampionatoFunction()
			{
				BootstrapDialog.show({
		            title: 'Creazione campionato filiali',
		            message: function(dialog) {							            	
		                var $message = templateCreazioneCampionato();
		                return $message;
		            },
		            size: 'size-wide',
		            type: BootstrapDialog.TYPE_INFO,
		            closable: true, 
		            draggable: false,
		            nl2br:false,
		            onshown: function(dialogRef){
		            	 creaDateTimePickers();
		            	 $("#chiudiCreazioneCampionatoBtn").click(function(evt){
		            		 evt.preventDefault();
		            		 dialogRef.close();
		            	 });
		            	 $("#creaCampionatoBtn").click(function(evt){
		            		 evt.preventDefault();
		            		 creaNuovoCampionato();
		            	 });
		            },
		            onhidden:function(dialogRef){
		            	location.reload();
		            } 
				});
			}
			function creaDateTimePickers(){
				
				$('#dal').datetimepicker({
                    locale: 'it',
                    date : new Date(${dataMinimaCampionato}),
                    /*minDate: new Date(${dataMinimaCampionato}),*/
                    keepInvalid: true,
                    format:'L'
                });
/*            	 	$('#al').datetimepicker({
                    locale: 'it',
                    useCurrent: false,
                    keepInvalid: true,
                    format:'L'
                });
           	 	$('#al').data("DateTimePicker").disable(); */
/*            	 	$("#dal").on("dp.change", function (e) {
           		 	var data = e.date;
                    $('#al').data("DateTimePicker").minDate(data);
                    $('#al').data("DateTimePicker").date(data);
                    $('#al').data("DateTimePicker").enable();
                }); */
			}
			
			function creaNuovoCampionato()
			{
				var datiCampionato = new Object();
				datiCampionato.dataInizio =  $('#dal').data('DateTimePicker').date().valueOf();
				/* datiCampionato.dataFine = $('#al').data('DateTimePicker').date().valueOf(); */
				datiCampionato.produzioneMinima = $("#produzioneMinima").val();
				datiCampionato.numeroSquadre = $("#numeroSquadre").val();
				$.ajax({
					url : '<spring:url value="/rest/protected/creazioneCampionato.json"/>',
					dataType : 'json',
					contentType : 'application/json; charset=UTF-8',
					type : 'POST',
					data: JSON.stringify(datiCampionato),
				    beforeSend : function(){
				    	$("#spinner").toggleClass("bootstrap-dialog-button-icon glyphicon glyphicon-asterisk icon-spin");
				    	$("#spinner").toggleClass("bootstrap-dialog-button-icon glyphicon glyphicon-send");
				    	$("#creaCampionatoBtn").prop("disabled",true);
				    },
				    complete   : function(){
					    
				    	$("#spinner").toggleClass("bootstrap-dialog-button-icon glyphicon glyphicon-asterisk icon-spin");
				    	$("#spinner").toggleClass("bootstrap-dialog-button-icon glyphicon glyphicon-send");
				    	/* $("#creaCampionatoBtn").prop("disabled",false); */
				    },
				    success : function(data) {
				    	//Controllo se ci sono risultati
				    	if( data.esitoOperazione === 200 && data.numeroOggettiRestituiti > 0 )
				    	{
				    		$("#creaCampionatoBtn").prop("disabled",true);
				    		$("#divCampionatoOk").removeClass("hide");
				    		$("#divCampionatoKo").addClass("hide");
				    	}
				    	else
				    	{
				    		$("#creaCampionatoBtn").prop("disabled",false);
				    		$("#divCampionatoOk").addClass("hide");
				    		$("#divCampionatoKo").removeClass("hide");
				    	}
				    },
				    error : function(data) {
				    	$("#creaCampionatoBtn").prop("disabled",false);
			    		$("#divCampionatoOk").addClass("hide");
			    		$("#divCampionatoKo").removeClass("hide");
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
						<i class="fa fa-info-circle"></i>&nbsp; <spring:message code="arca.context.web.msgs.elenco.filiali.info.msg" arguments="${msgVediAndamenti}"/>
							<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_SUPER_ADMIN')">
								<br />
								<i class="fa fa-info-circle"></i>&nbsp; <spring:message code="arca.context.web.msgs.creazione.campionato.info.msg" arguments="${msgCreazioneCampionatoBtn}"/>
							</security:authorize>
						</div>
						<c:if test="${campionatiAttivi}">
							<div class="alert alert-warning">
								<i class="fa fa-warning"></i>&nbsp;<spring:message code="arca.context.web.msgs.creazione.esiste.campionato.attivo.alert.title.msg"/>
							</div>
						</c:if>
						<table	class="datatables-table table table-striped table-bordered table-hover" id="tabellaFiliali" cellspacing="0"  style="width: 100%;">
							<thead>
								<tr>
									<th title="<spring:message code="arca.context.web.msgs.seleziona.filiale.title.msg"/>" alt="<spring:message code="arca.context.web.msgs.seleziona.filiale.title.msg"/>"><spring:message code="arca.context.web.msgs.seleziona.filiale.msg"/></th>
									<th><spring:message code="arca.context.web.msgs.seleziona.filiale.nome"/></th>
									<th><spring:message code="arca.context.web.msgs.seleziona.filiale.azioni"/></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<div class="nowrap margin_b_10">
							<p id="testoFilialiSelezionate" class="text-info">
								<strong><spring:message code="arca.context.web.msgs.filiali.selezionate" text="Filiali selezionate"/></strong>
							</p>
							<div id="divFilialiSelezionate">
							
							</div>
						</div>
						<div class="nowrap">
							<button id="visualizzaAndamenti" class="btn btn-primary">
								<strong>${msgVediAndamenti}</strong>
							</button>
							<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_SUPER_ADMIN')">
								<button id="creazioneCampionato" class="btn btn-primary">
									<strong>${msgCreazioneCampionatoBtn}</strong>
								</button>
							</security:authorize>
						</div>
					</div>
					<div class="col-lg-12" id="sezioneGraficoAndamento">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i><spring:message code="arca.context.web.msgs.titolo.sezione.grafico.andamenti"/>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<div id="graficoAndamentoFiliale"></div>
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