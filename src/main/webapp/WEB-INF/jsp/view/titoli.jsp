<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.form-group {
	margin-bottom: 0px;
}
</style>
<!-- FORM TITOLI -->
<form role="form" id="form_titoli">
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
						<div class="panel panel-default panel_padding_l_r">
							<div class="bootpag-centre">
								<p class="elencoTitoli"></p>
							</div>
							<div class="panel-body panel_min_height home_news">
								<div
									class="panel panel-default panel_padding_l_r panel_min_height positionTable">
									<div class="panel-body home_news">
										<p class="contenutoTitoli">
										</p>
										<table id="tabellaLaurea" style="width:100%;"
											class="table table-striped table-bordered table-hover table-responsive margin10">
											<thead>
											<tr>
											<th>Voto</th>
											<th>Voto Massimo</th>
											<th>Lode</th>
											<th>Data</th>
											</tr>
											</thead>
											<tbody>
											<tr>
											<td id="tdVoto"></td>
											<td id="tdVotoMax"></td>
											<td id="tdLode"></td>
											<td id="tdData"></td>
											</tr>
											</tbody>
											</table>
											<table id="tableDataTitoli" style="width:100%"
											class="table table-striped table-bordered table-hover table-responsive margin10">
											<thead>
											<tr id="addRowTitoli">
											<th><i class="fa fa-plus" id="btnAddd1" aria-hidden="true"
											style="color: green;"></i></th>
											<th>Prog.</th>
											<th>Anno</th>
											<th>Mese</th>
											<th>Dal</th>
											<th>Al</th>
											<th>Ore</th>
											<th>Albo</th>
											<th>Periodo dal</th>
											<th>Periodo al</th>
											<th>Decreto</th>
											<th>Sind</th>
											<th>Numero</th>
											<th>Codice ULSS</th>
											<th>Codice specializz.</th>
											<th>Descrizione titolo</th>
											<th>Utenti</th>
											</tr>
											</thead>
											<tbody>
											
											</tbody>
											</table>
									</div>
								</div>
							</div>
						</div>
						<input type="hidden" id="id_titolo">
						<input type="hidden" id="form_titolo">
				</div>
			</div>
		</div>
	</div>
</form>
<div class="divOver">
	<div class="row">
		<div class="col-sm-12">
			<button type="submit" class="btn btn-default btn-large button_salva"
				id="validaDomanda">
				<i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp;Valida
			</button>
		</div>
	</div>
</div>
<script type="text/x-handlebars-template" id="formTitoli">
<form role="form" name="aggTit">
{{#if form1}}
<div class="row">
	<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Periodo dal (*)</label>
			<div class="input-group date datepicker_periodoDal">
				<input id="periodoDal" name="periodoDal" class="form-control" required readonly="readonly"
				type="text" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
	</div>
	<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Periodo al (*)</label>
			<div class="input-group date datepicker_periodoAl disabled" id="periodoAlDiv">
				<input id="periodoAl" name="periodoAl" class="form-control" required readonly="readonly"
				type="text" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
	</div>
	<div class="error-block red text_center" style="display:none;margin:1%;" id="error">
	<strong>Attenzione!</strong>
	Non puoi inserire un titolo con data fine superiore alla data della domanda
	</div>
{{else if form2}}
<div class="row">
	<div class="form-group col-md-8">
		<label >Codice specializzazione (*)</label> 
			<div>
				<select id = "codSpecTitolo" class="form-control selectpicker  col-md-6" data-live-search="true">
					<option value="">Seleziona un elemento</option>
					{{#each spec}}
					<option value="{{codice}}">{{codice}} - {{descrizione}}</option>
					{{/each}}
				</select>
			</div>
			</div>
	<div class="form-group col-md-4">
		<label >Decreto</label> 
			<div>
				<input type="checkbox" name="decreto" value="N" id="decreto">
			</div>
	</div>
</div>
{{else if form3}}
<div class="row">
	<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Anno (*)</label>
			<div class="input-group date datepicker_anno">
				<input id="annoTitol" name="annoTitol" class="form-control" required readonly="readonly"
				type="text" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
	</div>
	<div class="form-group col-md-6">
		<label >Giorno dal (*)</label> 
			<div>
				<input id="dataDal" name="dataDal" class="form-control" type="text" value="{{dal}}" maxlength="2" data-error="Inserire non più di 2 caratteri"/> 
			</div>
	</div>
	<div class="form-group col-md-6">
    	<label >Giorno al (*)</label> 
			<div>
				<input id="dataAl" name="dataAl" class="form-control" type="text" value="{{al}}"  
				maxlength="2" data-error="Inserire non più di 2 caratteri" /> 
			</div>
	</div>
	<div class="form-group col-md-6">
		<label >Ore (*)</label> 
			<div>
				<input id="ore" name="ore" class="form-control" type="text" value="{{ore}}"
				maxlength="3" data-error="Inserire al massimo 3 caratteri" /> 
			</div>
	</div>
	<c:set var="mesi" value="${fn:split('Gennaio,Febbraio,Marzo,Aprile,
		Maggio,Giugno,Luglio,Agosto,Settembre,Ottobre,Novembre,Dicembre', ',')}"
 			scope="application" />
<div class="row">
	<div class="form-group col-md-12">
		<div class="form-group col-md-6">
			<label>Mese (*)</label> 
				<div>
					<select name="mese" class="form-control" id="mese">
						<c:forEach items="${mesi}" var="mese" varStatus="loop">
							<option value="${loop.index+1}">${mese}</option>
						</c:forEach>
					</select>
				</div>
		</div>
	</div>
{{else if form4}}
<div class="row">
	<div class="form-group col-md-6">
		<label >Numero (*)</label> 
	<div>
		<input id="numero" name="numero" class="form-control" type="text" maxlength="4" 
			value="{{numero}}" data-error="Inserire al massimo 3 caratteri" /> 
	</div>
</div>
</div>
{{else if form5}}
<div class="row">
	<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Periodo dal (*)</label>
			<div class="input-group date datepicker_periodoDal">
				<input id="periodoDal" name="periodoDal" class="form-control" required readonly="readonly"
				type="text" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
	</div>
	<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Periodo al (*)</label>
			<div class="input-group date datepicker_periodoAl disabled" id="periodoAlDiv">
				<input id="periodoAl" name="periodoAl" class="form-control" required readonly="readonly"
				type="text" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
	</div>
	<div class="form-group col-md-6">
		<label> Sind.</label> 
			<div>
				<input type="checkbox" name="sind" value="N" id="sind">
			</div>
	</div>
	<div class="form-group col-md-6">
		<label >Utenti</label> 
			<div>
				<input type="checkbox" name="decreto" value="N" id="decreto">
		</div>
	</div>
	<div class="error-block red text_center" style="display:none;margin:1%;" id="error">
		<strong>Attenzione!</strong>
		Non puoi inserire un titolo con data fine superiore alla data della domanda
	</div>
</div>
{{else if form6}}
<div class="row">
	<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Periodo dal (*)</label>
			<div class="input-group date datepicker_periodoDal">
			<input id="periodoDal" name="periodoDal" class="form-control" required readonly="readonly"
			type="text" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
			</span>
	</div>
</div>
	<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Periodo al (*)</label>
			<div class="input-group date datepicker_periodoAl disabled" id="periodoAlDiv">
				<input id="periodoAl" name="periodoAl" class="form-control" required readonly="readonly"
				type="text" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
	</div>
	<div class="form-group col-md-6">
		<label>Codice ULSS </label> 
			<div>
				<input id="ulssAzienda" name="ulssAzienda" class="form-control" type="text" 
				minlength="3" maxlength="3" value="{{ulssAzienda}}" data-error="Inserire tre caratteri" /> 
			<div class="help-block with-errors"></div>
	</div>
	<div class="error-block red text_center" style="display:none;margin:1%;" id="error">
	<strong>Attenzione!</strong>
	Non puoi inserire un titolo con data fine superiore alla data della domanda
	</div>
</div>
{{else if form7}}
<div class="row">
	<div class="form-group col-md-12">
		<label>Descrizione specializzazione (*)</label> 
			<div>
				<textarea rows="2" cols="50" id="pdDescrizione" name="pdDescrizione" class="form-control" readonly/>
	</div>
</div>
	<div class="form-group col-md-6">
		<label >Decreto</label> 
			<div>
				<input type="checkbox" name="decreto" value="N" id="decreto">
			</div>
	</div>
</div>
{{else if form8}}
<div class="row">
	<div class="form-group col-md-6">
		<label>Albo provinciale (*) </label> 
			<div>
				<input id="albo" name="albo" class="form-control" type="text" value="{{albo}}" 
				minlength="2" maxlength="2" data-error="Inserire due caratteri" /> 
				<div class="help-block with-errors"></div>
			</div>
	</div>
	<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Periodo dal (*)</label>
			<div class="input-group date datepicker_periodoDal">
				<input id="periodoDal" name="periodoDal" class="form-control" required readonly="readonly"
				type="text" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
	</div>
</div>
<div class="row">
	<div class="form-group col-md-6">
		<label for="annoTitol" class="control-label"> Periodo al (*)</label>
			<div class="input-group date datepicker_periodoAl disabled" id="periodoAlDiv">
				<input id="periodoAl" name="periodoAl" class="form-control" required readonly="readonly"
				type="text" /><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
				</span>
			</div>
	</div>
</div>
<div class="error-block red text_center" style="display:none;margin:1%;" id="error">
	<strong>Attenzione!</strong>
	Non puoi inserire un titolo con data fine superiore alla data della domanda
</div>
{{/if}}
</form>
<script>
$(function () {
	$('.selectpicker').selectpicker();
    $(".datepicker_anno").datetimepicker({
        format: "YYYY",
        showClose: true,
        locale: 'it',
        showClear:true,
		ignoreReadonly : true,
		minDate : new Date(datiDomanda.abilitazioneAnno)
    });
	$(".datepicker_periodoDal").datetimepicker({
		format : "DD/MM/YYYY",
		showClose : true,
		locale : 'it',
		showClear : true,
		ignoreReadonly : true,
		useCurrent: false
	}).on('dp.change', function (selected) {
		if(selected.date)
		{
			var minDate = new Date(selected.date.valueOf());
			$('.datepicker_periodoAl').datetimepicker('minDate', minDate);
		}
		else if($('#periodo').val() !=="")
		{
			
		}
		else
		{
			$("#periodoAlDiv input").val('');
		}
	});
	$(".datepicker_periodoAl").datetimepicker({
		format : "DD/MM/YYYY",
		showClose : true,
		locale : 'it',
		showClear : true,
		ignoreReadonly : true,
		useCurrent: false
	});
	$('#pdDescrizione').val($(".contenutoTitoli").html());
});
$('#decreto').click(function() {	    	
    if($('#decreto').prop('checked')){	
        	$('#decreto').val('S');
    	}else{
    	 	$('#decreto').val('N');    
    	}
	});	
$('#sind').click(function() {	       	
    if($('#sind').prop('checked')){	
        	$('#sind').val('S');
    	}else{
    	 	$('#sind').val('N');    
    	}
	});
<{{!}}/script>
</script>
<script type="text/x-handlebars-template" id="templateTitolo">
{{#if cancella}}
	<div id="cancellazioneTitolo" class="alert alert-warning" role="alert">
		<i class="fa fa-trash" aria-hidden="true"></i> Confermi di voler cancellare il titolo selezionato?
	</div>
{{/if}}
{{#if errori}}
	<div id="inserimentoTitoloError" class="alert alert-danger" role="alert">
		<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
		Siamo spiacenti. Si è verificato un errore nell'inserimento del titolo
	</div>
{{/if}}
{{#if erroriModifica}}
	<div id="inserimentoTitoloError" class="alert alert-danger" role="alert">
		<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
		Siamo spiacenti. Si è verificato un errore nella modifica del titolo
	</div>
{{/if}}
{{#if insertSuccess}}
	<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
		Inserimento titolo avvenuto con successo.
	</div>
{{/if}}
{{#if modificaSuccess}}
	<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
		Modifica titolo avvenuta con successo.
	</div>
{{/if}}
{{#if successDelete}}
	<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
		Eliminazione titolo eseguita correttamente.
	</div>
{{/if}}
{{#if erroreValidazione}}
	<div id="inserimentoTitoloError" class="alert alert-danger" role="alert">
		<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
		Siamo spiacenti. Si è verificato un errore nella procedura di validazione.
	</div>
{{/if}}
{{#if validazione}}
	<div id="inserimentoTitoloError" class="alert alert-danger" role="alert">
		{{#each erroriValidazione}}
			<p> - {{this}}</p>
		{{else}}
		La domanda non presenta irregolarit&agrave;
		{{/each}}
	</div>
{{/if}}
{{#if sovrapposizione}}
	<div id="cancellazioneTitolo" class="alert alert-warning" role="alert">
		{{#each array}}
			- Il titolo <strong>{{this}}</strong> &egrave; in sovrapposizione con <i>l'attivit&agrave; formativa</i>.<br>
		{{/each}}
	</div>
	<small>Contatta il medico per la scelta ai fini del calcolo del punteggio</small>
{{/if}}
{{#if intersezione}}
	<div id="cancellazioneTitolo" class="alert alert-warning" role="alert">
		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i><strong>&nbsp; Attenzione</strong>
		Titolo non inserito. Hai gi&agrave; presentato un titolo per il medesimo intervallo temporale.
	</div>
{{/if}}
</script>
<script>
var templateTitolo = Handlebars.compile($("#templateTitolo").html());
var formTitoli = Handlebars.compile($("#formTitoli").html());
var bootpag = null;
// Inizializzazione dataTable
var tTitoli = null;
var listaSpec = new Object();
$('#addRowTitoli').on( 'click', function () {
	   if(updatable || duplicata)
	   BootstrapDialog.show({
	   title : 'Inserimento titoli',
				message : function(dialog){
					var dati = new Object();
					var form_titolo = $('#form_titolo').val();
					var tit = $('#id_titolo').val();
					if(form_titolo==1){
						if(tit =="2" || tit=="3")
						{
							dati.form8 = true;
						}
						else if(tit =="14"){
							dati.form6 = true;
						}
						else
						{
							dati.form1 = true;
						}
					}
					if(form_titolo==2){
						dati.form2 = true;
						caricaElencoSpec(tit).then(function(response){
							$.each(response.payload, function(key, value) {
								listaSpec[value.codice]=value;
							});
						});
						dati.spec = listaSpec;
						
					}
					if(form_titolo==3){
						dati.form3 = true;
					}
					if(form_titolo==4){
						dati.form4 = true;
					}
					if(form_titolo==5){
						dati.form5 = true;
					}
					if(form_titolo==7){
						dati.form7 = true;
					}
					var $modalBody = formTitoli(dati);
					return $modalBody;
				},
				onshow: function(dialog) {
					var id_titolo = $('#id_titolo').val();
					if(id_titolo !=="6" || datiDomanda.tipo!=="PD")
						dialog.getButton('confermaTitoli').disable();
					},
			 	onshown: function(dialogRef){
					 $('form[name="aggTit"] input, select, .datepicker_periodoDal, .datepicker_periodoAl').on('keyup change dp.change',function(){
					    validaFormTitolo(dialogRef);
					}); 
			        },  
		size : BootstrapDialog.SIZE_NORMAL,
		type : BootstrapDialog.TYPE_PRIMARY,
		closable : true,
		draggable : false,
		nl2br : false,
		buttons : [{
					id : 'confermaTitoli',
					icon : 'fa fa-save',
					label : 'Salva',
					cssClass : 'btn-primary',
					autospin : true,
					action : function(dialog) {
							dialog.enableButtons(false);
							dialog.setClosable(false);
							storeTitolo(dialog);
							}
					}, {
						id : 'annullaConfermaTitoli',
						label : 'Annulla',
						cssClass : 'btn-primary',
						icon: 'fa fa-times',
						action : function(dialog) {
						dialog.close();
			}
	}]			
	});
});
$('#tableDataTitoli tbody').on('click','td a.cancellaTitolo',function(evt) {
		evt.preventDefault();
		var tr = $(this).closest('tr');
		var row = tTitoli.row(tr);
		var datiTitolo = row.data();
		confermaCancellazioneTitoli(row,datiTitolo.progressivoTitolo);
});
$('#tableDataTitoli tbody').on('click','tr .editTitolo',function(evt) {
	evt.preventDefault();
	var tr = $(this).closest('tr');
	var row = tTitoli.row(tr);
	var datiTitolo = row.data();
	openModalModificaTitolo(datiTitolo); 
});	
function openModalModificaTitolo(datiTitolo){
	if(updatable || duplicata){
	var anno = datiDomanda.anno;
	var tipo = datiDomanda.tipo;
	var prog = datiTitolo.progressivoTitolo;
	var domanda = datiDomanda.codiceDomanda;
	var codiceTitolo = $('#id_titolo').val();
	$.ajax({
		type : 'GET',
		url : '<spring:url value="/gradDomanda/findTitoloPres/'+anno+'/'+tipo+'/'+domanda+'/'+prog+'/'+codiceTitolo+'.json" />',
		contentType : 'application/json; charset=UTF-8',
		dataType : 'json',
		success : function(data) 
		{
			BootstrapDialog.show({
				title : 'Modifica titolo',
				message : function(dialog){
					var dati = new Object();
					dati.albo = data.payload.alboProv;
					dati.numero = data.payload.numero;
					dati.ore = data.payload.ore;
					dati.dal = data.payload.dal;
					dati.al = data.payload.al;
					dati.ulssAzienda = data.payload.ulssAzienda;
					var form_titolo = $('#form_titolo').val();
					var tit = $('#id_titolo').val();
					if(form_titolo==1){
						if(tit =="2" || tit=="3")
						{
							dati.form8 = true;
						}
						else if(tit =="14"){
							dati.form6 = true;
						}
						else
						{
							dati.form1 = true;
						}
					}
					if(form_titolo==2){
						dati.form2 = true;
						caricaElencoSpec(tit).then(function(response){
							$.each(response.payload, function(key, value) {
								listaSpec[value.codice]=value;
							});
						});
						dati.spec = listaSpec;
						
					}
					if(form_titolo==3){
						dati.form3 = true;
					}
					if(form_titolo==4){
						dati.form4 = true;
					}
					if(form_titolo==5){
						dati.form5 = true;
					}
					if(form_titolo==7){
						dati.form7 = true;
					}
					var $modalBody = formTitoli(dati);
					return $modalBody;
				},
			 	onshown: function(dialogRef){
			 		if(data.payload.mese !==null)
			 			setMese(data.payload.mese);
			 		if(data.payload.specializzazione !==null){
			 			$("#codSpecTitolo option[value='']").remove();
			 			$select = $('#codSpecTitolo');
						$select.prepend("<option value='"+data.payload.specializzazione+"' selected='selected'>"+data.payload.specializzazione+" - " +listaSpec[data.payload.specializzazione].descrizione+"</option>");
						$select.selectpicker('refresh'); 
			 		}
					$('#periodoAlDiv').removeClass('disabled');
			 		$('#periodoDal').val(data.payload.periodoDal);
			 		$('#periodoAl').val(data.payload.periodoAl);
			 		$('#annoTitol').val(data.payload.anno);
			 		if(data.payload.flag1=="S"){
						$('#decreto').prop('checked', true);
					}
					if(data.payload.flag2=="S"){
						$('#sind').prop('checked', true);
					}
					 $('form[name="aggTit"] input, select, .datepicker_periodoDal, .datepicker_periodoAl').on('keyup change dp.change',function(){
						 validaFormTitolo(dialogRef);
					}); 
			        },  
				size : BootstrapDialog.SIZE_NORMAL,
				type : BootstrapDialog.TYPE_PRIMARY,
				closable : true,
				draggable : false,
				nl2br : false,
				buttons : [{
							id : 'confermaTitoli',
							icon : 'fa fa-trash-o',
							label : 'Conferma',
							cssClass : 'btn-primary',
							autospin : true,
							action : function(dialog) {
								dialog.enableButtons(false);
								dialog.setClosable(false);
								storeTitoloModificato(dialog,prog);
							}
							}, {
								id : 'annullaConfermaTitoli',
								label : 'Annulla',
								action : function(dialog) {
								dialog.close();
							}
							}]
				});
		}
   });
}
}
storeTitolo = function(dialog){
		datiTitolo = new Object();
		datiTitolo.anno = $('#annoTitol').val();
		datiTitolo.mese= $('#mese').val();
		datiTitolo.dal = $('#dataDal').val();
		datiTitolo.al = $('#dataAl').val();
		datiTitolo.ore = $('#ore').val();
		datiTitolo.codiceTitolo = $('#id_titolo').val();
		datiTitolo.flag1 = $('#decreto').val();
		datiTitolo.flag2 = $('#sind').val();
		datiTitolo.alboProv = $('#albo').val();
		datiTitolo.periodoDal = $('#periodoDal').val();
		datiTitolo.periodoAl = $('#periodoAl').val();
		datiTitolo.numero = $('#numero').val();
		datiTitolo.codSpec = $('#codSpecTitolo').val();
		datiTitolo.ulssAzienda = $('#ulssAzienda').val();
		datiTitolo.specializzazione = $('#codSpecTitolo').val();
		datiTitolo.descrizione = $('#pdDescrizione').val();
		datiTitolo.codiceDomanda = datiDomanda.codiceDomanda;
		datiTitolo.idAnno = datiDomanda.anno;
		datiTitolo.idTipo =  datiDomanda.tipo;
		
		$.ajax({
			url : '<spring:url value="/gradDomanda/addTitolo.json" />',
 			dataType : 'json', 
			type : 'POST',
			data : JSON.stringify(datiTitolo),
		 	contentType : 'application/json; charset=UTF-8', 
			success : function(data) {
				datiTitolo.anno = datiTitolo.anno != undefined ? datiTitolo.anno : "${sessionScope.anno}";
				tTitoli.ajax.reload();
				if(data.codiceOperazione == 200)
				{
					if(data.payload.ids.length>0){
						dialog.setClosable(true);
						dialog.getModalFooter().hide();
						var dati = new Object();
						dati.array = data.payload.ids;
						dati.sovrapposizione = true;
						dati.insertSuccess = true;
						var htmlDialog = templateTitolo(dati);
						dialog.getModalBody().html(htmlDialog);
					}
					else
					{	
						dialog.setClosable(true);
						dialog.getModalFooter().hide();
						var dati = new Object();
						dati.insertSuccess = true;
						var htmlDialog = templateTitolo(dati);
						dialog.getModalBody().html(htmlDialog);
					}
				}
				else
				{
					dialog.setClosable(true);
					dialog.getModalFooter().hide();
					var dati = new Object();
					dati.intersezione = true;
					var htmlDialog = templateTitolo(dati);
					dialog.getModalBody().html(htmlDialog);
				}
					
			},
			error : function(data) {
				mostraErroreInserimento(dialog);
			}
		});
}
storeTitoloModificato = function(dialog,prog){
	datiTitolo = new Object();
	datiTitolo.anno = $('#annoTitol').val();
	datiTitolo.mese= $('#mese').val();
	datiTitolo.dal = $('#dataDal').val();
	datiTitolo.al = $('#dataAl').val();
	datiTitolo.ore = $('#ore').val();
	datiTitolo.codiceTitolo = $('#id_titolo').val();
	datiTitolo.flag1 = $('#decreto').val();
	datiTitolo.flag2 = $('#sind').val();
	datiTitolo.alboProv = $('#albo').val();
	datiTitolo.periodoDal = $('#periodoDal').val();
	datiTitolo.periodoAl = $('#periodoAl').val();
	datiTitolo.numero = $('#numero').val();
	datiTitolo.codSpec = $('#codSpecTitolo').val();
	datiTitolo.ulssAzienda = $('#ulssAzienda').val();
	datiTitolo.specializzazione = $('#codSpecTitolo').val();
	datiTitolo.descrizione = $('#pdDescrizione').val();
	datiTitolo.codiceDomanda = datiDomanda.codiceDomanda;
	datiTitolo.idAnno = datiDomanda.anno;
	datiTitolo.idTipo =  datiDomanda.tipo;
	datiTitolo.progressivoTitolo = prog;
	
	$.ajax({
		url : '<spring:url value="/gradDomanda/modificaTitolo.json" />',
			dataType : 'json', 
		type : 'POST',
		data : JSON.stringify(datiTitolo),
	 	contentType : 'application/json; charset=UTF-8', 
		success : function(data) {
			datiTitolo.anno = datiTitolo.anno != undefined ? datiTitolo.anno : "${sessionScope.anno}";
			tTitoli.ajax.reload();
			if(data.codiceOperazione == 200)
			{
				if(data.payload.ids.length>0){
					dialog.setClosable(true);
					dialog.getModalFooter().hide();
					var dati = new Object();
					dati.array = data.payload.ids;
					dati.sovrapposizione = true;
					dati.insertSuccess = true;
					var htmlDialog = templateTitolo(dati);
					dialog.getModalBody().html(htmlDialog);
				}
				else
				{	
					dialog.setClosable(true);
					dialog.getModalFooter().hide();
					var dati = new Object();
					dati.modificaSuccess = true;
					var htmlDialog = templateTitolo(dati);
					dialog.getModalBody().html(htmlDialog);
				}
			}
			else
			{
				dialog.setClosable(true);
				dialog.getModalFooter().hide();
				var dati = new Object();
				dati.intersezione = true;
				var htmlDialog = templateTitolo(dati);
				dialog.getModalBody().html(htmlDialog);
			}
				
		},
		error : function(data) {
			mostraErroreModifica(dialog);
		}
	});
}
function confermaCancellazioneTitoli(row,progressivoTitolo) {
		BootstrapDialog.show({
				title : 'Cancellazione titolo',
				message : function(dialog) {
						var dati = new Object();
						dati.cancella = true;
						var $modalBody = templateTitolo(dati);
						return $modalBody;
				},
				size : BootstrapDialog.SIZE_NORMAL,
				type : BootstrapDialog.TYPE_PRIMARY,
				closable : true,
				draggable : false,
				nl2br : false,
				buttons : [{
							id : 'confermaTitoli',
							icon : 'fa fa-trash-o',
							label : 'Conferma',
							cssClass : 'btn-primary',
							autospin : true,
							action : function(dialog) {
								dialog.enableButtons(false);
								dialog.setClosable(false);
								cancellaRigaTitolo(row,dialog);
							}
							}, {
								id : 'annullaConfermaTitoli',
								label : 'Annulla',
								action : function(dialog) {
								dialog.close();
							}
							}]
				});
}
function mostraErroreInserimento(dialogRef) {
	dialogRef.setClosable(true);
	dialogRef.getModalFooter().hide();
	var dati = new Object();
	dati.errori = true;
	var htmlDialog = templateTitolo(dati);
	dialogRef.getModalBody().html(htmlDialog);
}
function mostraErroreModifica(dialogRef) {
	dialogRef.setClosable(true);
	dialogRef.getModalFooter().hide();
	var dati = new Object();
	dati.erroriModifica = true;
	var htmlDialog = templateTitolo(dati);
	dialogRef.getModalBody().html(htmlDialog);
}
// Cancella la riga dalla tabella		
function cancellaRigaTitolo(row,dialog){
	var codiceTit=$('#id_titolo').val();
  	var progTitolo = row.data().progressivoTitolo;
	$.ajax({
		url : '<spring:url value="/gradDomanda/removeTitolo/'+datiDomanda.anno +'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'/'+progTitolo+'.json" />',
		dataType : 'json',
		contentType : 'application/json; charset=UTF-8',
		type : 'DELETE',
	 	contentType : 'application/json; charset=UTF-8', 
		success : function(data) {
			row.remove().draw();
			dialog.setClosable(true);
			dialog.getModalFooter().hide();
			var dati = new Object();
			dati.successDelete = true;
			var htmlDialog = templateTitolo(dati);
			dialog.getModalBody().html(htmlDialog);
		},
		error : function(data) {
			mostraErroreInserimento(dialog);
		}
	});
}
// Aggiunge il cursore all'hover sul th contenente il '+''
$('#tableDataTitoli #addRowTitoli').hover(function() {
	$(this).css('cursor','pointer');
});
$('.nav-tabs a[href="#menu4"]').on('click',function(evt) {
	evt.preventDefault();
	$('#codiceFunzione').val('F_INSDOM');
	if(bootpag !==null){
		$('.elencoTitoli').bootpag({
			page :1
		});
		$('#tabellaLaurea').show();
	}
	if(duplicata)
	{
		datiDomanda.anno = ${sessionScope.anno};
		datiDomanda.tipo = '${sessionScope.tipoGraduatoria}';
	}
	$.ajax({
		url : '<spring:url value="/gradDomanda/titoli/'+datiDomanda.anno+'/'+datiDomanda.tipo+'.json" />',
		contentType : 'application/json; charset=UTF-8',
		type : 'GET',
		success : function(data) 
		{
			setFirstDatatable();
			var map = {};
			if(data.payload[0].descrizione !=="LAUREA IN MEDICINA GENERALE E CHIRURGIA"){
			var firstObject = new Object();
			firstObject.anno = data.payload[0].anno;
			firstObject.tipo = data.payload[0].tipo;
			map[1] = firstObject;
		}
			$.each(data.payload, function(index, value) {
				var myObject=new Object();
				myObject.anno=value.anno;
				myObject.tipo=value.tipo;
				myObject.descrizioneBreve = value.descrizioneBreve;
				myObject.descrizione = value.descrizione;
				myObject.codice=value.codice;
				myObject.tipoForm = value.tipoForm;
				if(data.payload[0].descrizione !=='LAUREA IN MEDICINA GENERALE E CHIRURGIA'){
				map[countBootpag]=myObject;
				countBootpag++;
			}else{
				map[index+1] = myObject;
			}
			});
			 bootpag = $('.elencoTitoli').bootpag({
			    total: Object.keys(map).length,
			    maxVisible: ${numeroMassimoRecord},
			    leaps: true,
			    first: '←',
			    last: '→',
			    wrapClass: 'pagination',
			    activeClass: 'active',
			    disabledClass: 'disabled',
			    nextClass: 'next',
			    prevClass: 'prev',
			    lastClass: 'last',
			    firstClass: 'first'
			}).on("page", function(event, num){
				$('#tabellaLaurea').hide();
				// Al click sulla pagina nascondo la tabella per evitare che venga visualizzata la rimozione delle colonne
				$('#tableDataTitoli').hide();
			    $(".contenutoTitoli").html(map[num].descrizione); 
			    $('#id_titolo').val(map[num].codice);
			    $('#form_titolo').val(map[num].tipoForm);
			    if(num==16 || num==15 || num==31)
			    	reloadBootpag(map);
			    var codiceTitolo = map[num].codice;
			    var codiceDomanda = datiDomanda.codiceDomanda;
			    if(codiceTitolo !=="1" && typeof codiceTitolo !== "undefined"){
			    	tTitoli = $('#tableDataTitoli').DataTable(
			    			{
			    			"initComplete": function( settings ) {
			    				var form_titolo = $('#form_titolo').val();
			    				var tit = $('#id_titolo').val();
			    				if(form_titolo==1){
			    					if(tit =="2" || tit=="3")
									{
			    						tTitoli.columns([7,8,9]).visible(true);
									}
									else if(tit =="14"){
										tTitoli.columns([8,9,13]).visible(true);
									}
									else
									{
										tTitoli.columns([8,9]).visible(true);
									}
			    					
			    				}
			    				if(form_titolo==2){
			    					tTitoli.columns([10,14]).visible(true);
			    				}
			    				if(form_titolo==3){
			    					tTitoli.columns([2,3,4,5,6]).visible(true);
			    				}
			    				if(form_titolo==4){
			    					tTitoli.column(12).visible(true);
			    				}
			    				if(form_titolo==5){
			    					tTitoli.columns([8,9,11,16]).visible(true);
			    				}
			    				if(form_titolo==7){
			    					tTitoli.columns([10,15]).visible(true);
			    				}
			    				// mostro la tabella
			    				$('#tableDataTitoli').show();
			    			},
			    			"drawCallback": function( settings ) {
								  $('[data-toggle="tooltip"]').tooltip();
							},
			    			"lengthChange": false,
			    			"info": false,
			    			"bFilter" : false,
			    			"bSort": false,
			    			"destroy":true,
			    			"processing" : true,
							"serverSide" : true,
							"mark" : true,
							"responsive" : true,
							"pageLength" : '${numeroMassimoRecord}',
			    			"language" : {"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'},
			    			"ajax" : {
			    				"url" : '<spring:url value="/gradDomanda/titoliPres/'+datiDomanda.codiceDomanda+'/'+map[num].codice+'/'+datiDomanda.anno+'/'+datiDomanda.tipo+'.json" />',
			    				"dataSrc" : "payload"
			    			},
			    			"deferRender" : true,
							"columnDefs" : [
									{
									"render" : function(data, type, row) {
										if(updatable || duplicata)
											return '<a href="#" class="cancellaTitolo" data-toggle="tooltip" title="Cancella titolo"><i class="fa fa-times red" aria-hidden="true"></i></a>'
										else
											return '<span data-toggle="tooltip" title="Concorso chiuso! Impossibile editare la domanda."><a href="#" class="cancellaTitolo disabled"><i class="fa fa-times red" aria-hidden="true"></i></a></span>'	
									},
									"name" : "",
									"orderable" : false,
									"targets" : 0,
									},
									{
										"render" : function(data, type, row) {
											if (row.progressivoTitolo && row.progressivoTitolo !== "") {
												return row.progressivoTitolo;
											}
											return "";
										},
										"visible" : false,
										"name" : "progTit", 
										"targets" : 1,
										"class" : "editTitolo",
									},
									{
										"render" : function(data, type, row) {
											if (row.anno && row.anno !== "") {
												return row.anno;
											}
											return "";
										},
										"visible" : false,
										"name" : "id.titlAnno",
										"targets" : 2,
										"class" : "editTitolo",
									},
									{
										"render" : function(data, type, row) {
											if (row.mese && row.mese !== "") {
												return row.mese;
											}
											return "";
										},
										"visible" : false,
										"name" : "titlPeriodoMm",
										"targets" : 3,
										"class" : "editTitolo",
									},
									{
										"render" : function(data, type, row) {
											if (row.dal && row.dal !== "") {
												return row.dal;
											}
											return "";
										},
										"visible" : false,
										"name" : "titlPeriodoDal",
										"targets" : 4,
										"class" : "editTitolo",
									},
									{
										"render" : function(data, type, row) {
											if (row.al && row.al !== "") {
												return row.al;
											}
											return "";
										},
										"visible" : false,
										"name" : "titlPeriodoAl",
										"targets" : 5,
										"class" : "editTitolo",
									},
									{
										"render" : function(data, type, row) {
											if (row.ore && row.ore !== "") {
												return row.ore;
											}
											return "";
										},
										"visible" : false,
										"name" : "titlPeriodoOre",
										"targets" : 6,
										"class" : "editTitolo",
									},
									{
										"render" : function(data, type, row) {
											if (row.alboProv && row.alboProv !== "") {
												return row.alboProv;
											}
											return "";
										},
										"visible" : false,
										"name" : "alboProv",
										"targets" : 7,
										"class" : "editTitolo",
									},
									{
										"render" : function(data, type, row) {
											return row.periodoDal;
										},
										"visible" : false,
										"name" : "periodoDal",
										"targets" : 8,
										"class" : "editTitolo",
									},
									{
										"render" : function(data, type, row) {
											return row.periodoAl;
										},
										"visible" : false,
										"name" : "periodoAl",
										"targets" : 9,
										"class" : "editTitolo",
									},
									{
									"render" : function(data, type, row) {
										if (row.flag1 && row.flag1 !== "") {
											return row.flag1;
										}
										return "";
									},
									"visible" : false,
									"name" : "flag1",
									"targets" : 10,
									"class" : "editTitolo",
								},
								{
								"render" : function(data, type, row) {
									if (row.flag2 && row.flag2 !== "") {
										return row.flag2;
									}
									return "";
								},
								"visible" : false,
								"name" : "flag2",
								"targets" : 11,
								"class" : "editTitolo",
							},
							{
								"render" : function(data, type, row) {
									if (row.numero && row.numero !== "") {
										return row.numero;
									}
									return "";
								},
								"visible" : false,
								"name" : "numero",
								"targets" : 12,
								"class" : "editTitolo",
							},
							{
								"render" : function(data, type, row) {
									if (row.ulssAzienda && row.ulssAzienda !== "") {
										return row.ulssAzienda;
									}
									return "";
								},
								"visible" : false,
								"name" : "ulss",
								"targets" : 13,
								"class" : "editTitolo",
							},
							{
								"render" : function(data, type, row) {
									if (row.specializzazione && row.specializzazione !== "") {
										return row.specializzazione;
									}
									return "";
									
								},
								"visible" : false,
								"name" : "specializzazione",
								"targets" : 14,
								"class" : "editTitolo",
							},
							{
								"render" : function(data, type, row) {
									if (row.descrizione && row.descrizione !== "") {
										return row.descrizione;
									}
									return "";
								},
								"visible" : false,
								"name" : "descrizioneTitolo",
								"targets" : 15,
								"class" : "editTitolo",
							},
							{
								"render" : function(data, type, row) {
									if (row.flag1 && row.flag1 !== "") {
										return row.flag1;
									}
									return "";
								},
								"visible" : false,
								"name" : "utenti",
								"targets" : 16,
								"class" : "editTitolo",
							}]
			    		
			    		});
			    }else{
			    	$('#tabellaLaurea').show();
			    }
			});
			reloadBootpag(map);
		},
		error : function(data) {
		}
	});	
});
function reloadBootpag(map){
	 $.each(map, function(key, value) {
		 if(!$('.pagination').find("li[data-lp="+key+"]").hasClass("next") &&
			!$('.pagination').find("li[data-lp="+key+"]").hasClass("prev")){
		 $('.pagination').find( "li[data-lp="+key+"] a" ).html(value.codice);
		 }
		});
}
function validaFormTitolo(dialogRef){
	var form_titolo = parseInt($('#form_titolo').val());
	if(form_titolo===3)
	{
		var dataDal = $('#dataDal').val();
		var dataAl = $('#dataAl').val();
		var ore = $('#ore').val();
		if((validation.isNumber(dataDal)) &&(validation.isNumber(dataAl))
			&& (validation.isGreaterThan(dataAl, dataDal)) && validation.isNumber(ore))
		{
			dialogRef.getButton('confermaTitoli').enable();
		}
		else
		{
			dialogRef.getButton('confermaTitoli').disable();
		}
	}
	if(form_titolo===4)
	{
		var numero = $('#numero').val();
		if((validation.isNumber(numero)))
			dialogRef.getButton('confermaTitoli').enable();
		else
			dialogRef.getButton('confermTitoli').disable();
	}
	if(form_titolo===2)
	{
		var codSpec=$('#codSpecTitolo').val();
		if((validation.isNumber(codSpec)))
			dialogRef.getButton('confermaTitoli').enable();
		else
			dialogRef.getButton('confermaTitoli').disable();
	} 
	if(form_titolo===1)
	{
		var periodoDal=$('#periodoDal').val();
		var periodoAl = $('#periodoAl').val();
		if(periodoDal != "")
		{
			$('#periodoAlDiv').removeClass('disabled');
		}
		if((createDate(periodoAl)).getTime()>(createDate(datiDomanda.dataDomanda)).getTime())
		{
			dialogRef.getButton('confermaTitoli').disable();
			$('.error-block').css('display','block');
			return;
		}
		else
		{
			$('.error-block').css('display','none');
		}
		var albo = $('#albo').val();
		if(periodoDal !="" && periodoAl !="" && albo !="")
			dialogRef.getButton('confermaTitoli').enable();
		else
			dialogRef.getButton('confermaTitoli').disable();
		if((createDate(periodoDal).getTime()>(createDate(periodoAl).getTime())))
			dialogRef.getButton('confermaTitoli').disable();
	}
	if(form_titolo===5)
	{
		var periodoDal=$('#periodoDal').val();
		if(periodoDal != "")
		{
			$('#periodoAlDiv').removeClass('disabled');
		}
		var periodoAl = $('#periodoAl').val();
		if((createDate(periodoAl)).getTime()>(createDate(datiDomanda.dataDomanda)).getTime())
		{
			dialogRef.getButton('confermaTitoli').disable();
			$('.error-block').css('display','block');
			return;
		}
		else
		{
			$('.error-block').css('display','none');
		}
		if(periodoDal !="" && periodoAl !="")
			dialogRef.getButton('confermaTitoli').enable();
		else
			dialogRef.getButton('confermaTitoli').disable();
	} 
} 
function setFirstDatatable(){
	$(".contenutoTitoli").html("LAUREA IN MEDICINA E CHIRURGIA"); 
	$('#tdVoto').html(datiDomanda.voto);
	$('#tdVotoMax').html(datiDomanda.votoMax);
	$('#tdLode').html((datiDomanda.lode==null || datiDomanda.lode=="") ? 'N' : datiDomanda.lode);
	$('#tdData').html(datiDomanda.dataLaurea);
	$('#tableDataTitoli').hide();
}
$('#validaDomanda').click(function(){
	$.ajax({
		url : '<spring:url value="/gradDomanda/validaDomanda/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'.json" />',
		contentType : 'application/json; charset=UTF-8',
		type : 'GET',
		beforeSend : function() {
			//Mostro il loader
			$.blockUI({
				message : '<center><h2><img src="'+Constants.contextPath+Constants.loaderImg+'" /></h2>'
				+' Stiamo processando la richiesta...',
			});
		},
		complete : function() {
			//Elimino il blocco della finestra
			$.unblockUI();
		},
		success : function(data) 
		{
			console.log(data);
			BootstrapDialog.show({
				title : 'Validazione domanda',
				message : function(dialog) {
				var dati = new Object();
				dati.validazione = true;
				dati.erroriValidazione = data.payload;
				var $modalBody = templateTitolo(dati);
				return $modalBody;
				},
				size : BootstrapDialog.NORMAL,
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
				} ]
			});
		},
		error : function(error){
			mostraErrore();
		}
});
})
function mostraErrore(){
	modalErrore(templateErrore);
}
function caricaElencoSpec(tit){
	return $.ajax({
		url : '<spring:url value="/table/elencoSpecTitolo/'+tit+'.json" />',
		dataType : 'json',
		contentType : 'application/json; charset=UTF-8',
		async : false,
		success : function(data) {
			$.each(data.payload, function(key, value) {
				listaSpec[value.codice]=value;
			});
		}
	});
}
function createDate(str1){
	// str1 format should be dd/mm/yyyy. Separator can be anything e.g. / or -. It wont effect
	var dt1   = parseInt(str1.substring(0,2));
	var mon1  = parseInt(str1.substring(3,5));
	var yr1   = parseInt(str1.substring(6,10));
	var date1 = new Date(yr1, mon1-1, dt1);
	return date1;
	}
function setMese(mese){
	var descrizioneMese = "";
	switch (parseInt(mese)) {
	case 1:
		descrizioneMese+="Gennaio";
		break;
	case 2:
		descrizioneMese+="Febbario";
		break;
	case 3:
		descrizioneMese+="Marzo";
		break;
	case 4:
		descrizioneMese+="Aprile";
		break;
	case 5:
		descrizioneMese+="Maggio";
		break;
	case 6:
		descrizioneMese+="Giugno";
		break;
	case 7:
		descrizioneMese+="Luglio";
		break;
	case 8:
		descrizioneMese+="Agosto";
		break;
	case 9:
		descrizioneMese+="Settembre";
		break;
	case 10:
		descrizioneMese+="Ottobre";
		break;
	case 11:
		descrizioneMese+="Novembre";
		break;
	default:
		descrizioneMese+="Dicembre";
		break;
	}
	$select = $('#mese');
	$("#mese option[value='"+mese+"']").remove();
	$select.prepend("<option value='"+mese+"' selected='selected'>"+descrizioneMese+"</option>");
	$select.selectpicker('refresh');
	}
</script>