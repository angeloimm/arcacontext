<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<style>
.form-group {
	margin-bottom: 0px;
}
</style>
<!-- FORM TITOLARITA' -->
<form role="form" id="form_titolarita">
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div class="bs-panel">
				<div class="panel panel-default panel_padding_l_r">
					<div class="panel-body panel_min_height home_news">
						<jsp:include page="anagraficaHeader.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="bs-panel">
			<div class="panel panel-default panel_padding_l_r">
				<div class="panel-body panel_min_height home_news">
					<table id="tableData" style="width:100%;"
						class="table table-striped table-bordered table-hover table-responsive">
						<thead>
							<tr id="addRow">
								<th><i class="fa fa-plus" id="btnAddd1" aria-hidden="true"
									style="color: green;"></i></th>
								<th>Cod</th>
								<th>Titolarit&agrave;</th>
								<th>Periodo dal</th>
								<th>Periodo al</th>
								<th>In reg.</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</form>

<script type="text/x-handlebars-template" id="table">
<script type="text/javascript">
$(document).ready(function(){
$('#codice_titolarita').html(optionsCodTitolarita);
 });
<{{!}}/script>
<div class="row">
	<div class="form-group col-md-12">
		<form role="form" name="frm">
			<label for="codice_titolarita" class="control-label">Titolarità (*)</label> 
				<select id="codice_titolarita" name="codice_titolarita" class="form-control 
				changeRequest show-tick" data-live-search="true">
					<option value="-1">NESSUNA SELEZIONE</option>
				</select>
	</div>
	<div class="form-group col-md-6">
			<label for="codice" class="control-label">Data dal (*)</label> 
				<div class="input-group date datepicker_dal" id="dataNascitaDiv">
					<input id="dataDal" name="data" class="form-control"
					readonly="readonly" type="text" value="" /> <span
					class="input-group-addon"> <span
					class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
	</div>
	<div class="form-group col-md-6 disabled" id="divDal">
		<label for="codice" class="control-label">Data al (*)</label> 
			<div class="input-group date datepicker_al" name="dataNascitaDiv">
				<input id="dataAl" name="data" class="form-control"
				readonly="readonly" type="text" name="al"/> <span
				class="input-group-addon"> <span
				class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
	</div>
	<div class="form-group col-md-6">
		<label for="codice" class="control-label">In reg. (*)</label> 
			<select id="regione" name="select_regione" class="form-control 
			changeRequest show-tick" data-live-search="true">
				<option value="S">SI</option>
				<option value="N">NO</option>
			</select>
		</form>
	</div>
</div>
<script>
$(function() {
		$(".datepicker_dal").datetimepicker({
			format : "DD/MM/YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			ignoreReadonly : true,
			maxDate : 'now',
		}).on('dp.change', function (selected) {
				var minDate = new Date(selected.date.valueOf());
				$('.datepicker_al').datetimepicker('minDate', minDate);
		});
		$(".datepicker_al").datetimepicker({
			format : "DD/MM/YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			ignoreReadonly : true,
			maxDate: 'now',
		});
	});
</script>
<script type="text/x-handlebars-template" id="templateTitolarita">
{{#if cancella}}
	<div id="cancellazioneTitolo" class="alert alert-warning" role="alert">
		<i class="fa fa-trash" aria-hidden="true"></i> Confermi di voler cancellare la titolarità selezionata?
	</div>
{{else if errori}}
	<div id="inserimentoTitoloError" class="alert alert-danger" role="alert">
		<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
	Siamo spiacenti. Si è verificato un errore nell'inserimento della titolarità
</div>
{{else}}
	<div id="inserimentoTitoloError" class="alert alert-success" role="alert">
		<i class="fa fa-check" aria-hidden="true"></i>
		Inserimento titolarit&agrave; effettuato con successo
	</div>
{{/if}}
</script>	
<script>
var titolarita = {};
var tableRow = Handlebars.compile($("#table").html());
var templateTitolarita = Handlebars.compile($("#templateTitolarita").html());
$('#addRow').on( 'click', function () {
			 if(updatable || duplicata)
			 BootstrapDialog.show({
				   title : 'Inserimento titolarità',
							message : function(
									dialog) {
								var $modalBody = tableRow();
								return $modalBody;
							},
			 		onshow: function(dialog) { 
						dialog.getButton('salvaTitolarita').disable();
						},
					onshown: function(dialogRef){
						 $('form[name="frm"] input, select, .datepicker_al, .datepicker_dal').on('keyup change dp.change',function(){
						    validaForm(dialogRef);
						}); 
				        }, 
					size : BootstrapDialog.SIZE_NORMAL,
					type : BootstrapDialog.TYPE_PRIMARY,
					closable : true,
					draggable : false,
					nl2br : false,
					buttons : [{
								id : 'salvaTitolarita',
								icon : 'fa fa-save',
								label : 'Salva',
								cssClass : 'btn-primary',
								autospin : true,
								action : function(dialogRef) {
										dialogRef.enableButtons(false);
										dialogRef.setClosable(false);
										storeRecord(dialogRef); 
										}
								}, {
									id : 'annullaConferma',
									label : 'Annulla',
									cssClass : 'btn-primary',
									icon: 'fa fa-times',
									action : function(dialogRef) {
										dialogRef.close();
						}
				} ]			
				});
});	    
$('#tableData tbody').on('click','td a.cancellaTitolo',function(evt) {
		evt.preventDefault();
		var tr = $(this).closest('tr');
		var row = t.row(tr);
		var datiTitolarita = row.data();
		confermaCancellazioneTitolo(datiTitolarita,row);
});		
storeRecord = function(dialogRef){
		var txt = $('#codice_titolarita').find('option:selected').text();
		var res = txt.split(" - ");
		datiTitolarita = new Object();
		datiTitolarita.descrizione = res[1];
		datiTitolarita.codiceTitolarita = $('#codice_titolarita').val();
		datiTitolarita.dal = $('#dataDal').val();
		datiTitolarita.al = $('#dataAl').val();
		datiTitolarita.regione = $('#regione').val();
		datiTitolarita.anno = datiDomanda.anno;
		datiTitolarita.tipo = datiDomanda.tipo;
		
		var data =  {
			regione: datiTitolarita.regione,
			dataAl: datiTitolarita.al,
			dataDal: datiTitolarita.dal,
			codiceTitolarita: datiTitolarita.codiceTitolarita, 
			codiceDomanda : datiDomanda.codiceDomanda,
			descrizione : datiTitolarita.descrizione,
			anno : datiTitolarita.anno,
			tipo: datiTitolarita.tipo
		};
		$.ajax({
			url : '<spring:url value="/gradDomanda/addTitolarita.json" />',
 			dataType : 'json', 
			type : 'POST',
			data : JSON.stringify(data),
		 	contentType : 'application/json; charset=UTF-8', 
			success : function(data) {
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				var htmlDialog = templateTitolarita(dati);
				dialogRef.getModalBody().html(htmlDialog);
				t.ajax.reload();
			},
			error : function(data) {
				mostraErroreInserimento(dialogRef);
			}
		});
}		
function confermaCancellazioneTitolo(datiTitolarita,row) {
		BootstrapDialog.show({
				title : 'Cancellazione titolo',
				message : function(dialog) {
						var dati=new Object();
						dati.cancella = true;
						var $modalBody = templateTitolarita(dati);
						return $modalBody;
				},
				size : BootstrapDialog.SIZE_NORMAL,
				type : BootstrapDialog.TYPE_PRIMARY,
				closable : true,
				draggable : false,
				nl2br : false,
				buttons : [{
							id : 'conferma',
							icon : 'fa fa-trash-o',
							label : 'Conferma',
							cssClass : 'btn-primary',
							autospin : true,
							action : function(dialogRef) {
								dialogRef.enableButtons(false);
								dialogRef.setClosable(false);
								cancellaRiga(row,dialogRef);
							}
							}, {
								id : 'annullaConferma',
								label : 'Annulla',
								action : function(dialogRef) {
								dialogRef.close();
							}
							}]
				});
}
// Cancella la riga dalla tabella		
function cancellaRiga(row,dialogRef){
	// Recupero il codice dalla riga selezionata
	var codiceTitolo = row.data().codiceTitolarita;
	$.ajax({
		url : '<spring:url value="/gradDomanda/removeTitolarita/'+codiceTitolo+'/'+datiDomanda.codiceDomanda+'.json" />',
		dataType : 'json',
		contentType : 'application/json; charset=UTF-8',
		type : 'DELETE',
	 	contentType : 'application/json; charset=UTF-8', 
		success : function(data) {
			row.remove().draw();
			dialogRef.close();
		},
		error : function(data) {
			mostraErroreInserimento(dialogRef);
		}
	});

}
// Aggiunge il cursore all'hover sul th contenente il '+''
$('#tableData #addRow').hover(function() {
	$(this).css('cursor','pointer');
});
function mostraErroreInserimento(dialogRef) {
	dialogRef.setClosable(true);
	dialogRef.getModalFooter().hide();
	var dati = new Object();
	dati.errori = true;
	var htmlDialog = templateTitolarita(dati);
	dialogRef.getModalBody().html(htmlDialog);
	setTimeout(function() {
		dialogRef.close();
	}, 5000);
}
function validaForm(dialogRef){
	var dal = $('#dataDal').val();
	if(dal !== "")
	{
		$('#divDal').removeClass('disabled');
	}
	var al = $('#dataAl').val();
	var codiceTit = $('#codice_titolarita').val();
	if((dal !="" && al !="") && codiceTit !="-1"){
		dialogRef.getButton('salvaTitolarita').enable();
	}else{
		dialogRef.getButton('salvaTitolarita').disable();
	}
}
var optionsCodTitolarita = null; 
$('.nav-tabs a[href="#menu3"]').on('click',function(evt) {
	$('#codiceFunzione').val('F_INDSOM');
	loadSelectCodTitolarita();
});
function loadSelectCodTitolarita(){
	if(duplicata)
	{
		datiDomanda.anno = ${sessionScope.anno};
		datiDomanda.tipo = '${sessionScope.tipoGraduatoria}';
	}
	$.ajax({
		url : '<spring:url value="/gradDomanda/titolarita/'+datiDomanda.anno+'/'+datiDomanda.tipo+'.json" />',
		contentType : 'application/json; charset=UTF-8',
		type : 'GET',
		success : function(data) 
		{
			options = "";
			$.each(data.payload, function(key, value) {
				titolarita[value.codice] = value.descrizione;
				options += "<option  value='" + value.codice + "'>" +value.codice + " - "+ value.descrizione + '</option>';
			}); 
			optionsCodTitolarita = options;
			if ( ! $.fn.DataTable.isDataTable( '#tableData' ) ) {
			t = $('#tableData').DataTable(
					{
						"drawCallback": function( settings ) {
							  $('[data-toggle="tooltip"]').tooltip();
						},
						"paging": false, 
						"info": false,
						"bFilter" : false,
						"bSort": false,
						"processing" : true,
						"serverSide" : true,
						"mark" : true,
						"responsive" : true,
						"language" : {"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'},
						"ajax" : {
							"url" : '<spring:url value="/gradDomanda/titolaritaPres/'+datiDomanda.codiceDomanda+'/'+datiDomanda.anno+'/'+datiDomanda.tipo+'.json" />',
							"dataSrc" : "payload"
						},
						"columnDefs" : [
							{   "render" : function(data, type, row) {
								if (updatable || duplicata) {
									return '<a href="#" class="cancellaTitolo" data-toggle="tooltip" title="Cancella titolarit&agrave;"><i class="fa fa-times red" aria-hidden="true"></i></a>'
								}else{
									return '<span data-toggle="tooltip" title="Concorso chiuso! Impossibile editare la domanda."><a href="#" class="cancellaTitolo disabled"><i class="fa fa-times red" aria-hidden="true"></i></a></span>'
								}

							},
								"name" : "",
								"targets" : 0,
							},
							{
								"render" : function(data, type, row) {
								if (row.codiceTitolarita && row.codiceTitolarita !== 0) {
									return row.codiceTitolarita;
								}
								return "";
							},
								"name" : "id.ttlrTitolarita",
								"targets" : 1,
							},
							{
								"render" : function(data, type, row) {
								return titolarita[row.codiceTitolarita];
							},
								"name" : "descrizione",
								"targets" : 2,
							},
							{
								"render" : function(data, type, row) {
									if (row.dataDal && row.dataDal !== 0) {
										return moment(row.dataDal).format("DD/MM/YYYY");
									}
									return "";
								},
								"name" : "domaNominativo",
								"targets" : 3,
							},
							{
								"render" : function(data, type, row) {
									if (row.dataAl && row.dataAl !== 0) {
										return moment(row.dataAl).format("DD/MM/YYYY");
									}
									return "";
								},
								"name" : "domaCodfisc",
								"targets" : 4,
							},
							{
								"render" : function(data, type, row) {
									if (row.regione && row.regione !=="") {
										return row.regione;
									}
									return "";
								},
								"name" : "domaNasData",
								"targets" : 5,
							}]
					}		
					);
			}
		},
		});
}
</script>