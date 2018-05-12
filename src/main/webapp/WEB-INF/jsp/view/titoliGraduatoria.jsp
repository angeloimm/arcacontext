<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
   <tiles:putAttribute name="head"> 
      <title>Titoli Graduatoria</title>
   </tiles:putAttribute>
   <tiles:putAttribute name="body">
      <script type="text/x-handlebars-template"
         id="templateConfermaCancellazioneTitolo">
         {{#if errori}}
         	<div id="erroreCancellazioneContainer" class="alert alert-danger">
         		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
         		Si &egrave; verificato un errore durante la cancellazione del titolo.
         		<br/>
         		Ti preghiamo di riprovare più tardi.
         	</div>
         {{else if nonCancellabile}}
         	<div id="erroreCancellazioneContainer" class="alert alert-danger">
         		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
         		Impossibile cancellare il titolo anno. Vi sono dati ad esso collegati.
         	</div>
         {{else if successo}}
         	<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
         		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
         		Cancellazione titolo terminata con successo
         	</div>
         {{else}}
         	<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
         		Confermi di voler cancellare il titolo 
                      	con codice <strong>{{codice}}</strong>
                      	e descrizione <strong>{{descrizione}}</strong>?
                      	<br/><br/>
                      	<strong>Attenzione!</strong> L'operazione non è annullabile
         	</div>
         {{/if}}
      </script>
      <script type="text/x-handlebars-template"
         id="templateConfermaCancellazioneTitoloObbl">
         {{#if errori}}
         	<div id="erroreCancellazioneContainer" class="alert alert-danger">
         		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
         		È avvenuto un errore durante la cancellazione del titolo.
         		<br/>
         		Ti preghiamo di riprovare più tardi.
         	</div>
         {{else if successo}}
         	<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
         		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
         		Cancellazione titolo terminata con successo
         	</div>
         {{else}}
         	<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
         		Confermi di voler cancellare il titolo 
                      	con codice <strong>{{codice}}</strong>
         		{{#if descrizione}}
                      	e descrizione <strong>{{descrizione}}</strong>
         		{{/if}}
         		?
                      	<br/><br/>
                      	<strong>Attenzione!</strong> L'operazione non è annullabile
         	</div>
         {{/if}}
      </script>
      <script type="text/x-handlebars-template"
         id="templateInserimentoTitolo">
         {{#if insert}}
         <div class="row">
         <form method="POST" id="form_titolo">
         <div class="form-group col-md-6">
         <label for="anno" class="control-label"> Anno (*)</label>
         <div class="input-group date datepicker_anno">
         <input id="anno" name="anno" class="form-control" required="true"
         	readonly="readonly" type="text" value="${sessionScope.anno}" /> <span
         	class="input-group-addon"> <span
         	class="glyphicon glyphicon-calendar"></span>
         </span>
         </div>
         </div>
         <div class="form-group col-md-6">
         <label for="descrizione" class="control-label">Tipo graduatoria (*)</label>
         <input type="text" class="form-control"
         id="descrizione"  required="true" readonly value="${sessionScope.tipoGraduatoria}" />
         </div>
         <div class="form-group col-md-6">
         <label for="codiceTitolo" class="control-label">Codice (*)</label>
         <input type="text" class="form-control"
         id="codiceTitolo" required="true"/>
         </div>
         <div class="form-group col-md-3">
         <label for="codice" class="control-label">Unit&agrave; di misura (*)</label>
         <select id="unita" class="form-control">
         <option value="T">T - Totale</option>
         <option value="C">C - Numero</option>
         <option value="H">H - Ore</option>
         <option value="M">M - Minuti</option>
         <option value="G">G - Giorni</option>
         </select>
         </div>
         <div class="form-group col-md-3">
         <label for="codice" class="control-label">Punti (*)</label>
         <input type="text" class="form-control"
         id="punti" required="true" />
         </div>
         <div class="form-group col-md-4">
         <label for="codice" class="control-label">Punti max (*)</label>
         <input type="text" class="form-control"
         id="puntiMax" required="true" />
         </div>
         <div class="form-group col-md-4">
         <label for="codice" class="control-label">Tipo (*)</label>
         <input type="text" class="form-control"
         id="tipoForm" required="true" />
         </div>
         <div class="form-group col-md-4">
         <label for="codice" class="control-label">Ore </label>
         <input type="text" class="form-control"
         id="ore" required="true" />
         </div>
         <div class="form-group col-md-6">
         <label for="codice" class="control-label">Ulss (*)</label>
         <select class="form-control" id="ulss">
         <option value="S">S</option>
         <option value="N">N</option>
         </select>
         </div>
         <div class="form-group col-md-6">
         <label for="codice" class="control-label">Obbl. (*)</label>
         <select class="form-control" id="obbl">
         <option value="S">S</option>
         <option value="N">N</option>
         </select>
         </div>
         <div class="form-group col-md-12">
         <label for="descrizioneTitolo" class="control-label">Descrizione (*)</label>
         <input type="text" class="form-control" id="descrizioneTitolo"
         placeholder="Descrizione completa" required="true" maxlength="50" data-error="Inserire non più di 50 caratteri"/>
         </div>
         <div class="align_center red" style="display:none;" id="error">
         				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
         			&nbsp; I campi contrassegnati dall'asterisco sono obbligatori
         					</div>
         </form>
         {{else if modifica}}
         <div class="row">
         <form method="POST" id="form_titolo">
         <div class="alert alert-warning col-md-12">
         	<strong>Attenzione!</strong> Stai modificando il titolo con codice <strong>{{codice}}</strong>
         </div>
         <div class="form-group col-md-4">
         	<label for="codice" class="control-label">Unit&agrave; di misura (*)</label>
         	<select id="unitaModal" class="form-control">
         		<option value="T">T - Totale</option>
         		<option value="C">C - Numero</option>
         		<option value="H">H - Ore</option>
         		<option value="M">M - Minuti</option>
         		<option value="G">G - Giorni</option>
        	 </select>
         </div>
         <div class="form-group col-md-4">
         	<label for="codice" class="control-label">Punti (*)</label>
         		<input type="text" class="form-control"
         		id="puntiModal" required="true" />
         </div>
         <div class="form-group col-md-4">
         	<label for="codice" class="control-label">Punti max (*)</label>
        		 <input type="text" class="form-control"
        		 id="puntiMaxModal" required="true" />
         </div>
         <div class="form-group col-md-6">
         <label for="codice" class="control-label">Tipo (*)</label>
         <input type="text" class="form-control"
         id="tipoModal" required="true" />
         </div>
         <div class="form-group col-md-6">
         <label for="codice" class="control-label">Ore </label>
         <input type="text" class="form-control"
         id="oreModal" required="true" />
         </div>
         <div class="form-group col-md-6">
         <label for="codice" class="control-label">Ulss (*)</label>
         <select class="form-control" id="ulssModal">
         <option value="S">S</option>
         <option value="N">N</option>
         </select>
         </div>
         <div class="form-group col-md-6">
         <label for="codice" class="control-label">Obbl. (*)</label>
         <select class="form-control" id="obblModal">
         <option value="S">S</option>
         <option value="N">N</option>
         </select>
         </div>
         <div class="form-group col-md-12">
         <label for="descrizioneTitolo" class="control-label">Descrizione (*)</label>
         <input type="text" class="form-control" id="descr"
         placeholder="Descrizione completa" required="true" maxlength="50" data-error="Inserire non più di 50 caratteri"/>
         </div>
         <div class="align_center red" style="display:none;" id="error">
         				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
         			&nbsp; I campi contrassegnati dall'asterisco sono obbligatori
         					</div>
         </form>
         <script>
         $(function(){
         $('#descr').val(descrModal);
         $('#puntiMaxModal').val(punteggioMaxModal);
         $('#puntiModal').val(puntiModal);
         $('#unitaModal').val(unitaModal);
         $('#tipoModal').val(tipoModal);
         $('#ulssModal').val(ulssModal);
         $('#obblModal').val(obblModal);
         $('#oreModal').val(oreModal);
         })
         <{{!}}/script>
         </div>
         {{else if modificaSuccess}}
         <div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
         		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
         		Modifica titolo avvenuta correttamente
         	</div>
         {{else}}
         <div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
         		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
         		Inserimento titolo avvenuto correttamente
         	</div>
         {{/if}}
      </script>
      <script type="text/x-handlebars-template"
         id="templateInserimentoTitoloObbl">
         {{#if erroriInserimento}}
         <div id="erroreCancellazioneContainer" class="alert alert-danger">
         		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
         		Si &egrave; verificato un errore durante l'inserimento del titolo.
         		<br/>
         		Ti preghiamo di riprovare più tardi.
         	</div>
         {{else if insert}}
         <div class="row">
         <form method="POST" id="form_titolo">
         <div class="form-group col-md-6">
         <label for="anno" class="control-label"> Anno (*)</label>
         <div class="input-group date datepicker_anno">
         <input id="anno" name="anno" class="form-control" required="true"
         	readonly="readonly" type="text" value="${sessionScope.anno}" /> <span
         	class="input-group-addon"> <span
         	class="glyphicon glyphicon-calendar"></span>
         </span>
         </div>
         </div>
         <div class="form-group col-md-6">
         <label for="descrizione" class="control-label">Tipo graduatoria (*)</label>
         <input type="text" class="form-control"
         id="descrizione"  required="true" readonly value="${sessionScope.tipoGraduatoria}" />
         </div>
         <div class="form-group col-md-6">
         <label for="codiceTitolo" class="control-label">Codice (*)</label>
         <input type="text" class="form-control"
         id="codiceTitolo" required="true"/>
         </div>
         <div class="form-group col-md-6">
         <label for="codice" class="control-label">Titolo obbl. (*)</label>
         <input type="text" class="form-control"
         id="titolo" required="true" />
         </div>
         <div class="form-group col-md-12">
         <label for="descrizioneTitolo" class="control-label">Descrizione (*)</label>
         <input type="text" class="form-control" id="descrizioneTitolo"
         placeholder="Descrizione completa" required="true" maxlength="50" data-error="Inserire non più di 50 caratteri"/>
         </div>
         <div class="align_center red" style="display:none;" id="error">
         <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
         &nbsp; I campi contrassegnati dall'asterisco sono obbligatori
         </div>
         </form>
         {{else if modifica}}
         <div class="row">
         <form method="POST" id="form_titolo">
         <div class="alert alert-warning col-md-12">
         	<strong>Attenzione!</strong> Stai modificando il titolo obbl. con codice <strong>{{codice}}</strong>
         relativo all'anno <strong>{{anno}}</strong> e tipo <strong>{{tipo}}</strong>.
         </div>
              <div class="form-group col-md-12">
                 <label for="codice" class="control-label">Descrizione  (*)</label>
                  <input type="text" class="form-control" id="descrizioneModal" required="true" maxlength="50" data-error="Inserire non più di 50 caratteri" />
           </div>
         <div class="align_center red" style="display:none;" id="error">
         <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
         &nbsp; I campi contrassegnati dall'asterisco sono obbligatori
         </div>
         </form>
         </div>
         <script>
         $(function(){
         $('#descrizioneModal').val(descrizioneModal);
         })
         <{{!}}/script>
         {{else if modificaSuccess}}
         <div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
         		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
         		Modifica titolo obbl. avvenuta con successo.
         	</div>
         {{else if modificaError}}
         <div id="erroreCancellazioneContainer" class="alert alert-danger" role="alert">
         		<i class="fa fa-esclamation triangle" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
         		Si &egrave; verificato un errore nella modifica del titolo.<br>
				Ti preghiamo di riprovare pi&ugrave; tardi
				</br>
         	</div>
         {{else}}
         <div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
         		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
         		Inserimento titolo effettuato con successo
         	</div>
         {{/if}}
      </script>
      <script type="text/javascript" charset="UTF-8">
         var descrizioneModal = null;
         var descrModal = null;
         var puntiModal = null;	
         var punteggioMaxModal = null;	
         var unitaModal = null;
         var tipoModal = null;
         var ulssModal = null;
         var obblModal = null;
         var oreModal = null;
         var templateConfermaCancellazioneTitolo = Handlebars.compile($(
         			'#templateConfermaCancellazioneTitolo').html());
         	var templateInserimentoTitolo = Handlebars.compile($(
         			'#templateInserimentoTitolo').html());
         	var templateInserimentoTitoloObbl = Handlebars.compile($(
         			'#templateInserimentoTitoloObbl').html());
         	var templateConfermaCancellazioneTitoloObbl = Handlebars.compile($(
         			'#templateConfermaCancellazioneTitoloObbl').html());
         	var elencoTitoliAnnoDt = null;
         	var elencoTitoliObbDt = null;
         	$(function() {
         		elencoTitoliAnnoDt = $("#titoliAnnoTable")
         				.DataTable(
         						{
         							"drawCallback" : function(settings) {
         								$('[data-toggle="tooltip"]').tooltip();
         							},
         							"bSort": false,
         							"lengthChange" : false,
         							"processing" : true,
         							"serverSide" : true,
         							"searching" : false,
         							"mark" : true,
         							"responsive" : false,
         							"pageLength" : '${numeroMassimoRecord}',
         							"language" : {
         								"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'
         							},
         							"ajax" : {
         								"url" : '<spring:url value="/cont/elencoTitoliAnno.json" />',
         								"dataSrc" : "payload"
         							},
         							"deferRender" : true,
         							"columnDefs" : [
         									{
         										"render" : function(data, type,row) {
         											if (row.codiceTitolo && row.codiceTitolo !== 0) {
         												return row.codiceTitolo;
         											}
         											return "";
         										},
         										"name" : "codiceTitolo",
         										"targets" : 0,
         									},
         									{
         										"render" : function(data, type,row) {
         											if (row.descrizione && row.descrizione != "") {
         												return row.descrizione;
         											}
         										},
         										"name" : "descrizione",
         										"targets" : 1,
         									},
         									{
         										"render" : function(data, type,row) {
         											if (row.unitaMisura && row.unitaMisura !== "") {
         												return row.unitaMisura;
         											}
         											return "";
         										},
         										"name" : "unitaMisura",
         										"targets" : 2,
         									},
         									{
         										"render" : function(data, type,row) {
         											if (row.punti
         													&& row.punti !== 0) {
         												return row.punti;
         											}
         											return "";
         										},
         										"name" : "punti",
         										"targets" : 3,
         									},
         									{
         										"render" : function(data, type,
         												row) {
         											if (row.punteggioMax
         													&& row.punteggioMax !== 0) {
         												return row.punteggioMax;
         											}
         											return "0";
         										},
         										"name" : "punteggioMax",
         										"targets" : 4,
         									},
         									{
         										"render" : function(data, type,
         												row) {
         											if (row.tipo
         													&& row.tipo !== 0) {
         												return row.tipo;
         											}
         											return "-";
         										},
         										"name" : "tipo",
         										"targets" : 5,
         									},
         									{
         										"render" : function(data, type,
         												row) {
         											if (row.obbligatorio
         													&& row.obbligatorio !== 0) {
         												return row.obbligatorio;
         											}
         											return "-";
         										},
         										"name" : "ore",
         										"targets" : 6,
         									},
         									{
         										"render" : function(data, type,
         												row) {
         											if (row.ulss
         													&& row.ulss !== "") {
         												return row.ulss;
         											}
         											return "-";
         										},
         										"name" : "ulss",
         										"targets" : 7,
         									},
         									{
         										"render" : function(data, type,row) {
         											return '<a href="#" class="cancellazione" data-toggle="tooltip" title="Cancella"><i class="fa fa-times red" aria-hidden="true"></i></a>'
         													+ '&nbsp;<a href="#" class="modificaTitoloAnno" data-toggle="tooltip" title="Modifica"><i class="fa fa-refresh green" aria-hidden="true"></i></a>'
         										},
         										"name" : "",
         										"targets" : 8
         									} ]
         						});
        		elencoTitoliObbDt = $("#titoliObblTable").DataTable(
 						{
 							"drawCallback" : function(settings) {
 								$('[data-toggle="tooltip"]').tooltip();
 							},
 							"bSort": false,
 							"processing" : true,
 							"serverSide" : true,
 							"searching" : true,
 							"mark" : true,
 							"responsive" : false,
 							"pageLength" : '${numeroMassimoRecord}',
 							"language" : {
 								"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'
 							},
 							"ajax" : {
 								"url" : '<spring:url value="/cont/elencoTitoliObbl.json" />',
 								"dataSrc" : "payload"
 							},
 							"deferRender" : true,
 							"columnDefs" : [
 									{
 										"render" : function(data, type,
 												row) {
 											if (row.codice
 													&& row.codice !== 0) {
 												return row.codice;
 											}
 											return "";
 										},
 										"name" : "codice",
 										"targets" : 0,
 									},
 									{
 										"render" : function(data, type,
 												row) {
 											if (row.titolo
 													&& row.titolo !== 0) {
 												return row.titolo;
 											}
 											return "";
 										},
 										"name" : "titolo",
 										"targets" : 1,
 									},
 									{
 										"render" : function(data, type,
 												row) {
 											if (row.descrizione
 													&& row.descrizione != "") {
 												return row.descrizione;
 											}
 											return "";
 										},
 										"name" : "descrizione",
 										"targets" : 2,
 									},
 									{
 										"render" : function(data, type,
 												row) {
 											return '<a href="#" class="cancella" data-toggle="tooltip" title="Cancella"><i class="fa fa-times red" aria-hidden="true"></i></a>'
 													+ '&nbsp;<a href="#" class="modifica" data-toggle="tooltip" title="Modifica"><i class="fa fa-refresh green" aria-hidden="true"></i></a>'
 										},
 										"name" : "",
 										"targets" : 3
 									} ]
 						});
         		$('#nuovoTitolo').click(function(evt) {
         				evt.preventDefault();
         				BootstrapDialog.show({
         							title : 'Inserimento titolo',
         							message : function(dialog) 
         							{
         								var dati = new Object();
         								dati.insert = true;
         								var $modalBody = templateInserimentoTitolo(dati);
         								return $modalBody;
         							},
         							size : BootstrapDialog.NORMAL,
         							type : BootstrapDialog.TYPE_PRIMARY,
         							closable : true,
         							draggable : false,
         							nl2br : false,
         							buttons : [{
         										id : 'conferma',
         										icon : 'fa fa-save',
         										label : 'Salva',
         										cssClass : 'btn-primary',
         										autospin : false,
         										action : function(dialogRef) {
         											dialogRef.enableButtons(false);
         											dialogRef.setClosable(false);
         											var obj = new Object();
         											obj.codiceTitolo = $('#codiceTitolo').val();
         											obj.descrizione = $('#descrizioneTitolo').val();
         											obj.punti = $('#punti').val();
         											obj.punteggioMax = $('#puntiMax').val();
         											obj.unitaMisura = $('#unita').val();
         											obj.tipo = $('#tipoForm').val();
         											obj.ore = $('#ore').val();
         											obj.ulss = $('#ulss').val();
         											obj.obbligatorio = $('#obbl').val();
         											salvaTitoloAnno(obj,dialogRef);
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
         		$('#nuovoTitoloObbl').click(function(evt) {
         			evt.preventDefault();
         			BootstrapDialog.show({
         						title : 'Inserimento titolo',
         						message : function(dialog) {
         						var dati = new Object();
         					    dati.insert = true;
         						var $modalBody = templateInserimentoTitoloObbl(dati);
         						return $modalBody;
         						},
         			size : BootstrapDialog.NORMAL,
         			type : BootstrapDialog.TYPE_PRIMARY,
         			closable : true,
         			draggable : false,
         			nl2br : false,
         			buttons : [{
         						 id : 'conferma',
         						 icon : 'fa fa-save',
         						 label : 'Salva',
         						 cssClass : 'btn-primary',
         						 autospin : false,
         						 action : function(dialogRef) {
         							dialogRef.enableButtons(false);
         							dialogRef.setClosable(false);
         							var obj = new Object();
         							obj.codice = $('#codiceTitolo').val();
         							obj.titolo = $('#titolo').val();
         							obj.descrizione = $('#descrizioneTitolo').val();
         							salvaTitoloObbl(obj,dialogRef);
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
         		$('#titoliAnnoTable tbody').on('click', 'td a.cancellazione',function(evt) {
         					evt.preventDefault();
         					var tr = $(this).closest('tr');
         					var row = elencoTitoliAnnoDt.row(tr);
         					var datiTitolo = row.data();
         					confermaCancellazioneTitolo(datiTitolo);
         				});
         		$('#titoliObblTable tbody').on('click', 'td a.cancella',function(evt) {
         					evt.preventDefault();
         					var tr = $(this).closest('tr');
         					var row = elencoTitoliObbDt.row(tr);
         					var datiTitolo = row.data();
         					confermaCancellazioneTitoloObb(datiTitolo);
         		});
         		$('#titoliObblTable tbody').on('click', 'td a.modifica',function(evt) {
         					evt.preventDefault();
         					var tr = $(this).closest('tr');
         					var row = elencoTitoliObbDt.row(tr);
         					var datiTitolo = row.data();
         					modificaTitoloObbl(datiTitolo);
         		});
         		$('#titoliAnnoTable tbody').on('click', 'td a.modificaTitoloAnno',function(evt) {
         			evt.preventDefault();
         			var tr = $(this).closest('tr');
         			var row = elencoTitoliAnnoDt.row(tr);
         			var datiTitolo = row.data();
         			modificaTitoloAnno(datiTitolo);
         		});
         	})
         	function modificaTitoloAnno(obj){
         		BootstrapDialog.show({
         			title : 'Modifica titolo',
         			message : function(dialog) {
         				debugger;
         				descrModal = obj.descrizione;
         				puntiModal = obj.punti;
         				punteggioMaxModal = obj.punteggioMax;
         				unitaModal = obj.unitaMisura;
         				tipoModal = obj.tipo;
         				ulssModal  = obj.ulss;
         				obblModal = obj.obbligatorio;
         				var dati = new Object();
         				dati.codice = obj.codiceTitolo;
         				dati.anno = ${sessionScope.anno};
         				dati.tipoGrad = '${sessionScope.tipo}'; 
         				dati.modifica = true;
         				var $modalBody = templateInserimentoTitolo(dati);
         				return $modalBody;
         			},
         			size : BootstrapDialog.NORMAL,
         			type : BootstrapDialog.TYPE_PRIMARY,
         			closable : true,
         			draggable : false,
         			nl2br : false,
         			buttons : [
         					{
         						id : 'conferma',
         						icon : 'fa fa-save',
         						label : 'Modifica',
         						cssClass : 'btn-primary',
         						autospin : false,
         						action : function(dialogRef) {
         							dialogRef.enableButtons(false);
         							dialogRef.setClosable(false);
         							debugger;
         							var data = new Object();
         							data.codiceTitolo = obj.codiceTitolo;
         							data.descrizione = $('#descr').val();
         							data.punteggioMax = $('#puntiMaxModal').val();
         							data.punti =  $('#puntiModal').val();
         							data.unitaMisura =  $('#unitaModal').val();
         							data.tipo =  $('#tipoModal').val();
         							data.ulss =   $('#ulssModal').val();
         							data.obbligatorio = $('#obblModal').val();
         							data.ore =   $('#oreModal').val();
         							confermaModificaTitoloAnno(data, dialogRef);
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
         	function modificaTitoloObbl(obj) {
         		BootstrapDialog.show({
         			title : 'Modifica titolo',
         			message : function(dialog) {
         				descrizioneModal = obj.descrizione;
         				var dati = new Object();
         				dati.codice = obj.codice;
         				dati.titolo = obj.titolo;
         				dati.anno = ${sessionScope.anno};
         				dati.tipo = '${sessionScope.tipo}';
         				dati.modifica = true;
         				var $modalBody = templateInserimentoTitoloObbl(dati);
         				return $modalBody;
         			},
         			size : BootstrapDialog.NORMAL,
         			type : BootstrapDialog.TYPE_PRIMARY,
         			closable : true,
         			draggable : false,
         			nl2br : false,
         			buttons : [
         					{
         						id : 'conferma',
         						icon : 'fa fa-save',
         						label : 'Modifica',
         						cssClass : 'btn-primary',
         						autospin : false,
         						action : function(dialogRef) {
         							dialogRef.enableButtons(false);
         							dialogRef.setClosable(false);
         							var data = new Object();
         							data.anno = obj.anno;
         							data.tipo = obj.tipo;
         							data.codice = obj.codice;
         							data.titolo = obj.titolo;
         							data.descrizione = $('#descrizioneModal').val();
         							confermaModificaTitoloObbl(data, dialogRef);
         
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
         	function confermaModificaTitoloObbl(obj, dialogRef){
         		// Controllo sui campi obbligatori
         		if(obj.descrizione==""){
         			$('#error').css('display','block');
                   		dialogRef.enableButtons(true);
                           dialogRef.setClosable(true);
                   		return;
         		}
                       $.ajax({
                           type: 'POST',
                           url: '<spring:url value="/cont/modificaTitoloObbl.json" />',
                           dataType: 'json',
                           data: JSON.stringify(obj),
                           contentType: 'application/json; charset=UTF-8',
                           success: function(data) {
                               var codiceEsito = data.codiceOperazione;
                               if (codiceEsito == 200) {
                                   dialogRef.setClosable(true);
                                   dialogRef.getModalFooter().hide();
                                   var dati = new Object();
                                   dati.modificaSuccess = true;
                                   var htmlDialog = templateInserimentoTitoloObbl(dati);
                                   dialogRef.getModalBody().html(htmlDialog);
                                   //Ricarico la tabella aggiornata
                                   if (elencoTitoliObbDt != null) {
                                   	elencoTitoliObbDt.ajax.reload();
                                   }
                               } else if (codiceEsito == 500) {
                                   mostraErroreModifica(dialogRef);
                               }
                           },
                           error: function(data) {
                               mostraErroreModifica(dialogRef);
                           }
                       });
                   }
         	function confermaModificaTitoloAnno(obj, dialogRef){
         		// Controllo sui campi obbligatori
         		/* if(obj.descrizione=="" || obj.punti=="" || obj.punteggioMax==""){
         			$('#error').css('display','block');
                   		dialogRef.enableButtons(true);
                           dialogRef.setClosable(true);
                   		return;
         		} */
                       $.ajax({
                           type: 'POST',
                           url: '<spring:url value="/cont/modificaTitoloAnno.json" />',
                           dataType: 'json',
                           data: JSON.stringify(obj),
                           contentType: 'application/json; charset=UTF-8',
                           success: function(data) {
                               var codiceEsito = data.codiceOperazione;
                               if (codiceEsito == 200) {
                                   dialogRef.setClosable(true);
                                   dialogRef.getModalFooter().hide();
                                   var dati = new Object();
                                   dati.modificaSuccess = true;
                                   var htmlDialog = templateInserimentoTitolo(dati);
                                   dialogRef.getModalBody().html(htmlDialog);
                                   //Svuoto le variabili
                                    descrModal = null;
         							puntiModal = null;	
         							punteggioMaxModal = null;	
         							unitaModal = null;
         							tipoModal = null;
         							ulssModal = null;
         							obblModal = null;
         							oreModal = null;
                                   //Ricarico la tabella aggiornata
                                   if (elencoTitoliAnnoDt != null) {
                                   	elencoTitoliAnnoDt.ajax.reload();
                                   }
                               } else if (codiceEsito == 500) {
                                   mostraErroreModifica(dialogRef);
                               }
                           },
                           error: function(data) {
                               mostraErroreModifica(dialogRef);
                           }
                       });
                   }
         	function confermaCancellazioneTitoloObb(datiTitolo) {
         		BootstrapDialog.show({
         					title : 'Cancellazione titolo obbligatorio',
         					message : function(dialog) {
         						var dati = new Object();
         						dati.codice = datiTitolo.codice;
         						dati.descrizione = datiTitolo.descrizione;
         						var $modalBody = templateConfermaCancellazioneTitoloObbl(dati);
         						return $modalBody;
         					},
         					size : 'size-wide',
         					type : BootstrapDialog.TYPE_PRIMARY,
         					closable : true,
         					draggable : false,
         					nl2br : false,
         					buttons : [
         							{
         								id : 'conferma',
         								icon : 'fa fa-trash-o',
         								label : 'Conferma',
         								cssClass : 'btn-warning',
         								autospin : true,
         								action : function(dialogRef) {
         									dialogRef.enableButtons(false);
         									dialogRef.setClosable(false);
         									cancellaTitoloObb(
         											datiTitolo.codice,
         											datiTitolo.titolo,
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
         	function confermaCancellazioneTitolo(datiTitolo) {
         		BootstrapDialog.show({
         					title : 'Cancellazione titolo',
         					message : function(dialog) {
         						var dati = new Object();
         						dati.codice = datiTitolo.codiceTitolo;
         						dati.descrizione = datiTitolo.descrizione;
         						var $modalBody = templateConfermaCancellazioneTitolo(dati);
         						return $modalBody;
         					},
         					size : 'size-wide',
         					type : BootstrapDialog.TYPE_PRIMARY,
         					closable : true,
         					draggable : false,
         					nl2br : false,
         					buttons : [
         							{
         								id : 'conferma',
         								icon : 'fa fa-trash-o',
         								label : 'Conferma',
         								cssClass : 'btn-warning',
         								autospin : true,
         								action : function(dialogRef) {
         									dialogRef.enableButtons(false);
         									dialogRef.setClosable(false);
         									cancellaTitolo(
         											datiTitolo.codiceTitolo,
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
         	function cancellaTitolo(codice, dialogRef) {
         		$.ajax({
         					url : '<spring:url value="/cont/cancellaTitolo/'+codice+'.json" />',
         					dataType : 'json',
         					contentType : 'application/json; charset=UTF-8',
         					type : 'DELETE',
         					statusCode : {
         						403 : function(response) {
         							dialogRef.setClosable(true);
         							dialogRef.getModalFooter().hide();
         							var dati = new Object();
         							dati.nonCancellabile = true;
         							var htmlDialog = templateConfermaCancellazioneTitolo(dati);
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
         							var htmlDialog = templateConfermaCancellazioneTitolo(dati);
         							dialogRef.getModalBody().html(htmlDialog);
         							//Ricarico la tabella aggiornata
         							if (elencoTitoliAnnoDt != null) {
         								elencoTitoliAnnoDt.ajax.reload();
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
         		var htmlDialog = templateConfermaCancellazioneTitolo(dati);
         		dialogRef.getModalBody().html(htmlDialog);
         	}
         	function cancellaTitoloObb(codice, titolo, dialogRef) {
         		$.ajax({
         					url : '<spring:url value="/cont/cancellaTitoloObb/'+codice+'/'+titolo+'.json" />',
         					dataType : 'json',
         					contentType : 'application/json; charset=UTF-8',
         					type : 'DELETE',
         					statusCode : {
         						403 : function(response) {
         							dialogRef.setClosable(true);
         							dialogRef.getModalFooter().hide();
         							var dati = new Object();
         							dati.nonCancellabile = true;
         							var htmlDialog = templateConfermaCancellazioneTitolo(dati);
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
         							var htmlDialog = templateConfermaCancellazioneTitolo(dati);
         							dialogRef.getModalBody().html(htmlDialog);
         							//Ricarico la tabella aggiornata
         							if (elencoTitoliObbDt != null) {
         								elencoTitoliObbDt.ajax.reload();
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
         	function salvaTitoloAnno(obj, dialogRef) {
         		// Controllo sui campi obbligatori
         		if (obj.codiceTitolo ==="" || obj.descrizione ==="" || obj.punti==="" || obj.punteggioMax==="" || obj.tipo==="") {
         			$('#error').css('display', 'block');
         			dialogRef.enableButtons(true);
         			dialogRef.setClosable(true);
         			return;
         		}
         		$.ajax({
         			type : 'POST',
         			url : '<spring:url value="/cont/salvaTitoloAnno.json" />',
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
         					var htmlDialog = templateInserimentoTitolo(dati);
         					dialogRef.getModalBody().html(htmlDialog);
         					//Ricarico la tabella aggiornata
         					if (elencoTitoliAnnoDt != null) {
         						elencoTitoliAnnoDt.ajax.reload();
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
         	function salvaTitoloObbl(obj, dialogRef) {
         		// Controllo sui campi obbligatori
         		if (obj.codice == "" || obj.descrizione == ""
         				|| obj.titolo === "") {
         			$('#error').css('display', 'block');
         			dialogRef.enableButtons(true);
         			dialogRef.setClosable(true);
         			return;
         		}
         		$.ajax({
         					type : 'POST',
         					url : '<spring:url value="/cont/salvaTitoloObbl.json" />',
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
         							var htmlDialog = templateInserimentoTitoloObbl(dati);
         							dialogRef.getModalBody().html(htmlDialog);
         							//Ricarico la tabella aggiornata
         							if (elencoTitoliObbDt != null) {
         								elencoTitoliObbDt.ajax.reload();
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
         	function mostraErroreInserimento(dialogRef) {
         		//dialogRef.setType(BootstrapDialog.TYPE_DANGER);
         		dialogRef.setClosable(true);
         		dialogRef.getModalFooter().hide();
         		var dati = new Object();
         		dati.erroriInserimento = true;
         		var htmlDialog = templateInserimentoTitoloObbl(dati);
         		dialogRef.getModalBody().html(htmlDialog);
         	}
         	function mostraErroreModifica(dialogRef){
         		//dialogRef.setType(BootstrapDialog.TYPE_DANGER);
         		dialogRef.setClosable(true);
         		dialogRef.getModalFooter().hide();
         		var dati = new Object();
         		dati.modificaError = true;
         		var htmlDialog = templateInserimentoTitoloObbl(dati);
         		dialogRef.getModalBody().html(htmlDialog);
         	}
      </script>
      <form role="form" id="form_titGrad">
         <div class="sfondo_body">
            <div class="container pos">
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
                              id="tipo_esteso" readonly value="Graduatoria pediatri"
                              required>
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
                        id="codiceFunzione" readonly value="F_TBTA">
                  </div>
               </div>
               <div class="container pos">
                  <ul class="nav nav-tabs" style="margin-top: 20px;">
                     <li class="active"><a data-toggle="tab" href="#home">Titoli
                        anno</a>
                     </li>
                     <li><a data-toggle="tab" href="#contemporaneita">Contemporaneità</a></li>
                     <li><a data-toggle="tab" href="#verifica">Verifica
                        contemporaneità</a>
                     </li>
                  </ul>
                  <div class="tab-content">
                     <div id="home" class="tab-pane fade in active">
                        <jsp:include page="titoliAnno.jsp" />
                     </div>
                     <div id="contemporaneita" class="tab-pane fade">
                        <jsp:include page="contemporaneita.jsp" />
                     </div>
                     <div id="verifica" class="tab-pane fade">
                        <jsp:include page="verificaContemporaneita.jsp" />
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </form>
   </tiles:putAttribute>
</tiles:insertDefinition>