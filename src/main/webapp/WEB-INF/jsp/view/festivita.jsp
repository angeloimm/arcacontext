<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Graduatoria Medici - Festività</title>
		<script type="text/x-handlebars-template" id="templateCancellazioneFestivita">
			{{#if errori}}
				<div id="erroreCancellazioneContainer" class="alert alert-danger">
					<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
					È avvenuto un errore durante la cancellazione della della festivit&agrave;
					<br/>
					Ti preghiamo di riprovare più tardi.
				</div>
			{{else if successo}}
				<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
					<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
					Cancellazione festivit&agrave; terminata con successo
				</div>
			{{else}}
				<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
					Confermi di voler cancellare la festivit&agrave; con descrizione <strong>{{descrizione}}</strong>
                	e data <strong>{{data}}</strong>?
                	<br/><br/>
                	<strong>Attenzione!</strong> Con questa operazione potr&agrave; variare il punteggio calcolato
				</div>
			{{/if}}
		</script>
			<script type="text/x-handlebars-template" id="templateModificaFest">
			{{#if update}}
						<div class="row">
<form method="POST" id="form_statoGrad">
   <div class="form-group col-md-4">
      <label for="dataFest" class="control-label">Data (*)</label> 
      <div class="input-group date datepicker_fest disabled" name="dataFest">
         <input id="dataFest" name="data" class="form-control"
           type="text" name="al" required="true" readonly="true" /> 
		   <span  class="input-group-addon"> <span
           class="glyphicon glyphicon-calendar"></span>
         </span>
      </div>
   </div>
 <div class="form-group col-md-8">
      <label for="descrizioneModal" class="control-label">Descrizione (*)</label>
      <input type="text" class="form-control"
         id="descrizioneModal"  required="true" maxlength="50" data-error="Inserire non più di 50 caratteri"/>
   </div>
</form>
			{{else}}
				<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
					<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
					Aggiornamento festivit&agrave; avvenuto con successo
				</div>
			{{/if}}
		</script>
		<script type="text/x-handlebars-template" id="templateFestivita">
			{{#if insert}}
				<div class="row">
<form method="POST" id="form_statoGrad">
   <div class="form-group col-md-4">
      <label for="dataFest" class="control-label">Data (*)</label> 
      <div class="input-group date datepicker_fest" name="dataFest">
         <input id="dataFest" name="data" class="form-control"
            required="true" type="text" name="al" 
			pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}"/>
 			<span class="input-group-addon"> <span
            class="glyphicon glyphicon-calendar"></span>
         </span>
      </div>
   </div>
 <div class="form-group col-md-8">
      <label for="descrizioneModal" class="control-label">Descrizione (*)</label>
      <input type="text" class="form-control"
         id="descrizioneModal"  required="true" maxlength="50" data-error="Inserire non più di 50 caratteri"/>
   </div>
<div class="align_center red" id="error" style="display:none;">
<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
&nbsp; I campi contrassegnati dall'asterisco sono obbligatori
</div>
</form>
<script type="text/javascript">
$(function(){
$(".datepicker_fest").datetimepicker({
			format : "DD/MM/YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			ignoreReadonly : true,
		});
});
{{else if insertSuccess}}
		<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
		Inserimento festivit&agrave; avvenuto con successo
		</div>
{{else}}
<div id="erroreCancellazioneContainer" class="alert alert-danger">
					<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
					È avvenuto un errore durante l'inserimento della festivit&agrave;
					<br/>
					Ti preghiamo di riprovare più tardi.
				</div>
		{{/if}}
		</script>
		<script type="text/javascript" charset="UTF8">
			var elencoFestivitaDt = null;
			var descrizioneModal = null;
			var dataModal = null;
			var templateCancellazioneFestivita = Handlebars.compile($("#templateCancellazioneFestivita").html());
			var templateFestivita = Handlebars.compile($("#templateFestivita").html());
			var templateModificaFest = Handlebars.compile($('#templateModificaFest').html());
			$(function() {
				//Inizializzo il datepicker
				$(".datepicker_data").datetimepicker({
					format : "DD/MM/YYYY",
					showClose : true,
					locale : 'it',
					showClear : true,
					ignoreReadonly : true,
				});
				/*============ BUTTON UP ===========*/
				var btnUp = $('<div/>', {
					'class' : 'btntoTop'
				});
				btnUp.appendTo('body');
				$(document).on('click', '.btntoTop', function() {
					$('html, body').animate({
						scrollTop : 0
					}, 700);
				});
				$(window).on('scroll', function() {
					if ($(this).scrollTop() > 200)
						$('.btntoTop').addClass('active');
					else
						$('.btntoTop').removeClass('active');
				});
				$("#ricercaFestivita").click(function(evt) {
					//Prevengo il propagarsi dell'evento
					evt.preventDefault();
					reloadTabella();
				});
				elencoFestivitaDt = $("#elencoFestivita").DataTable(
								{
									"drawCallback" : function(settings) {
										$('[data-toggle="tooltip"]').tooltip();
									},
									"processing" : true,
									"serverSide" : true,
									"searching" : true,
									"mark" : true,
									"responsive" : true,
									"pageLength" : '${numeroMassimoRecord}',
									"language" : {
										"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'
									},
									"ajax" : {
										"url" : '<spring:url value="/festivita/elencoFestivita.json" />',
										"dataSrc" : "payload"
									},
									"deferRender" : true,
									"columnDefs" : [
											{
												"render" : function(data, type,row) {
													if (row.data
															&& row.data !== 0) {
														return moment(row.data).format("DD/MM/YYYY");
													}
													return "";
												},
												"name" : "data",
												"targets" : 0
											},
											{
												"render" : function(data, type,row) {
													if (row.descrizione && row.descrizione !== "") {
														return row.descrizione;
													}
													return "";
												},
												"name" : "descrizione",
												"targets" : 1
											},
											{
												"render" : function(data, type,row) {
													return '<a href="#" class="cancellaFest" data-toggle="tooltip" title="Cancella"><i class="fa fa-times red" aria-hidden="true"></i></a>'
															+ '&nbsp;<a href="#" class="modificaFest" data-toggle="tooltip" title="Modifica"><i class="fa fa-refresh green" aria-hidden="true"></i></a>'

												},
												"name" : "",
												"orderable" : false,
												"targets" : 2
											} ]
								});
				$('#elencoFestivita tbody').on('click','td a.cancellaFest',function(evt) {
						evt.preventDefault();
						var tr = $(this).closest('tr');
						var row = elencoFestivitaDt.row(tr);
						var dati = row.data();
						confermaCancellazioneFestivita(dati.data,dati.descrizione);
				});
				$('#elencoFestivita tbody').on('click','td a.modificaFest',function(evt) {
					evt.preventDefault();
					var tr = $(this).closest('tr');
					var row = elencoFestivitaDt.row(tr);
					var dati = row.data();
					confermaModificaFest(dati.data,dati.descrizione);
			});
				$('#nuovaFestivita').click(function(evt){
					evt.preventDefault();
					BootstrapDialog.show({
						title : 'Inserimento festivit&agrave;',
						message : function(dialog) {
							var dati = new Object();
							dati.insert = true;
							var $modalBody = templateFestivita(dati);
							return $modalBody;
						},
						onshow: function(){
							$('#form_statoGrad').validator();
						},
						size : BootstrapDialog.NORMAL,
						type : BootstrapDialog.TYPE_PRIMARY,
						closable : true,
						draggable : false,
						nl2br : false,
						buttons : [ {
							id : 'conferma',
							icon : 'fa fa-save',
							label : 'Salva',
							cssClass : 'btn-primary',
							autospin : false,
							action : function(dialogRef) {
								dialogRef.enableButtons(true);
								dialogRef.setClosable(true);
								var obj = new Object();
								obj.descrizione = $('#descrizioneModal').val();
								obj.data = new Date(formatDate($('#dataFest').val()));
								salvaFestivita(obj, dialogRef);

							}
						}, {
							id : 'annullaConferma',
							label : 'Annulla',
							action : function(dialogRef) {
								dialogRef.close();
							}
						} ]
					});
				});
				function confermaModificaFest(data, descrizione){
					BootstrapDialog.show({
						title : 'Modifica festivit&agrave;',
						message : function(dialog) {
							var dati = new Object();
							dati.update = true;
							descrizioneModal = descrizione;
							dataModal = data;
							var $modalBody = templateModificaFest(dati);
							return $modalBody;
						},
						onshow: function(){
							$('#form_statoGrad').validator();
						},
						onshown: function(){
							$('#descrizioneModal').val(descrizioneModal);
							$(".datepicker_fest").datetimepicker({
										format : "DD/MM/YYYY",
										showClose : true,
										locale : 'it',
										showClear : true,
										ignoreReadonly : true,
										defaultDate : dataModal,
									});
						},
						size : BootstrapDialog.NORMAL,
						type : BootstrapDialog.TYPE_PRIMARY,
						closable : true,
						draggable : false,
						nl2br : false,
						buttons : [{
								id : 'conferma',
								icon : 'fa fa-check',
								label : 'Modifica',
								cssClass : 'btn-primary',
								autospin : false,
								action : function(dialogRef) {
									dialogRef.enableButtons(true);
									dialogRef.setClosable(true);
									var obj = new Object();
									obj.data = data;
									obj.descrizione = $('#descrizioneModal').val();
									modificaFest(obj, dialogRef);
								}
								}, 
								{
								id : 'annullaConferma',
								label : 'Annulla',
								action : function(dialogRef) {
								dialogRef.close();
								}
								} ]
				});
				}
				function confermaCancellazioneFestivita(data, descrizione){
					BootstrapDialog.show({
						title : 'Cancellazione festivit&agrave;',
						message : function(dialog) {
							var dati = new Object();
							dati.data = moment(data).format("DD/MM/YYYY");
							dati.descrizione = descrizione;
							var $modalBody = templateCancellazioneFestivita(dati);
							return $modalBody;
						},
						size : 'size-wide',
						type : BootstrapDialog.TYPE_PRIMARY,
						closable : true,
						draggable : false,
						nl2br : false,
						buttons : [{
									id : 'conferma',
									icon : 'fa fa-trash-o',
									label : 'Conferma',
									cssClass : 'btn-warning',
									autospin : true,
									action : function(dialogRef) {
										dialogRef.enableButtons(false);
										dialogRef.setClosable(false);
										cancellaFestivita(data,descrizione, dialogRef);
									}
									},
									{
									id : 'annullaConferma',
									label : 'Annulla',
									action : function(dialogRef) {
										dialogRef.close();
									}
								}]
					});
				}
			});
			function modificaFest(obj, dialogRef) {
				// Controllo sui campi obbligatori
            	if($('#form_statoGrad').validator('validate').has('.has-error').length > 0 ){
            		$('#error').css('display','block');
        			return;
        		}
				$.ajax({
							type: 'POST',
							url : '<spring:url value="/festivita/modificaFest.json" />',
							dataType : 'json',
							data: JSON.stringify(obj),
							contentType : 'application/json; charset=UTF-8',
							success : function(data) {
								var codiceEsito = data.codiceOperazione;
								if (codiceEsito == 200) {
									//dialogRef.setType(BootstrapDialog.TYPE_SUCCESS);
									dialogRef.setClosable(true);
									dialogRef.getModalFooter().hide();
									var dati = new Object();
									dati.updateSuccess = true;
									var htmlDialog = templateModificaFest(dati);
									dialogRef.getModalBody().html(htmlDialog);
									//Ricarico la tabella aggiornata
									if (elencoFestivitaDt != null) {
										elencoFestivitaDt.ajax.reload();
									}
								} else if (codiceEsito == 500) {
									mostraErroreCancellazione(dialogRef);
								}
							},
							error : function(data) {
								mostraErroreCancellazione(dialogRef);
							}
						});
			}
			function cancellaFestivita(data, descrizione,dialogRef){
				var data = {
						"data": data,
						"descrizione" : descrizione
				}
				$.ajax({
							url : '<spring:url value="/festivita/cancellaFest.json" />',
							type : 'POST',
							dataType : 'json',
							data: JSON.stringify(data),
							contentType : 'application/json; charset=UTF-8',
							success : function(data) {
								var codiceEsito = data.codiceOperazione;
								if (codiceEsito == 200) {
									dialogRef.setClosable(true);
									dialogRef.getModalFooter().hide();
									var dati = new Object();
									dati.successo = true;
									var htmlDialog = templateCancellazioneFestivita(dati);
									dialogRef.getModalBody().html(htmlDialog);
									//Ricarico la tabella aggiornata
									if (elencoFestivitaDt != null) {
										elencoFestivitaDt.ajax.reload();
									}
								} else if (codiceEsito == 500) {
									mostraErroreCancellazione(dialogRef);
								}
							},
							error : function(data) {
								mostraErroreCancellazione(dialogRef);
							}
						});
			}
			function mostraErroreCancellazione(dialogRef) {
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				dati.errori = true;
				var htmlDialog = templateCancellazioneFestivita(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
			function mostraErroreInserimento(dialogRef) {
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				var htmlDialog = templateFestivita(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
			function reloadTabella() {
				if (elencoFestivitaDt && elencoFestivitaDt != null) {
					var baseUrl = '<spring:url value="/festivita/elencoFestivita.json" />';
					var filtri = new Object();
					if ($("#data").val() !== "") {
						filtri.data = $("#data").val();
					}
					if ($("#descrizione").val() !== "") {
						filtri.descrizione = $("#descrizione").val();
					}
					if (baseUrl.indexOf('?') > -1) {
						baseUrl += '&';
					} else {
						baseUrl += '?';
					}
					baseUrl += $.param(filtri);
					elencoFestivitaDt.ajax.url(baseUrl).load();
				}
			}
			function salvaFestivita(obj, dialogRef) {
				//Controllo sui campi obbligatori
				if($('#form_statoGrad').validator('validate').has('.has-error').length > 0 ){
            		$('#error').css('display','block');
        			return;
        		}
				$.ajax({
					url : '<spring:url value="/festivita/salvaFestivita.json" />',
					type : 'POST',
					dataType : 'json',
					data: JSON.stringify(obj),
					contentType : 'application/json; charset=UTF-8',
					success : function(data) {
						var codiceEsito = data.codiceOperazione;
						if (codiceEsito == 200) {
							dialogRef.setClosable(true);
							dialogRef.getModalFooter().hide();
							var dati = new Object();
							dati.insertSuccess = true;
							var htmlDialog = templateFestivita(dati);
							dialogRef.getModalBody().html(htmlDialog);
							//Ricarico la tabella aggiornata
							if (elencoFestivitaDt != null) {
								elencoFestivitaDt.ajax.reload();
							}
						} else if (codiceEsito == 500) {
							mostraErroreInserimento(dialogRef);
						}
					},
					error : function(data) {
						mostraErroreInserimento(dialogRef);
					}
				});
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">

		<div class="sfondo_body">
			<div class="container">
				<div class="row margin20">
					<div class="form-group col-md-2">
						<label for="anno" class="control-label">Anno</label> <input
							type="text" class="form-control height40" id="anno" readonly
							value="${sessionScope.anno}">
					</div>
					<div class="form-group col-md-1">
						<label for="tipo" class="control-label">Tipo grad.</label> <input
							type="text" class="form-control height40" id="tipo" readonly
							value="${sessionScope.tipoGraduatoria}">
					</div>
					<c:choose>
						<c:when test="${sessionScope.tipoGraduatoria=='MG'}">
							<div class="form-group col-md-3">
								<label for="tipo_esteso" class="control-label">Tipo
									grad.</label> <input type="text" class="form-control height40"
									id="tipo_esteso" readonly value="Graduatoria medici generici">
							</div>
						</c:when>
						<c:otherwise>
							<div class="form-group col-md-2">
								<label for="tipo_esteso" class="control-label">Tipo
									grad.</label> <input type="text" class="form-control height40"
									id="tipo_esteso" readonly value="Graduatoria pediatri" required>
							</div>
						</c:otherwise>
					</c:choose>
					<div class="form-group col-md-1">
						<label for="stato" class="control-label">Stato grad.</label> <input
							type="text" class="form-control height40" id="stato" readonly
							value="AP">
					</div>
					<div class="form-group col-md-2">
						<label for="utente" class="control-label">Utente</label> <input
							type="text" class="form-control height40" id="utente" readonly
							value="${utente}">
					</div>
					<div class="form-group col-md-2">
						<label for="codiceFunzione" class="control-label">Codice
							funzione</label> <input type="text" class="form-control height40"
							id="codiceFunzione" readonly value="F_FESTE">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body home_news">
									<!-- FORM RICERCA -->
									<form role="form">
										<!-- ANNO -->
										<div class="row">
											<div class="form-group col-md-3">
												<label for="data" class="control-label">Data</label>
												<div class="input-group date datepicker_data"
													id="dataNascitaDiv">
													<input id="data" name="data" class="form-control"
														readonly="readonly" type="text" value="" /> <span
														class="input-group-addon"> <span
														class="glyphicon glyphicon-calendar"></span>
													</span>
												</div>
											</div>
											<!-- CODICE -->
											<div class="form-group col-md-5">
												<label for="descrizione" class="control-label">Descrizione
												</label> <input type="text" class="form-control" id="descrizione">
											</div>
										</div>
										<div class="form-group col-md-5 margin10">
											<button type="submit" id="ricercaFestivita"
												class="btn btn-default btn-large button_salva">
												<i class="fa fa-search" aria-hidden="true"></i>&nbsp;Ricerca
											</button>
											<button type="submit" id="nuovaFestivita"
												class="btn btn-default btn-large button_nuovo">
												<i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Nuovo
											</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body panel_min_height home_news">
									<table id="elencoFestivita"
										class="datatables-table table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Data</th>
												<th>Descrizione</th>
												<th></th>
											</tr>
										</thead>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>