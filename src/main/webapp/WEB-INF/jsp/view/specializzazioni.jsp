<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
<tiles:putAttribute name="head">
<title>Graduatoria Medici - Stato graduatorie</title>
<script type="text/x-handlebars-template" id="templateCancellazioneSpec">
{{#if errori}}
<div id="erroreCancellazioneContainer" class="alert alert-danger">
	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
	È avvenuto un errore durante la cancellazione della specializzazione
	<br/>
	Ti preghiamo di riprovare più tardi.
</div>
{{else if successo}}
<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
	<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
	Cancellazione specializzazione terminata con successo
</div>
{{else if conferma}}
<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
	Confermi di voler cancellare la specializzazione con codice <strong> {{codice}}</strong> ?
	<br/><br/>
	<strong>Attenzione!</strong> L'operazione non è annullabile
</div>
{{else}}
<div id="erroreCancellazioneContainer" class="alert alert-danger">
	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
	Impossibile cancellare la specializzazione. Vi sono titoli ad essa associati.
</div>
{{/if}}
</script>
<script type="text/x-handlebars-template" id="templateModificaSpec">
{{#if success}}
<script type="text/javascript">
$(document).ready(function(){
	$('#descrizioneModal').html(descrizioneModal);
	$('#codiceSpec').val(codiceModal);
 });
<{{!}}/script>
<form id="form_spec" role="form">
<div class="form-group col-md-3">
	<label for="titolo" class="control-label"> Cod. spec. (*)</label>
	<input id="codiceSpec" name="codiceSpec" class="form-control" readonly required="true" type="text" />
</div>
</div>
<div class="form-group">
	<textarea id="descrizioneModal" name="descrizione" class="form-control" rows="3" cols="50" required="true"/>
</div>
{{else}}
<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
	<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
	Aggiornamento specializzazione avvenuto con successo
</div>
</form>
{{/if}}
</script>
<script type="text/x-handlebars-template" id="templateAggiungiSpec">
{{#if successo}}
<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
	<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
	Inserimento specializzazione avvenuta con successo.
</div>
{{else if errori}}
<div id="erroreCancellazioneContainer" class="alert alert-danger">
	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
	È avvenuto un errore durante l'inserimento della specializzazione.
	<br/>
	Ti preghiamo di riprovare più tardi.
</div>
{{else}}
<div class="row">
<form name="aggSpec">
	<div class="alert alert-warning">
	<strong>Attenzione!</strong> Stai aggiungendo una specializzazione al titolo <strong>{{titolo}}</strong>
</div>
<div class="form-group col-md-2">
	<label >Codice (*)</label> 
	<div>
		<input id="codiceSpecializzazione" name="codiceSpecializzazione" class="form-control" type="text" required="true"/> 
	</div>
</div>
<div class="form-group col-md-10">
	<label >Descrizione (*)</label> 
		<div>
			<textarea id="insertDescrizione" name="insertDescrizione" class="form-control" rows="4" required="true"></textarea> 
		</div>
</div>
</div>
</div>
{{/if}}
</script>
		<script type="text/javascript" charset="UTF8">
		var elencoSpecDt = null;
		var codiceModal = null;
		var descrizioneModal = null;
		var templateCancellazioneSpec = Handlebars.compile($("#templateCancellazioneSpec").html());
		var templateModificaSpec = Handlebars.compile($("#templateModificaSpec").html());
		var templateAggiungiSpec = Handlebars.compile($("#templateAggiungiSpec").html());
		$(document).ready(function() {
			$('.selectpicker').selectpicker();
				// Fisso in alto navigation
				(function() {
					$(".datepicker_data").datetimepicker({
						format : "DD/MM/YYYY",
						showClose : true,
						locale : 'it',
						showClear : true,
						ignoreReadonly : true,
					});
					$('#codice').change(function(evt){
						evt.preventDefault();
						
						$('#descrizione').val($('#codice').find(":selected").data("descrizione"));
						var codTitolo = $('#codice').val();
						if(codTitolo !=="")
						{
							$('#specializzazione').css('display','block');
							elencoSpecDt = $("#elencoSpec").DataTable(
							{
								"drawCallback": function( settings ) {
									  $('[data-toggle="tooltip"]').tooltip();
								},
								"destroy": true,
								"searching": false,
								"processing" : true,
								"serverSide" : true,
								"mark" : true,
								"responsive" : false,
								"pageLength" : '${numeroMassimoRecord}',
								"language" : {
								"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'
								},
								"ajax" : {
								"url" : '<spring:url value="/table/elencoSpec/'+codTitolo+'.json" />',
								"dataSrc" : "payload"
								},
								"deferRender" : true,
								"columnDefs" : [
								{
								"render" : function(data, type,row) {
									if (row.codice && row.codice !== 0) {
										return row.codice;
									}
									return "";
									},
								"name" : "codice",
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
									return '<a href="#" class="cancellaSpec" data-toggle="tooltip" title="Cancella"><i class="fa fa-times red" aria-hidden="true"></i></a>'
									+ '&nbsp;<a href="#" class="modificaSpec" data-toggle="tooltip" title="Modifica"><i class="fa fa-refresh green" aria-hidden="true"></i></a>'
								},
								"name" : "tbtgDescabb",
								"targets" : 2
								}]
							});
						}
						else
						{
							$('#specializzazione').css('display','none');
						}
				})
				$('#elencoSpec tbody').on('click','td a.cancellaSpec',function(evt) {
					evt.preventDefault();
					var tr = $(this).closest('tr');
					var row = elencoSpecDt.row(tr);
					var datiSpec = row.data();
					confermaCancellazioneSpec(datiSpec);
				});
				$('#elencoSpec tbody').on('click','td a.modificaSpec',function(evt) {
					evt.preventDefault();
					var tr = $(this).closest('tr');
					var row = elencoSpecDt.row(tr);
					var datiSpec = row.data();
					modificaSpec(datiSpec.codice,datiSpec.descrizione);
				});
				function modificaSpec(codice,descrizione){
					BootstrapDialog.show({
						title : 'Modifica specializzazione',
						message : function(dialog) {
							codiceModal = codice;
							descrizioneModal = descrizione;
							var dati = new Object();
							dati.success = true;
							var $modalBody = templateModificaSpec(dati);
							return $modalBody;
						},
						onshown: function(dialog){
							$('#form_spec').validator();
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
									obj.codiceTitolo = $('#codice').val();
									obj.codice = codice;
									obj.descrizione = $('#descrizioneModal').val();
									confermaModificaSpec(obj, dialogRef);
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
				function confermaModificaSpec(obj, dialogRef) {
					if($('#form_spec').validator('validate').has('.has-error').length > 0 ){
	        			return;
	        		}
					$.ajax({
								type: 'POST',
								url : '<spring:url value="/table/modificaSpec.json" />',
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
										var htmlDialog = templateModificaSpec(dati);
										dialogRef.getModalBody().html(htmlDialog);
										//Ricarico la tabella aggiornata
										if (elencoSpecDt != null) {
											elencoSpecDt.ajax.reload();
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
				function confermaCancellazioneSpec(obj) {
					BootstrapDialog.show({
							title : 'Cancellazione specializzazione',
							message : function(dialog) {
								var datiSpec = new Object();
								datiSpec.conferma = true;
								datiSpec.codice = obj.codice;
								var $modalBody = templateCancellazioneSpec(datiSpec);
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
									autospin : false,
									action : function(dialogRef) {
										dialogRef.enableButtons(false);
										dialogRef.setClosable(false);
										var codiceTitolo = $('#codice').val();
										cancellaSpec(obj.codice, codiceTitolo, dialogRef);
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
				function cancellaSpec(codice, codiceTitolo, dialogRef) {
					$.ajax({
								url : '<spring:url value="/table/cancellaSpec/'+codice+'/'+codiceTitolo+'.json" />',
								dataType : 'json',
								contentType : 'application/json; charset=UTF-8',
								type : 'DELETE',
								type : 'DELETE',
								statusCode: {
									403: function (response){
										dialogRef.setClosable(true);
										dialogRef.getModalFooter().hide();
										var dati = new Object();
										dati.nonCancellabile = true;
										var htmlDialog = templateCancellazioneSpec(dati);
										dialogRef.getModalBody().html(htmlDialog);
									}
								},
								success : function(data) {
									var codiceEsito = data.codiceOperazione;
									if (codiceEsito == 200) {
										dialogRef.setClosable(true);
										dialogRef.getModalFooter().hide();
										var dati = new Object();
										dati.successo = true;
										var htmlDialog = templateCancellazioneSpec(dati);
										dialogRef.getModalBody().html(htmlDialog);
										//Ricarico la tabella aggiornata
										if (elencoSpecDt != null) {
											elencoSpecDt.ajax.reload();
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
				})();

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
				$('#specializzazione').click(function(){
					BootstrapDialog.show({
						title : 'Aggiungi specializzazione',
						message : function(dialog) {
							var dati = new Object();
							dati.titolo = $('#codice').val();
							var $modalBody = templateAggiungiSpec(dati);
							return $modalBody;
						},
						size : 'size-wide',
						type : BootstrapDialog.TYPE_PRIMARY,
						closable : true,
						draggable : false,
						nl2br : false,
						/* onshow: function(dialog) {
							dialog.getButton('conferma').disable();
						}, */
					 	onshown: function(dialogRef){
							 $('form[name="aggSpec"]').validator();
							 /*  input, select, textarea, .datepicker_periodoDal, .datepicker_periodoAl').on('keyup change dp.change',function(){
								if($('#insertDescrizione').val() !=="" && $('#codiceSpecializzazione').val() !=="")
							    {
							    	dialogRef.getButton('conferma').enable();
							    }
							    else
							    {
							    	dialogRef.getButton('conferma').disable();
							    }
							});  */
					        },  
						buttons : [{
								id : 'conferma',
								icon : 'fa fa-save',
								label : 'Salva',
								cssClass : 'btn-primary',
								autospin : false,
								action : function(dialogRef) {
									dialogRef.enableButtons(true);
									dialogRef.setClosable(true);
									var obj = new Object();
									obj.titolo = $('#codice').val();
									obj.spec = $('#codiceSpecializzazione').val();
									obj.descrizione = $('#insertDescrizione').val();
									salvaSpec(obj, dialogRef);
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
				});
			});
		</script>
		<script type="text/javascript" charset="UTF8">
			
			function reloadTabella() {
				if (elencoStatiDt && elencoStatiDt != null) {
					var baseUrl = '<spring:url value="/table/elencoStatiGrad.json" />';
					var filtri = new Object();
					if ($("#annoGrad").val() !== "") {
						filtri.anno = $("#annoGrad").val();
					}
					if($('#codice').val() !==""){
						filtri.codice = $('#codice').val();
					}
					if($('#statoGrad').val() !==""){
						filtri.stato = $('#statoGrad').val();
					}
					if (baseUrl.indexOf('?') > -1) {
						baseUrl += '&';
					} else {
						baseUrl += '?';
					}
					baseUrl += $.param(filtri);
					elencoStatiDt.ajax.url(baseUrl).load();
				}
			}
			function mostraErroreCancellazione(dialogRef) {
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				dati.errori = true;
				var htmlDialog = templateCancellazioneSpec(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
			function mostraErroreSalva(dialogRef) {
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				dati.errori = true;
				var htmlDialog = templateAggiungiSpec(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
			function salvaSpec(obj, dialogRef) {
				if($('form[name="aggSpec"]').validator('validate').has('.has-error').length > 0 ){
        			return;
        		}
				$.ajax({
							url : '<spring:url value="/table/salvaSpec.json" />',
							dataType : 'json',
							type: 'POST',
							contentType : 'application/json; charset=UTF-8',
							data :  JSON.stringify(obj),
							success : function(data) {
								var codiceEsito = data.codiceOperazione;
								if (codiceEsito == 200) {
									dialogRef.setClosable(true);
									dialogRef.getModalFooter().hide();
									var dati = new Object();
									dati.successo = true;
									var htmlDialog = templateAggiungiSpec(dati);
									dialogRef.getModalBody().html(htmlDialog);
									//Ricarico la tabella aggiornata
									if (elencoSpecDt != null) {
										elencoSpecDt.ajax.reload();
									}
								} else if (codiceEsito == 500) {
									mostraErroreSalva(dialogRef);
								}
							},
							error : function(data) {
								mostraErroreSalva(dialogRef);
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
							id="codiceFunzione" readonly value="F_SPECYR">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body home_news">
								<h2 class="align_center">Tabella specializzazioni per anno</h2>
									<!-- FORM RICERCA -->
									<form role="form" id="form_ricerca_stati">
										<!-- CODICE TITOLO -->
										<div class="form-group col-md-2">
										<select class="form-control selectpicker" id="codice" data-live-search="true">
											<option value="">Seleziona</option>
											 <c:forEach items = "${listaTitoli}"  var = "item">
         										<option value="${item.codice}" data-descrizione="${item.descrizione}">${item.codice}</option>
     										 </c:forEach>
										</select>
										</div>
										<!-- DESCRIZIONE -->
										<div class="form-group col-md-10">
											<textarea class="form-control" id="descrizione" rows="2" cols="50" readonly></textarea>
										</div>
										<div class="form-group col-md-5 margin10">
										<button type="button" class="btn btn-default btn-large button_salva" data-toogle="tooltip" 
										style="display:none;" title="Crea specializzazione per il titolo selezionato"
										id="specializzazione"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Nuova</button>
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
									<table id="elencoSpec"
										class="datatables-table table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Codice</th>
												<th>Specializzazione / Attestato</th>
												<th></th>
											</tr>
										</thead>
										<tr>
											<td colspan="5" align="center">Nessun dato presente</td>
										</tr>
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