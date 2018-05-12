<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
<tiles:putAttribute name="head">
<title>Graduatoria Medici - Punteggio</title>
<script type="text/javascript" charset="UTF8">
	// Variabile che memorizza il progressivo calcolo della riga selezionata
	var rs = null;
	var elencoGrad = null;
	$(document).ready(function() {

	/*============ BUTTON UP ===========*/
	var btnUp = $('<div/>', {
		'class' : 'btntoTop'
	});
	btnUp.appendTo('body');
    $(document).on('click', '.btntoTop',function() {
		$('html, body').animate({
						   scrollTop : 0}, 700);
							   });
	$(window).on('scroll', function() {
		if ($(this).scrollTop() > 200)
			$('.btntoTop').addClass('active');
		else
			$('.btntoTop').removeClass('active');
	});
	$('#graduatoriaPunteggio').click(function(){
		var url = Constants.contextPath + "calcPunt/graduatoriaPunteggio";
		$.ajax({
			url : url,
			type : 'GET',
			beforeSend : function() {
				//Mostro il loader
				$.blockUI({
					message : '<h2><img src="'+Constants.contextPath+Constants.loaderImg+'" /></h2>'
				});
			},
			complete : function() {
				//Elimino il blocco della finestra
				$.unblockUI();
			},
			success : function(data) 
			{
				$('#cont').html(data);
			},
			error : function(data) {
			}
		});	
	  });
	$('#graduatoriaAlfabetica').click(function(){
		var url = Constants.contextPath + "calcPunt/graduatoriaAlfabetica";
		$.ajax({
			url : url,
			type : 'GET',
			beforeSend : function() {
				//Mostro il loader
				$.blockUI({
					message : '<h2><img src="'+Constants.contextPath+Constants.loaderImg+'" /></h2>'
				});
			},
			complete : function() {
				//Elimino il blocco della finestra
				$.unblockUI();
			},
			success : function(data) 
			{
				$('#cont').html(data);
			},
			error : function(data) {
			}
		});	
	  });
	 elencoGrad = $("#elencoGrad").DataTable({
					"drawCallback" : function(settings) {
					 $('[data-toggle="tooltip"]').tooltip();
					 },
					"paging": true, 
				    "info": true,
						"bFilter" : false,
						"bSort": false,
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
					"url" : '<spring:url value="/gradPunt/elencoGraduatorie.json" />',
					"dataSrc" : "payload"
							},
					"deferRender" : true,
					"columnDefs" : [{
									  "render" : function(data,type,row) {
												 return '<a href="#" class="cancellazioneGraduatoria" data-toggle="tooltip" title="Cancella graduatoria"><i class="fa fa-times red" aria-hidden="true"></i></a>';
												 },
												 "name" : "",
												 "targets" : 0
												 },
									{
									  "render" : function(data,type,row) {
												 if (!isNaN(row.progCalcolo)) {
												 	return row.progCalcolo;
												 }
												 return "";
												 },
												 "name" : "id.tbgrProgcalc",
												 "targets" : 1,
												 "class" : "dettaglioDomanda",
												 },
									{
									  "render" : function(data,type,row) {
												 if (row.dataCalcolo && row.dataCalcolo !== 0) {
												 	return moment(row.dataCalcolo).format("DD/MM/YYYY");
												 }
												 return "";
												 },
												 "name" : "tbgrDataGrad",
												 "targets" : 2,
												 "class" : "dettaglioDomanda",
												 },
									{
									  "render" : function(data,type,row) {
												 if (row.descrizione && row.descrizione !== "") {
												  	return row.descrizione;
												 }
												 return "";
												 },
												"name" : "tbgrDescr",
												"targets" : 3,
												"class" : "dettaglioDomanda",
									} ]
									});
		$('#calcolaPunteggio').click(function(evt) {
				evt.preventDefault();
				if('${sessionScope.stato}'=="AP"){
					if (rs == null)
						 BootstrapDialog.show({
								title : 'Errore',
								message : function(dialog) {
								var dati = new Object();
								dati.noSelezione = true;
								var $modalBody = templateconfermaCancellazioneGraduatoria(dati);
								return $modalBody;
								},
								size : BootstrapDialog.SIZE_NORMAL,
								type : BootstrapDialog.TYPE_PRIMARY,
								closable : true,
								draggable : false,
								nl2br : false,
								buttons : [
								{
								id : 'annullaConferma',
								label : 'Chiudi',
								action : function(dialogRef) {
									dialogRef.close();
								}
								}]
						});
					else{
						var url = Constants.contextPath + 'gradPunt/calcolaPunteggio/'+rs+'.json';
						$.ajax({
							url : url,
							contentType : 'application/json; charset=UTF-8',
							type : 'POST',
							beforeSend : function() {
								//Mostro il loader
								$.blockUI({
									message : '<h2><img src="'+Constants.contextPath+Constants.loaderImg+'" /></h2>'+
											   'Stiamo processando la richiesta...<br>'
								});
							},
							complete : function() {
								//Elimino il blocco della finestra
								$.unblockUI();
							},
							success : function(data) 
							{
								BootstrapDialog.show({
								title : 'Operazione completata',
								message : 'Calcolo graduatoria effettuato con successo.',
								buttons : [{
								label : 'Chiudi',
								action : function(dialog) {
								dialog.close();
								}
								}]
								});
							},
							error : function(data) {
								mostraErrorePunteggio(data);
							}
						});
					   	}
					}
					if('${sessionScope.stato}'=="CH")
						 BootstrapDialog.show({
								title : 'Cancellazione graduatoria',
								message : function(dialog) {
								var dati = new Object();
								dati.chiuso = true;
								var $modalBody = templateconfermaCancellazioneGraduatoria(dati);
								return $modalBody;
								},
								size : BootstrapDialog.SIZE_NORMAL,
								type : BootstrapDialog.TYPE_PRIMARY,
								closable : true,
								draggable : false,
								nl2br : false,
								buttons : [
								{
								id : 'annullaConferma',
								label : 'Chiudi',
								action : function(dialogRef) {
									dialogRef.close();
								}
								}]
						});
					})
		$('#elencoGrad tbody').on('click','td a.cancellazioneGraduatoria',function(evt) {
					evt.preventDefault();
					var tr = $(this).closest('tr');
					var row = elencoGrad.row(tr);
					var dati = row.data();
					confermaCancellazioneGraduatoria(dati.progCalcolo);
		});
		$('#elencoGrad tbody').on('click','tr .dettaglioDomanda',function() {
				if ($(this).closest('tr').hasClass('selectedRow')) {
					$(this).closest('tr').removeClass('selectedRow');
					rs = null;
				} else {
					elencoGrad.$('tr.selectedRow').removeClass('selectedRow');
					$(this).closest('tr').addClass('selectedRow');
					var tr = $(this).closest('tr');
					var row = elencoGrad.row(tr);
					var obj = row.data();
					rs = obj.progCalcolo;
				}
		});
	$('#addPunt').on('click',function(evt) {
			/* evt.preventDefault();
			var tr = $(this).closest('tr');
			var row = elencoGrad.row(tr); */
			BootstrapDialog.show({
									title : 'Inserimento graduatoria',
									message : function(dialog) {
																 var $modalBody = templateAggiunta();
																 return $modalBody;
																},
									onshow : function(dialog) {
													            $('#formGrad').validator();
															  },
									size : BootstrapDialog.SIZE_NORMAL,
									type : BootstrapDialog.TYPE_PRIMARY,
									closable : true,
									draggable : false,
									nl2br : false,
									buttons : [{
												id : 'addGraduatoria',
												icon : 'fa fa-save',
												label : 'Salva',
												cssClass : 'btn-primary',
												autospin : false,
												action : function(dialogRef) {
														dialogRef.enableButtons(true);
														dialogRef.setClosable(true);
														inserisciGraduatoria(dialogRef);
												}
												},
												{
												id : 'annullaConferma',
												label : 'Annulla',
												cssClass : 'btn-primary',
												icon : 'fa fa-times',
												action : function(dialogRef) {
												dialogRef.close();
												}
												}]
									});
						});
		function confermaCancellazioneGraduatoria(progCalcolo) {
				BootstrapDialog.show({
										title : 'Cancellazione graduatoria',
										message : function(dialog) {
										var dati = new Object();
										dati.progCalcolo = progCalcolo;
										dati.cancella = true;
										var $modalBody = templateconfermaCancellazioneGraduatoria(dati);
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
										cancellaGraduatoria(progCalcolo,dialogRef)
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
		function cancellaGraduatoria(progCalcolo,dialogRef) {
				$.ajax({
							url : '<spring:url value="/gradPunt/cancellaGraduatoria/'+${sessionScope.anno}+'/${sessionScope.tipoGraduatoria}/'+progCalcolo+'.json" />',
							dataType : 'json',
							contentType : 'application/json; charset=UTF-8',
							type : 'DELETE',
							success : function(data) {
									var codiceEsito = data.codiceOperazione;
									if (codiceEsito == 200) {
										dialogRef.setClosable(true);
										dialogRef.getModalFooter().hide();
										var dati = new Object();
										dati.successo = true;
										var htmlDialog = templateconfermaCancellazioneGraduatoria(dati);
										dialogRef.getModalBody().html(htmlDialog);
										//Ricarico la tabella aggiornata
										if (elencoGrad != null) {
											elencoGrad.ajax.reload();
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
				//dialogRef.setType(BootstrapDialog.TYPE_DANGER);
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				dati.errori = true;
				var htmlDialog = templateconfermaCancellazioneGraduatoria(dati);
				dialogRef.getModalBody().html(htmlDialog);
				}
		});
  function inserisciGraduatoria(dialog) {
		// Controllo sui campi obbligatori
		if($('#formGrad').validator('validate').has('.has-error').length > 0 ){
			return;
		}
		var datiGrad = new Object();
		datiGrad.descrizione = $('#descrizione').val();
		datiGrad.dataCalcolo = $('#dataCalcolo').val();
		$.ajax({
					url : '<spring:url value="/gradPunt/addGraduatoria.json" />',
					dataType : 'json',
					type : 'POST',
					data : JSON.stringify(datiGrad),
					contentType : 'application/json; charset=UTF-8',
					success : function(data) {
						elencoGrad.ajax.reload();
						dialog.close();
					},
					error : function(data) {
						mostraErroreInserimento(dialog);
					}
			});
	}
  function mostraErrorePunteggio(data){
	  var txt = data.responseJSON.payload.split(";");
	  BootstrapDialog.show({
			title : 'Cancellazione graduatoria',
			message : function(dialog) {
			var dati = new Object();
			dati.irregolare = true;
			dati.messaggio = txt[2];
			var $modalBody = templateconfermaCancellazioneGraduatoria(dati);
			return $modalBody;
			},
			size : BootstrapDialog.SIZE_NORMAL,
			type : BootstrapDialog.TYPE_PRIMARY,
			closable : true,
			draggable : false,
			nl2br : false,
			buttons : [
			{
			id : 'annullaConferma',
			label : 'Chiudi',
			action : function(dialogRef) {
				dialogRef.close();
			}
			}]
	});
  }
</script>
<script type="text/x-handlebars-template" id="templateconfermaCancellazioneGraduatoria">
{{#if cancella}}
<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
Confermi di voler cancellare la graduatoria associata al progressivo <strong>{{progCalcolo}}</strong>
dell'anno <strong>${sessionScope.anno}</strong>?<br/><br/>
<strong>Attenzione!</strong> L'operazione non è annullabile
</div>
{{else if successo}}
<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
Cancellazione graduatoria terminata con successo
</div>
{{else if irregolare}}
<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i> {{messaggio}}
</div>
{{else if chiuso}}
<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i> Impossibile effettuare il calcolo. Il concorso selezionato non &egrave; aperto.
</div>
{{else if noSelezione}}
<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i> Impossibile effettuare il calcolo. Nessun concorso &egrave; stato selezionato. Si prega
di selezionare una riga dalla tabella  e riprovare.
</div>
{{/if}}
</script>
<script type="text/x-handlebars-template" id="templateAggiuntaGraduatoria">
<div class="row">
<form name="formGrad" id="formGrad">
<div class="form-group col-md-4">
<label>Anno (*)</label> 
<div>
<input value="${sessionScope.anno}" class="form-control" type="text" readonly /> 
</div>
</div>
<div class="form-group col-md-4">
<label>Tipo (*)</label> 
<div>
<input value="${sessionScope.tipoGraduatoria}" class="form-control" type="text" readonly /> 
</div>
</div>
<div class="form-group col-md-4">
<label for="dataCalcolo" class="control-label">Data calcolo (*)</label> 
<div class="input-group date datepicker_dataCalcolo" id="dataCalcolo">
<input id="dataCalcolo" name="data" class="form-control"
readonly="readonly" type="text" value="" /> <span
class="input-group-addon"> <span
class="glyphicon glyphicon-calendar"></span>
</span>
</div>
</div>
<div class="form-group col-md-12">
<textarea rows="4" cols="50" id="descrizione" required="true"
class="form-control" placeholder="Inserisci la descrizione" />
</div>
</form>
<script>
$(function() {
		$(".datepicker_dataCalcolo").datetimepicker({
			format : "DD/MM/YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			maxDate : 'now',
			minDate : 'now',
		});
	});
</script>
<script>
var templateconfermaCancellazioneGraduatoria = Handlebars.compile($("#templateconfermaCancellazioneGraduatoria").html());
var templateAggiunta = Handlebars.compile($("#templateAggiuntaGraduatoria").html());
</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">
		<div class="sfondo_body">
			<div class="container">
				<div class="row margin20">
					<div class="form-group col-md-1">
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
							<div class="form-group col-md-3">
								<label for="tipo_esteso" class="control-label">Tipo
									grad.</label> <input type="text" class="form-control height40"
									id="tipo_esteso" readonly value="Graduatoria medici pediatri"
									required>
							</div>
						</c:otherwise>
					</c:choose>
					<div class="form-group col-md-1">
						<label for="stato" class="control-label">Stato grad.</label> <input
							type="text" class="form-control height40" id="stato" readonly
							value="${sessionScope.stato}">
					</div>
					<div class="form-group col-md-2">
						<label for="utente" class="control-label">Utente</label> <input
							type="text" class="form-control height40" id="utente" readonly
							value="${utente}">
					</div>
					<div class="form-group col-md-2">
						<label for="codiceFunzione" class="control-label">Codice
							funzione</label> <input type="text" class="form-control height40"
							id="codiceFunzione" readonly value="F_GRAD01">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body panel_min_height home_news">
									<table
										class="datatables-table table table-striped table-bordered table-hover"
										id="elencoGrad">
										<thead>
											<tr>
												<th id="addPunt" class="dettaglioDomanda"><i class="fa fa-plus"  aria-hidden="true"
												style="color: green;"></i>
												</th>
												<th>Progressivo</th>
												<th>Data calcolo</th>
												<th>Descrizione</th>
											</tr>
										</thead>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="row" style="margin-bottom: 30px;">
						<div class="col-md-6 col-md-offset-3">
							<button type="button"
								class="btn btn-default btn-large button_salva"
								id="calcolaPunteggio">Calcola punteggi</button>
							<button type="button"
								class="btn btn-default btn-large button_salva" id="graduatoriaAlfabetica">Graduatoria
								alfabetica</button>
							<button type="button"
								class="btn btn-default btn-large button_salva" id="graduatoriaPunteggio">Graduatoria
								per punteggio</button>
						</div>
					</div>
				</div>
			</div>
			<div class="container" id="cont">
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>