<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Graduatoria Medici - Stato graduatorie</title>
		<script type="text/x-handlebars-template"
			id="templateConfermaCambioStato">
{{#if conferma}}
<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
	Confermi di voler modificare lo stato della graduatoria dell'anno <strong>{{anno}}</strong>, tipo <strong>{{tipo}}</strong>?
</div>
<br>
<small>Lo stato attuale è: {{stato}}</small>
{{else if errori}}
<div id="erroreCancellazioneContainer" class="alert alert-danger">
	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
	È avvenuto un errore durante l'aggiornamento della domanda.
	<br/>
	Ti preghiamo di riprovare più tardi.
</div>
{{else if successo}}
<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
	<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
	Aggiornamento stato graduatoria effettuato con successo
</div>
{{/if}}
</script>
<script type="text/x-handlebars-template" id="templateCancellaStato">
{{#if conferma}}
<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
	Confermi di voler cancellare lo stato della graduatoria dell'anno <strong>{{anno}}</strong>, tipo <strong>{{tipo}}</strong>?
</div>
<br>
<small>Lo stato attuale è: {{stato}}</small>
{{else if errori}}
<div id="erroreCancellazioneContainer" class="alert alert-danger">
	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
	È avvenuto un errore durante la cancellazione.
	<br/>
	Ti preghiamo di riprovare più tardi.
</div>
{{else if successo}}
<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
	<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
	Cancellazione stato graduatoria effettuato con successo
</div>
{{/if}}
</script>
<script type="text/x-handlebars-template" id="templateStatoGraduatoria">
{{#if insert}}
	<div class="row">
<form method="POST" id="form_statoGrad">
   <div class="form-group col-md-6">
      <label for="annoModal" class="control-label"> Anno (*)</label>
      <div class="input-group date datepicker_anno">
         <input id="annoModal" name="annoModal" class="form-control" required="true"
            readonly="readonly" type="text" value="${sessionScope.anno}" /> <span
            class="input-group-addon"> <span
            class="glyphicon glyphicon-calendar"></span>
         </span>
      </div>
   </div>
   <div class="form-group col-md-6">
      <label for="tipoGrad" class="control-label">Tipo graduatoria (*)</label>
      <select id="tipoGrad"  class="form-control" required="true">
	  <option value="MG">MG</option>
	  <option value="PD">PD</option>
	  </select>
   </div>
 <div class="form-group col-md-6">
      <label for="codice" class="control-label">Descrizione (*)</label>
	<input type="text" class="form-control disabled" value="Graduatoria medici generici"
     id="descrizioneGrad" required="true" maxlength="50" data-error="Inserire non più di 50 caratteri"/>
   </div>
   <div class="form-group col-md-6">
      <label for="codiceTitolo" class="control-label">Codice (*)</label>
      <input type="text" class="form-control" readonly
         id="codiceStatoModal" required="true" value ="AP"/>
   </div>
   <div class="form-group col-md-6">
      <label for="codice" class="control-label">Data scadenza (*)</label> 
      <div class="input-group date datepicker_scadenza" id="dataNascitaDiv">
         <input id="dataScadenzaModal" name="data" class="form-control"
            readonly="readonly" type="text" value="" /> <span
            class="input-group-addon"> <span
            class="glyphicon glyphicon-calendar"></span>
         </span>
      </div>
   </div>
   <div class="form-group col-md-6" id="divDal">
      <label for="codice" class="control-label">Data validità (*)</label> 
      <div class="input-group date datepicker_validita" name="dataNascitaDiv">
         <input id="dataValiditaModal" name="data" class="form-control"
            readonly="readonly" type="text" name="al"/> <span
            class="input-group-addon"> <span
            class="glyphicon glyphicon-calendar"></span>
         </span>
      </div>
   </div>
</form>
<script>
$(function() {
	var yearScadenza = ${sessionScope.anno-1};
	var yearValidita = ${sessionScope.anno-2};
	var defaultScadenza = "12/31/" + yearScadenza;
	var defaultValidita = "12/31/" + yearValidita;

		$(".datepicker_anno").datetimepicker({
			format: "YYYY",
        	showClose: true,
        	locale: 'it',
        	showClear:true,
        	ignoreReadonly:true,
		}).on('dp.change', function (selected) {
				var d = new Date(selected.date.valueOf());
				var yearScadenza = d.getFullYear()-1;
				var yearValidita = d.getFullYear()-2;
				var dataScadenza = "12/31/" + yearScadenza;
				var dataValidita = "12/31/" + yearValidita;
				$('.datepicker_scadenza').datetimepicker('date', new Date(dataScadenza));
				$('.datepicker_validita').datetimepicker('date', new Date(dataValidita));
		});
		$(".datepicker_scadenza").datetimepicker({
			format : "DD/MM/YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			ignoreReadonly : true,
			defaultDate: defaultScadenza,
		});
		$(".datepicker_validita").datetimepicker({
			format : "DD/MM/YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			ignoreReadonly : true,
			defaultDate : defaultValidita,
		});
	$('#tipoGrad').change(function(){
		var tipo=$('#tipoGrad').val();
		if(tipo=='MG')
			$('#descrizioneGrad').val('Graduatoria medici generici');
		else
			$('#descrizioneGrad').val('Graduatoria medici pediatri');
	});
});
{{else if insertSuccess}}
<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
					<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
					Inserimento stato graduatoria effettuato con successo
				</div>
{{else if errori}}
<div id="erroreCancellazioneContainer" class="alert alert-danger">
	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
	È avvenuto un errore durante l'inserimento dello stato graduatoria
	<br/>
	Ti preghiamo di riprovare più tardi.
</div>
{{/if}}
</script>
		<script type="text/javascript" charset="UTF8">
			var templateConfermaCambioStato = Handlebars.compile($(
					"#templateConfermaCambioStato").html());
			var templateCancellaStato = Handlebars.compile($(
					"#templateCancellaStato").html());
			var templateStatoGraduatoria = Handlebars.compile($(
					"#templateStatoGraduatoria").html());
			var elencoStatiDt = null;
			$(function() {
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
				$("#ricercaStati").click(function(evt) {
					//Prevengo il propagarsi dell'evento
					evt.preventDefault();
					reloadTabella();
				});
				elencoStatiDt = $("#elencoStati")
						.DataTable(
								{
									"drawCallback" : function(settings) {
										$('[data-toggle="tooltip"]').tooltip();
									},
									"bFilter" : false,
									"bSort": false,
									"searching" : false,
									"processing" : true,
									"serverSide" : true,
									"mark" : true,
									"responsive" : false,
									"pageLength" : '${numeroMassimoRecord}',
									"language" : {
										"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'
									},
									"ajax" : {
										"url" : '<spring:url value="/table/elencoStatiGrad.json" />',
										"dataSrc" : "payload"
									},
									"deferRender" : true,
									"columnDefs" : [
											{
												"render" : function(data, type,
														row) {
													if (row.anno
															&& row.anno !== 0) {
														return row.anno;
													}
													return "";
												},
												"name" : "anno",
												"targets" : 0
											},
											{
												"render" : function(data, type,
														row) {
													if (row.tipo
															&& row.tipo !== "") {
														return row.tipo;
													}
													return "";
												},
												"name" : "tipoGrad",
												"targets" : 1
											},
											{
												"render" : function(data, type,
														row) {

													if (row.tipo == 'MG')
														return "Medici generici";
													else
														return "Medici pediatri";

												},
												"name" : "descrizioneTipo",
												"targets" : 2
											},
											{
												"render" : function(data, type,
														row) {
													if (row.stato
															&& row.stato !== "") {
														return row.stato;
													}
													return "";
												},
												"name" : "stato",
												"targets" : 3
											},
											{
												"render" : function(data, type,
														row) {
													if (row.titoli && row.titoli !== "" && row.titoli =="0") {
														return "Validazione eseguita correttamente";
													}else{
														return "Validazione non eseguita";
													}
													return "";
												},
												"name" : "tbtgTipograd",
												"targets" : 4
											},
											{
												"render" : function(data, type,
														row) {
													if (row.dataScadenza
															&& row.dataScadenza !== 0) {
														return moment(
																row.dataScadenza)
																.format(
																		"DD/MM/YYYY");
													}
													return "";
												},
												"name" : "tbtgDescr",
												"targets" : 5
											},
											{
												"render" : function(data, type,
														row) {
													if (row.dataValidita
															&& row.dataValidita !== 0) {
														return moment(
																row.dataValidita)
																.format(
																		"DD/MM/YYYY");
													}
													return "";
												},
												"name" : "tbtgDescabb",
												"targets" : 6
											},
											{
												"render" : function(data, type,
														row) {
													return '<a href="#" class="cancellazioneStato" data-toggle="tooltip" title="Cancella"><i class="fa fa-times red" aria-hidden="true"></i></a>'
															+ '&nbsp;<a href="#" class="modificaStato" data-toggle="tooltip" title="Modifica"><i class="fa fa-refresh green" aria-hidden="true"></i></a>'
												},
												"name" : "tbtgDescabb",
												"targets" : 7
											} ]
								});
				$('#codiceStato').change(function(){
					if($('#codiceStato').val()=="MG")
					{
						$('#descGraduatoria').val('Graduatoria Medici generici');
					}
					else
					{
						$('#descGraduatoria').val('Graduatoria Pediatri');	
					}
				})
				$('#elencoStati tbody')
						.on(
								'click',
								'td a.modificaStato',
								function(evt) {
									evt.preventDefault();
									var tr = $(this).closest('tr');
									var row = elencoStatiDt.row(tr);
									var datiGraduatoria = row.data();
									confermaModificaStato(datiGraduatoria.anno,
											datiGraduatoria.tipo,
											datiGraduatoria.stato);
								});
				$('#elencoStati tbody')
						.on(
								'click',
								'td a.cancellazioneStato',
								function(evt) {
									evt.preventDefault();
									var tr = $(this).closest('tr');
									var row = elencoStatiDt.row(tr);
									var datiGraduatoria = row.data();
									confermaCancellaStato(datiGraduatoria.anno,
											datiGraduatoria.tipo,
											datiGraduatoria.stato);
								});
				$('#nuovoStato').on('click', function(evt) {
				    evt.preventDefault();
				    BootstrapDialog
				        .show({
				            title: 'Inserimento stato graduatoria',
				            message: function(dialog) {
				                var dati = new Object();
				                dati.insert = true;
				                var $modalBody = templateStatoGraduatoria(dati);
				                return $modalBody;
				            },
				            size: BootstrapDialog.SIZE_NORMAL,
				            type: BootstrapDialog.TYPE_PRIMARY,
				            closable: true,
				            draggable: false,
				            nl2br: false,
				            buttons: [{
				                    id: 'salva',
				                    icon: 'fa fa-save',
				                    label: 'Salva',
				                    cssClass: 'btn-primary',
				                    autospin: true,
				                    action: function(dialogRef) {
				                        dialogRef.enableButtons(false);
				                        dialogRef.setClosable(false);
				                        var obj = new Object();
				                        obj.anno = $('#annoModal').val();
				                        obj.tipo = $('#tipoGrad').val();
				                        obj.dataScadenza = new Date(formatDate($('#dataScadenzaModal').val()));
				                        obj.dataValidita = new Date(formatDate($('#dataValiditaModal').val()));
				                        obj.stato = $('#codiceStatoModal').val();
				                        salvaStato(obj, dialogRef);
				                    }
				                },
				                {
				                    id: 'annullaConferma',
				                    label: 'Annulla',
				                    action: function(
				                        dialogRef) {
				                        dialogRef.close();
				                    }
				                }
				            ]
				        });

				});
			});
			function confermaCancellaStato(anno, tipo, stato) {
				BootstrapDialog.show({
							title : 'Cancellazione stato graduatoria',
							message : function(dialog) {
								var datiGraduatoria = new Object();
								datiGraduatoria.anno = anno;
								datiGraduatoria.conferma = true;
								datiGraduatoria.tipo = tipo;
								if (stato == "CH")
									datiGraduatoria.stato = "Chiusa";
								else
									datiGraduatoria.stato = "Aperta";
								var $modalBody = templateCancellaStato(datiGraduatoria);
								return $modalBody;
							},
							size : BootstrapDialog.SIZE_NORMAL,
							type : BootstrapDialog.TYPE_PRIMARY,
							closable : true,
							draggable : false,
							nl2br : false,
							buttons : [
									{
										id : 'conferma',
										icon : 'fa fa-trash',
										label : 'Conferma',
										cssClass : 'btn-warning',
										autospin : true,
										action : function(dialogRef) {
											dialogRef.enableButtons(false);
											dialogRef.setClosable(false);
											cancellaStato(anno, tipo, stato,
													dialogRef);
										}
									}, {
										id : 'annullaConferma',
										label : 'Annulla',
										action : function(dialogRef) {
											dialogRef.close();
										}
									} ]
						});
			}
			function confermaModificaStato(anno, tipo, stato) {
				BootstrapDialog
						.show({
							title : 'Cambio stato graduatoria',
							message : function(dialog) {
								var datiGraduatoria = new Object();
								datiGraduatoria.anno = anno;
								datiGraduatoria.conferma = true;
								datiGraduatoria.tipo = tipo;
								if (stato == "CH")
									datiGraduatoria.stato = "Chiusa";
								else
									datiGraduatoria.stato = "Aperta";
								var $modalBody = templateConfermaCambioStato(datiGraduatoria);
								return $modalBody;
							},
							size : BootstrapDialog.SIZE_NORMAL,
							type : BootstrapDialog.TYPE_PRIMARY,
							closable : true,
							draggable : false,
							nl2br : false,
							buttons : [
									{
										id : 'conferma',
										icon : 'fa fa-check',
										label : 'Conferma',
										cssClass : 'btn-warning',
										autospin : true,
										action : function(dialogRef) {
											dialogRef.enableButtons(false);
											dialogRef.setClosable(false);
											confermaCambioStato(anno, tipo,
													stato, dialogRef);
										}
									}, {
										id : 'annullaConferma',
										label : 'Annulla',
										action : function(dialogRef) {
											dialogRef.close();
										}
									} ]
						});
			}
			function salvaStato(obj, dialogRef) {
				//salvaStato
				$.ajax({
					type : 'POST',
					url : '<spring:url value="/table/salvaStato.json" />',
					dataType : 'json',
					data : JSON.stringify(obj),
					contentType : 'application/json; charset=UTF-8',
					success : function(data) {
						var codiceEsito = data.codiceOperazione;
						if (codiceEsito == 200) {
							dialogRef.setClosable(true);
							dialogRef.getModalFooter().hide();
							var dati = new Object();
							dati.insertSuccess = true;
							var htmlDialog = templateStatoGraduatoria(dati);
							dialogRef.getModalBody().html(htmlDialog);
							//Ricarico la tabella aggiornata
							if (elencoStatiDt != null) {
								elencoStatiDt.ajax.reload();
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
			function cancellaStato(anno, tipo, stato, dialogRef) {
				$.ajax({
							url : '<spring:url value="/gradPunt/cancellaStato/'+anno+'/'+tipo+'.json" />',
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
									var htmlDialog = templateCancellaStato(dati);
									dialogRef.getModalBody().html(htmlDialog);
									//Ricarico la tabella aggiornata
									if (elencoStatiDt != null) {
										elencoStatiDt.ajax.reload();
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
			function confermaCambioStato(anno, tipo, stato, dialogRef) {
				$.ajax({
							url : '<spring:url value="/table/cambioStatoGrad/'+anno+'/'+tipo+'/'+stato+'.json" />',
							dataType : 'json',
							contentType : 'application/json; charset=UTF-8',
							success : function(data) {
								var codiceEsito = data.codiceOperazione;
								if (codiceEsito == 200) {
									dialogRef.setClosable(true);
									dialogRef.getModalFooter().hide();
									var dati = new Object();
									dati.successo = true;
									var htmlDialog = templateConfermaCambioStato(dati);
									dialogRef.getModalBody().html(htmlDialog);
									//Ricarico la tabella aggiornata
									if (elencoStatiDt != null) {
										elencoStatiDt.ajax.reload();
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
				var htmlDialog = templateCancellaStato(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
			function mostraErroreInserimento(dialogRef) {
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				dati.errori = true;
				var htmlDialog = templateStatoGraduatoria(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
			function reloadTabella() {
				if (elencoStatiDt && elencoStatiDt != null) {
					var baseUrl = '<spring:url value="/table/elencoStatiGrad.json" />';
					var filtri = new Object();
					if ($("#annoGrad").val() !== "") {
						filtri.anno = $("#annoGrad").val();
					}
					if ($("#codiceStato").val() !== "") {
						filtri.tipo = $("#codiceStato").val();
					}
					if ($("#statoGrad").val() !== "") {
						filtri.stato = $("#statoGrad").val();
					}
					if ($("#dataScadenza").val() !== "") {
						filtri.dataScadenza = $("#dataScadenza").val();
					}
					if ($("#dataValidita").val() !== "") {
						filtri.dataValidita = $("#dataValidita").val();
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
							id="codiceFunzione" readonly value="F_STGRAD">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body home_news">
									<!-- FORM RICERCA -->
									<form role="form" id="form_ricerca_stati">
										<div class="row">
											<!-- ANNO -->
											<div class="form-group col-md-2">
												<label for="annoGrad" class="control-label">Anno</label> <input
													type="text" class="form-control" id="annoGrad">
											</div>
											<!-- CODICE -->
											<div class="form-group col-md-2">
												<label for="codice" class="control-label">Codice</label> <select
													class="form-control selectpicker" id="codiceStato">
													<option value="">Seleziona</option>
													<option value="MG">MG</option>
													<option value="PD">PD</option>
												</select>
											</div>
											<!-- GRADUATORIA -->
											<div class="form-group col-md-4">
												<label for="descrizione" class="control-label">Graduatoria
												</label> <input type="text" class="form-control"
													id="descGraduatoria" readOnly>
											</div>
											<!-- STATO -->
											<div class="form-group col-md-3">
												<label for="statoGrad" class="control-label">Stato </label>
												<select class="form-control selectpicker" id="statoGrad">
													<option value="">Nessuna selezione</option>
													<option value="AP">AP - Aperta</option>
													<option value="CH">CH - Chiusa</option>
												</select>
											</div>
											</div>
											<div class="row">
											<!-- SCADENZA -->
											<div class="form-group col-md-3">
												<label for="data" class="control-label">Data
													scadenza</label>
												<div class="input-group date datepicker_data"
													id="dataNascitaDiv">
													<input id="dataScadenza" name="dataScadenza"
														class="form-control" readonly="readonly" type="text"
														value="" /> <span class="input-group-addon"> <span
														class="glyphicon glyphicon-calendar"></span>
													</span>
												</div>
											</div>
											<div class="form-group col-md-3">
												<label for="data" class="control-label">Data
													validit&aacute;</label>
												<div class="input-group date datepicker_data"
													id="dataNascitaDiv">
													<input id="dataValidita" name="dataValidita"
														class="form-control" readonly="readonly" type="text"
														value="" /> <span class="input-group-addon"> <span
														class="glyphicon glyphicon-calendar"></span>
													</span>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group col-md-5 margin10">
												<button type="submit" id="ricercaStati"
													class="btn btn-default btn-large button_salva">
													<i class="fa fa-search" aria-hidden="true"></i>&nbsp;Ricerca
												</button>
												<button type="submit" id="nuovoStato"
													class="btn btn-default btn-large button_salva">
													<i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Nuovo
												</button>
											</div>
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
									<table id="elencoStati"
										class="datatables-table table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Anno</th>
												<th>Cod</th>
												<th>Graduatoria</th>
												<th>Stato</th>
												<th>Validazione titoli</th>
												<th>Data scadenza</th>
												<th>Data validit&aacute;</th>
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