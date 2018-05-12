<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/x-handlebars-template" id="templateErrore">
<div id="erroreCancellazioneContainer" class="alert alert-danger">
	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
	Siamo spiacenti, si è verificato un errore.
	<br/>
	Ti preghiamo di riprovare più tardi.
</div>
</script>
<script type="text/x-handlebars-template" id="templateContemporaneita">
{{#if modificaSuccesso}}
<div id="erroreCancellazioneContainer" class="alert alert-success">
	<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
	Modifica relazione di contemporaneit&agrave; avvenuta con successo
	<br/>
</div>
{{else}}
<div class="row">
	<div class="form-group col-md-6">
		<label>Quest (*) </label> 
			<div>
				<input id="quest" name="quest" class="form-control" type="text" minlength="2" maxlength="2" data-error="Inserire due caratteri" /> 
 				<div class="help-block with-errors"></div>
		</div>
	</div>
<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Cont (*)</label>
			<div>
				<input id="cont" name="cont" class="form-control" type="text" minlength="2" maxlength="2" data-error="Inserire due caratteri" /> 
				 <div class="help-block with-errors"></div>
			</div>
</div>
{{/if}}
</script>
<script type="text/javascript" charset="UTF-8">
var templateErrore = Handlebars.compile($("#templateErrore").html());
var templateContemporaneita = Handlebars.compile($("#templateContemporaneita").html());
var elencoTitoliAnno = null;
var objSelected = {};
$(function() {
	elencoTitoliAnno = $("#tableDataContemp").DataTable(
					{
						"drawCallback" : function(settings) {
							$('[data-toggle="tooltip"]').tooltip();
						},
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
									"class" : "dettaglioDomanda",
									"name" : "codiceTitolo",
									"targets" : 0,
								},
								{
									"render" : function(data, type,row) {
										if(row.descrizione && row.descrizione !=""){
											return row.descrizione;
										}
									},
									"class" : "dettaglioDomanda",
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
									"class" : "dettaglioDomanda",
									"name" : "unitaMisura",
									"targets" : 2,
								},
								{
									"render" : function(data, type,row) {
										if (row.punti && row.punti !== 0) {
											return row.punti;
										}
										return "";
									},
									"class" : "dettaglioDomanda",
									"name" : "punti",
									"targets" : 3,
								},
								{
									"render" : function(data, type,row) {
										if (row.punteggioMax && row.punteggioMax !== 0) {
											return row.punteggioMax;
										}
										return "0";
									},
									"class" : "dettaglioDomanda",
									"name" : "punteggioMax",
									"targets" : 4,
								},
								{
									"render" : function(data, type,row) {
										if (row.tipo && row.tipo !== 0) {
											return row.tipo;
										}
										return "-";
									},
									"class" : "dettaglioDomanda",
									"name" : "tipo",
									"targets" : 5,
								},
								{
									"render" : function(data, type,row) {
										if (row.obbligatorio && row.obbligatorio !=="") {
											return row.obbligatorio;
										}
										return "-";
									},
									"class" : "dettaglioDomanda",
									"name" : "ore",
									"targets" : 6,
								},
								{
									"render" : function(data, type,row) {
										if (row.ulss && row.ulss !== "") {
											return row.ulss;
										}
										return "-";
									},
									"class" : "dettaglioDomanda",
									"name" : "ulss",
									"targets" : 7,
								}]
					});
	$('#tableDataContemp tbody').on('click','tr',function() {
		if ($(this).closest('tr').hasClass('selectedRow')) {
			$(this).closest('tr').removeClass('selectedRow');
			objSelected = {};
			$('#descTitoloAntag').html('');
			$('#modificaCont').css('display','none');
			$('#warning').css('display','block');
			$('#tab_antag>thead>tr').empty();
			$('#tab_antag>tbody>tr').empty();
		} else {
			$('#tab_antag>thead>tr').empty();
			$('#tab_antag>tbody>tr').empty();
			elencoTitoliAnno.$('tr.selectedRow').removeClass('selectedRow');
			$(this).closest('tr').addClass('selectedRow');
			var tr = $(this).closest('tr');
			var row = elencoTitoliAnno.row(tr);
			var obj = row.data();
			objSelected.titolo = obj.codiceTitolo;
			objSelected.descrizione = obj.descrizione;
			$.ajax({
				url : '<spring:url value="/cont/elencoCont/'+objSelected.titolo+'.json" />',
				dataType : 'json',
				contentType : 'application/json; charset=UTF-8',
				success : function(data) {
					$.each(data.payload, function(index, value) {
						$('#warning').css('display','none');
						$('#descTitoloAntag').html(objSelected.descrizione);
						$("#tab_antag>thead>tr").append("<th>"+value.ques+"</th>");
						$("#tab_antag>tbody>tr").append("<td>"+value.priorita+"</td>");
						$('#modificaCont').css('display','block');
					});
				},
				error : function(data) {
					mostraErrore();
				}
			});
		}
});
$('#modificaCont').click(function(){
	BootstrapDialog.show({
		title : 'Modifica Contemporaneita',
		message : function(dialog) {
			var $modalBody = templateContemporaneita();
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
				autospin : true,
				action : function(dialogRef) {
					dialogRef.enableButtons(false);
					dialogRef.setClosable(false);
					var quest = $('#quest').val();
					var cont = $('#cont').val();
					modificaCont(objSelected.titolo,quest,cont,dialogRef);
				}
			},
			 {
					id : 'annullaConferma',
					label : 'Chiudi',
					action : function(dialogRef) {
						dialogRef.close();
					}
				} ]
	});
});
});
function mostraErrore(){
	modalErrore(templateErrore);
}
function modificaCont(titolo,quest,cont,dialogRef){
	$.ajax({
		url : '<spring:url value="/cont/modificaCont/'+titolo+'/'+quest+'/'+cont+'.json" />',
		dataType : 'json',
		contentType : 'application/json; charset=UTF-8',
		success : function(data) {
			 var codiceEsito = data.codiceOperazione;
             if (codiceEsito == 200) {
                 dialogRef.setClosable(true);
                 dialogRef.getModalFooter().hide();
                 var dati = new Object();
                 dati.modificaSuccesso = true;
                 var htmlDialog = templateContemporaneita(dati);
                 dialogRef.getModalBody().html(htmlDialog);
                 //Ricarico la tabella aggiornata
  				 reloadTabellaContemporaneita();
		}
		},
		error : function(data) {
			mostraErrore();
		}
	});
}
function reloadTabellaContemporaneita(){
    $('#tab_antag>thead>tr').empty();
	$('#tab_antag>tbody>tr').empty();
	$.ajax({
		url : '<spring:url value="/cont/elencoCont/'+objSelected.titolo+'.json" />',
		dataType : 'json',
		contentType : 'application/json; charset=UTF-8',
		success : function(data) {
			$.each(data.payload, function(index, value) {
				$('#warning').css('display','none');
				$('#descTitoloAntag').html(objSelected.descrizione);
				$("#tab_antag>thead>tr").append("<th>"+value.ques+"</th>");
				$("#tab_antag>tbody>tr").append("<td>"+value.priorita+"</td>");
				$('#modificaCont').css('display','block');
			});
		}
	});
}
</script>
<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="bs-panel">
			<div class="panel panel-default panel_padding_l_r">
				<div class="panel-body panel_min_height home_news">
				<h3>TITOLI VALUTATI - TITOLO FISSATO COME ANTAGONISTA</h3>
					<table id="tableDataContemp" style="width:100%;"
						class="datatables-table table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>Cod.</th>
								<th>Titolo</th>
								<th>Un.Mis.</th>
								<th>Punti</th>
								<th>P.Max.</th>
								<th>Tipo</th>
								<th>Obbl.</th>
								<th>ULSS</th>
							</tr>
						</thead>
						</tbody>
					</table>
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
					<h3>TABELLA DELLE CONTEMPORANEIT&Agrave; - TITOLI IN
							QUESTIONE</h3>
							<div class="alert alert-warning" id="warning">
  							<strong>Attenzione!</strong> Seleziona un titolo dalla tabella 'Titoli valutati' per 
  							consultare le contemporaneit&agrave; .
							</div>
							<p id="descTitoloAntag"></p>
							<div class="boxContemp">
								<table id="tab_antag" class="datatables-table table table-bordered table-responsive  " >					
							<thead>	
							<tr>
							</tr>		
							</thead>		
							<tbody >					
							<tr>
							</tr>
							</tbody>
							</table></div>
							<button type="button" id="modificaCont" style="display:none;" class="btn btn-default btn-large button_salva">
							<i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;Modifica</button>
				</div>
			</div>
		</div>
	</div>
</div>
