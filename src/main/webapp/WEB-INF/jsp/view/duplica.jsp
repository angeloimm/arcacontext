<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Graduatoria Medici - Duplica parametri</title>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<script type="text/x-handlebars-template"
			id="templateDuplicazioneAnno">
    {{#if errori}}
	<div id="erroreCancellazioneContainer" class="alert alert-danger">
		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong>
		Si è verificato un errore nella duplicazione dei parametri. <br> Riprovare più tardi
	</div>
	{{else if nonDuplicabile}}
	<div id="erroreCancellazioneContainer" class="alert alert-danger">
		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong>
		Impossibile duplicare i parametri per l'anno ed il tipo selezionato. Sono già presenti dati per tale graduatoria.
	</div>
	{{else if duplicazione}}
	<div id="erroreCancellazioneContainer" class="alert alert-warning">
		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
		Confermi di voler duplicare l'anno {{anno}} ?
		<br/>
		<small>Le operazioni riportate nel nuovo anno sono:<br>
		<ul>
		<li>Titoli graduatoria</li>
		<li>Titolarit&agrave; graduatoria</li>
		<li>Codici specializzazione</li>
		<li>Regole di contemporaneit&agrave;</li>
		</ul>
	</div>
	{{else if successo}}
	<div id="erroreCancellazioneContainer" class="alert alert-success">
		<i class="fa fa-check" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong>
		La duplicazione dei parametri è avvenuta correttamente.
	</div>
	{{/if}}
	</script>
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
							id="codiceFunzione" readonly value="F_DUPYR">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body panel_min_height home_news">
								<div class="row">
								<div class="col-md-2 col-md-offset-2 margin20">
									<span class="posAnno"><b>Anno da duplicare:</b></span>
								</div>
									<div class="col-md-3 col-md-offset-0 margin20">
										<div class="input-group date datepicker_duplicaDomanda">
											<input id="anno_duplica" name="anno_duplica"
												class="form-control" required readonly="readonly"
												type="text" value="${sessionScope.anno-1}" /> <span
												class="input-group-addon"> <span
												class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</div></div>
									<div class="col-md-3 col-md-offset-4 margin20">
										<button type="button"
											class="btn btn-default btn-large button_salva duplica"
											id="duplica">
											<i class="fa fa-clone" aria-hidden="true"></i>&nbsp;Duplica
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" charset="UTF-8">
			var templateDuplicazioneAnno = Handlebars.compile($(
					'#templateDuplicazioneAnno').html());
			$(function() {
				var nextYear = new moment().add('years', 1).format('L'); 
				$(".datepicker_duplicaDomanda").datetimepicker({
					format : "YYYY",
					showClose : true,
					locale : 'it',
					showClear : true,
					ignoreReadonly : true,
					maxDate : nextYear
				});
				$('#duplica').click(function() {
						BootstrapDialog.show({
								title : 'Duplicazione anno',
								message : function(dialog)
								{
								var dati = new Object();
								dati.duplicazione = true;
								dati.anno = $('#anno_duplica').val();
								var $modalBody = templateDuplicazioneAnno(dati);
								return $modalBody;
								},
								size : BootstrapDialog.TYPE_NORMAL,
								type : BootstrapDialog.TYPE_PRIMARY,
								closable : true,
								draggable : false,
								nl2br : false,
								buttons : [{
								id : 'conferma',
								icon : 'fa fa-check',
								label : 'Conferma',
								cssClass : 'btn-warning',
								autospin : true,
								action : function(dialogRef) {
									dialogRef.enableButtons(false);
									dialogRef.setClosable(false);
									var annoDuplicazione = $('#anno_duplica').val();
									confermaDuplicazione(annoDuplicazione,dialogRef);
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
					})
			})
			function confermaDuplicazione(annoDuplicazione, dialogRef) {
				$.ajax({
							url : '<spring:url value="/parametriAnno/duplica/'+annoDuplicazione+'.json" />',
							dataType : 'json',
							contentType : 'application/json; charset=UTF-8',
							statusCode : {
								403 : function(response) {
									dialogRef.setClosable(true);
									dialogRef.getModalFooter().hide();
									var dati = new Object();
									dati.nonDuplicabile = true;
									var htmlDialog = templateDuplicazioneAnno(dati);
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
									var htmlDialog = templateDuplicazioneAnno(dati);
									dialogRef.getModalBody().html(htmlDialog);
									//Ricarico la tabella aggiornata
									if (elencoDomandeDt != null) {
										elencoDomandeDt.ajax.reload();
									}
								} else if (codiceEsito == 500) {
									mostraErroreDuplicazione(dialogRef);
								}
							},
							error : function(data) {
								mostraErroreDuplicazione(dialogRef);
							}
						});
			}
			function mostraErroreDuplicazione(dialogRef) {
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				dati.errori = true;
				var htmlDialog = templateDuplicazioneAnno(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>