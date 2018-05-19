<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<spring:message code="area.vasta.protocollo.web.msgs.upload.add" var="msgAggiungi"/>
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
		<title>Elenco filiali</title>
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
	<script type="text/x-handlebars-template" id="templateAndamentoFiliale">
    	<div class="nowrap"> 
      		<button class="dettagliCandidato dettaglio btn btn-primary btn-xs" type="button" data-toggle="tooltip" title='Visualizza andamento dati filiale'> 
        		<i class="fa fa-info-circle" aria-hidden="true"></i> 
      		</button>  
		</div>
	</script>
	<script type="text/x-handlebars-template" id="templateSceltaFiliale">
    	<div class="nowrap"> 
			<div class="material-switch pull-left">
        		<input id="someSwitchOptionPrimary{{id}}" data-id-filiale="{{id}}" name="someSwitchOption001{{id}}" type="checkbox" class="selezionaFiliale"/>
            	<label for="someSwitchOptionPrimary{{id}}" class="label-primary"></label>
        	</div> 
		</div>
	</script>	
		<script type="text/javascript" charset="UTF-8">
		var idFilialiSelezionati = [];
		var templateAndamentoFiliale = Handlebars.compile($("#templateAndamentoFiliale").html());
		var templateSceltaFiliale = Handlebars.compile($("#templateSceltaFiliale").html());
		var tabellaFiliali = null;
		
			$(document).ready( function(){
				$("#sezioneGraficoAndamento").hide();
				$("#visualizzaAndamenti").prop("disabled",true);
				$('[data-toggle="tooltip"]').tooltip();
				tabellaFiliali = $("#tabellaFiliali")
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
														return templateAndamentoFiliale(row);
													},
										"sortable" : false,
										"targets" : 2
									}
							]
						});
 					$('#tabellaFiliali tbody').on(
						'click',
						'td button.dettagliCandidato',
						function(evt) {
							evt.preventDefault();									
							var tr = $(this).closest('tr');
							var row = tabellaFiliali.row(tr);
							if(row.data() == undefined){
								var tr = $(this).closest('tr').prev('.parent');
								var row = tabellaFiliali.row(tr);
							}
							var dati = row.data();
							var idCandidato = dati.id;
							
							BootstrapDialog.show({
					            title: 'Andamento filiale',
					            message: function(dialog) {							            	
					                var $message = templateDettaglioCandidato(row.data());
					                return $message;
					            },
					            size: 'size-wide',
					            type: BootstrapDialog.TYPE_INFO,
					            closable: true, 
					            draggable: false,
					            nl2br:false,
					            onshown: function(dialogRef){
					            	
					            }
							});
					            	
						});
 					$("#visualizzaAndamenti").click(function(evt){
 						evt.preventDefault();
 						visualizzaAndamenti(idFilialiSelezionati);
 					});
         	});	
			function visualizzaAndamenti(idFiliali)
			{
				$("#graficoAndamentoFiliale").empty();
				var filiali = new Object();
				filiali.idFiliali = idFiliali;
				$.ajax({
					url : '<spring:url value="/rest/protected/visualizzaAndamenti.json"/>',
					dataType : 'json',
					contentType : 'application/json; charset=UTF-8',
					type : 'POST',
					data: JSON.stringify(filiali),
				    beforeSend : function(){
				    	 $.blockUI({ message: '<p><img src="${urlBusyImg}" />Giusto un momento sto recuperando le informazioni....</p>' });				    	 	
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
				    			  /* events: etichette, */
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
				    				  return y;
				    				  //return new moment(d).format('dd/mm/yy');
				    			  },
				    			  resize:false
				    			});
				    		
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
				       console.log("Selezionato "+$(this).attr("data-id-filiale")); 
				       idFilialiSelezionati.push($(this).attr("data-id-filiale"));
				       console.log(idFilialiSelezionati);
				    } else {
				    	console.log("Deselezionato "+$(this).attr("data-id-filiale"));
				    	idFilialiSelezionati.splice($.inArray($(this).attr("data-id-filiale"), idFilialiSelezionati),1);
				    	console.log(idFilialiSelezionati);
				    }
				    if( idFilialiSelezionati.length === 0 )
				    {
				    	$("#visualizzaAndamenti").prop("disabled",true);
				    }
				    else if( idFilialiSelezionati.length > 0 )
				    {
				    	$("#visualizzaAndamenti").prop("disabled",false);
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
							Seleziona le filiali di cui vuoi vedere gli andamenti e clicca sul pulsante visualizza andamenti
						</div>					
						<table	class="datatables-table table table-striped table-bordered table-hover" id="tabellaFiliali" cellspacing="0"  style="width: 100%;">
							<thead>
								<tr>
									<th title="Seleziona filiale di cui visualizzare l'andamento" alt="Seleziona filiale di cui visualizzare l'andamento">Seleziona Filiali</th>
									<th>Nome filiale</th>
									<th>Azioni</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<button id="visualizzaAndamenti" class="btn btn-primary">
							<strong>Visualizza andamenti</strong>
						</button>
					</div>
					<div class="col-lg-12" id="sezioneGraficoAndamento">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Grafico andamento filiale basato sul totale RE AUTO
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