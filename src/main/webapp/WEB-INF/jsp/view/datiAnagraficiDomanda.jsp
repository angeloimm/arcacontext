<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
.form-group {
	margin-bottom: 0px;
}
</style>
<script type="text/x-handlebars-template" id="templateInserimentoParziale">
{{#if update}}
<div id="erroreInserimentoContainer1" class="alert alert-success" role="alert">
   <i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
   Modifica avvenuta correttamente.
</div>
{{else}}
<div id="erroreInserimentoContainer1" class="alert alert-success" role="alert">
   <i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
   Salvataggio parziale avvenuto correttamente.
</div>
{{/if}}
{{#if isStored}}
	<small>
		-E' gi&agrave; presente una domanda con il medesimo codice fiscale per il concorso in essere.<br>
	</small>
{{/if}}
{{#if formato}}
	<small>
		-Formato codice fiscale non valido
	</small>
{{/if}}
</script>
<!-- FORM NUOVA DOMANDA -->
<form role="form" id="form_nuova_domanda">
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div class="bs-panel">
				<div class="panel panel-default panel_padding_l_r">
					<div class="panel-body panel_min_height home_news">
						<!-- CODICE DOMANDA -->
						<div class="form-group col-md-4">
							<label for="codice" class="control-label">Cod. dom.</label> <input
								type="text" class="form-control" id="codice"
								value="${codiceDomanda}" readonly>
						</div>
						<!-- CODICE FISCALE -->
						<div class="form-group col-md-8">
							<label for="cod_fiscale" class="control-label">Codice
								fiscale (*)</label> <input type="text" class="form-control"
								id="cod_fiscale" placeholder="Codice fiscale" required maxlength="16">
							<div class="help-block with-errors"></div>
							<span class="alert-warning none" id="alert_cf"><strong>
									E' gi&agrave; stata inserita una domanda con il medesimo codice
									fiscale per il concorso in essere</strong></span>
							<span class="alert-warning none" id="alert_formato"><strong>
									Codice fiscale non valido</strong></span>
						</div>
						<!-- NOMINATIVO -->
						<div class="form-group col-md-12">
							<label for="nome" class="control-label">Nominativo (*)</label> <input
								type="text" class="form-control" id="nominativo"
								placeholder="Nome" required>
						</div>
						<!-- DATA -->
						<div class="form-group col-md-3">
							<label for="data" class="control-label">Data nascita (*)
							</label>
							<div class="input-group date datepicker_data" id="dataNascitaDiv">
								<input id="data" name="data" class="form-control"
									readonly="readonly" type="text" value="" /> <span
									class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
							<div class="alert-warning none" id="alert_age">
								<strong> Il candidato ha un'et&agrave; superiore ai 69
									anni</strong>
							</div>
						</div>
						<!-- PROVINCIA -->
						<div class="form-group col-md-3">
							<label for="provincia" class="control-label">Prov. (*)</label> <select
								id="provincia" name="provincia" disabled
								class="form-control changeRequest selectpicker show-tick"
								data-live-search="true">
								<option value="">NESSUNA SELEZIONE</option>
							</select>
						</div>
						<!-- LUOGO DI NASCITA -->
						<div class="form-group col-md-4">
							<label for="luogo" class="control-label">Comune Nascita
								(*)</label>
							<!-- data-live-search="true" -->
							<select id="luogo" name="luogo" disabled
								class="form-control changeRequest selectpicker show-tick"
								data-live-search="true" required>
								<option value="">NESSUNA SELEZIONE</option>
							</select>
						</div>
						<!-- SESSO -->
						<div class="form-group col-md-2">
							<label for="gender1" class="control-label">Sesso (*)</label>
						 	<select class="form-control changeRequest selectpicker show-tick" 
						 		required id="sesso">
								<option value="">Seleziona</option>
								<option value="M">M</option>
								<option VALUE="F">F</option>
							</select>
						</div>
						<!-- PEC -->
						<div class="form-group col-md-12">
							<label for="inputEmail" class="control-label">Pec</label> <input
								type="email" class="form-control" id="inputEmailPec"
								pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$"
								placeholder="Email" data-error="Indrizzo email non valido">
							<div class="help-block with-errors"></div>
						</div>
						<!-- EMAIL -->
						<div class="form-group col-md-12">
							<label for="inputEmail" class="control-label">Mail</label> <input
								type="email" class="form-control" id="inputEmail"
								pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$"
								placeholder="Email" data-error="Indirizzo mail non valido">
							<div class="help-block with-errors"></div>
						</div>
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
						<div class="form-group col-md-3">
							<label for="data_domanda" class="control-label">Data
								domanda (*)</label>
							<div class="input-group date datepicker_dataDomanda"
								id="dp_data_domanda">
								<input id="data_domanda" name="data_domanda"
									class="form-control" type="text" required
									pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}" />
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<!-- PROTOCOLLO -->
						<div class="form-group col-md-4">
							<label for="protocollo" class="control-label">Protocollo
								(*)</label> <input type="text" class="form-control" id="protocollo"
								required maxlength="12">
						</div>
						<!-- BUTTON AZIONI -->
						<sec:authorize access="hasRole('GRADMED_ADMIN')">
							<div class="form-group margin40 col-md-5">
								<button type="button" class="btn btn-default btn-large" id="calcoloSingolo">
									<i class="fa fa-calculator" aria-hidden="true"></i>&nbsp;Calcola
									punti
								</button>
								<button type="button" class="btn btn-default btn-large" id="analiticaSingola">
									<i class="fa fa-pencil" aria-hidden="true"></i>&nbsp;Analitica
									Calcolo singolo
								</button>
							</div>
						</sec:authorize>
						<!-- ULSS RESIDENZA -->
						<div class="form-group col-md-6">
							<label for="ulss_residenza" class="control-label">ULSS
								Residenza (*)</label> <select id="ulss_residenza" name="ulss_residenza"  
								class="form-control changeRequest selectpicker show-tick" required
								data-live-search="true">
								<option value="">NESSUNA SELEZIONE</option>
							</select>
						</div>
						<!-- ULSS  DESCRIZIONE-->
						<div class="form-group col-md-6">
							<label for="ulss_descrizione" class="control-label">ULSS</label>
							<input type="text" class="form-control" id="ulss_descrizione"
								required readonly>
						</div>
						<!-- PROVINCIA -->
						<div class="form-group col-md-5">
							<label for="provincia_res" class="control-label">Prov.
								(*)</label> <select id="provincia_res" name="provincia_res" disabled
								class="form-control changeRequest selectpicker show-tick"
								data-live-search="true" required>
								<option value="">NESSUNA SELEZIONE</option>
							</select>
						</div>
						<!-- RESIDENZA -->
						<div class="form-group col-md-4">
							<label for="residenza" class="control-label">Residente a
								(*) </label> <select id="residenza" name="residenza" disabled
								class="form-control changeRequest selectpicker show-tick"
								data-live-search="true" required>
								<option value="">NESSUNA SELEZIONE</option>
							</select>
						</div>
						<!-- CAP -->
						<div class="form-group col-md-3">
							<label for="inputName" class="control-label">CAP (*)</label> <input
								type="text" class="form-control" id="inputName"
								pattern="[0-9]{5}" required data-error="Formato non corretto">
							<div class="help-block with-errors"></div>
						</div>
						<!-- INDIRIZZO -->
						<div class="form-group col-md-8">
							<label for="indirizzo" class="control-label">Indirizzo
								(*)</label> <input type="text" class="form-control" id="indirizzo"
								required>
							<div class="help-block with-errors"></div>
						</div>
						<!-- TELEFONO -->
						<div class="form-group col-md-4">
							<label for="telefono" class="control-label">Telefono</label>
							<input type="text" class="form-control" id="telefono">
						</div>
						<!-- FRAZIONE -->
						<div class="form-group col-md-12">
							<label for="frazione" class="control-label">Frazione</label> <input
								type="text" class="form-control" id="frazione">
						</div>
						<!-- CHECK DOMICILIO -->
						<div class="form-group col-md-12">
							<div class="checkbox">
								<label class="switch">
								 	<input type="checkbox" name="flag" id="flag" 
								 		   data-on-text="Si" data-off-text="No" 
								 		   value="isChecked"> 
								</label>
								<span class="posizDomicilio">
									<strong>Domicilio coincide con residenza</strong> 
								</span>
							</div>
						</div>
						<div class="form-group col-md-4">
							<label for="prov_domicilio" class="control-label">Prov.
								(*) <span
								title="AVVISO : E' obbligatorio solo se il domicilio non coincide
										con la residenza"
								data-toggle="tooltip"
								class="color_warning glyphicon glyphicon-warning-sign cursor_pointer"></span>
							</label> <select id="prov_domicilio" name="prov_domicilio" disabled
								class="form-control changeRequest selectpicker show-tick"
								data-live-search="true" required>
								<option value="">NESSUNA SELEZIONE</option>
							</select>
						</div>
						<!-- DOMICILIO -->
						<div class="form-group col-md-6">
							<label for="domicilio" class="control-label">Domiciliato
								a (*) <span
								title="AVVISO : E' obbligatorio solo se il domicilio non coincide
										con la residenza"
								data-toggle="tooltip"
								class="color_warning glyphicon glyphicon-warning-sign cursor_pointer"></span>
							</label> <select id="domicilio" name="prov_domicilio" disabled
								class="form-control changeRequest selectpicker show-tick"
								data-live-search="true" required>
								<option value="">NESSUNA SELEZIONE</option>
							</select>
						</div>
						<div class="form-group col-md-2">
							<label for="cap_domicilio" class="control-label">CAP (*)
								<span
								title="AVVISO : E' obbligatorio solo se il domicilio non coincide
										con la residenza"
								data-toggle="tooltip"
								class="color_warning glyphicon glyphicon-warning-sign cursor_pointer"></span>
							</label> <input type="text" class="form-control" id="cap_domicilio"
								required pattern="[0-9]{5}">
						</div>

						<div class="form-group col-md-8">
							<label for="indirizzo_domicilio" class="control-label">Indirizzo
								(*) <span
								title="AVVISO : E' obbligatorio solo se il domicilio non coincide
										con la residenza"
								data-toggle="tooltip"
								class="color_warning glyphicon glyphicon-warning-sign cursor_pointer"></span>
							</label> <input type="text" class="form-control" id="indirizzo_domicilio"
								required>
						</div>
						<div class="form-group col-md-4">
							<label for="telefono_domicilio" class="control-label">Telefono
							</label> <input type="text" class="form-control" id="telefono_domicilio">
						</div>
						<div class="form-group col-md-12">
							<label for="frazione_domicilio" class="control-label">Frazione</label>
							<input type="text" class="form-control" id="frazione_domicilio">
						</div>
						<div class="divOver">
							<div class="row">
								<div class="col-sm-12">
									<button type="button"
										class="btn btn-default btn-large button_salva" id="saveData">
										<i class="fa fa-floppy-o" aria-hidden="true"></i>&nbsp;Salva
									</button>
									<button type="button"
										class="btn btn-default btn-large button_salva" id="analitica_graduatoria">
										<i class="fa fa-list" aria-hidden="true"></i>&nbsp;Analitica
										Graduatoria
									</button>
									<button type="button"
										class="btn btn-default btn-large button_salva"
										onclick="javascript:esci();">
										<i class="fa fa-undo" aria-hidden="true"></i>&nbsp;Esci
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<script type="text/x-handlebars-template" id="templateUscita">
	<div id="erroreInserimentoContainer" class="alert alert-warning">
		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
		<br>Confermi di voler interrompere l'inserimento? I dati insetiti andranno persi
	</div>
	<small>L'operazione non &egrave; annullabile</small>
</script>
<script type="text/x-handlebars-template" id="templatePunteggio">
{{#if successo}}
	<div id="erroreInserimentoContainer" class="alert alert-warning">
		Il punteggio associato alla domanda &egrave;: {{{fixed punteggio}}}
	</div>
	<small>Il dettaglio del calcolo &egrave; disponibile nella sezione <i>Punteggi calcolati<i></small>
{{else if errori}}
<div id="erroreCancellazioneContainer" class="alert alert-danger">
	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
	E' avvenuto un errore durante il calcolo del punteggio
	<br/>Ti preghiamo di riprovare pi&ugrave; tardi.</div>
{{/if}}
</script>
<script>
var templateInserimentoParziale = Handlebars.compile($("#templateInserimentoParziale").html());
var templateUscita = Handlebars.compile($("#templateUscita").html());
var templatePunteggio = Handlebars.compile($("#templatePunteggio").html());
	$(function() {
		$(".datepicker_data").datetimepicker({
			format : "DD/MM/YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			ignoreReadonly : true,
			maxDate : 'now',
		});
		$(".datepicker_dataDomanda").datetimepicker({
			format : "DD/MM/YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			ignoreReadonly : true,
			maxDate : new Date('${sessionScope.anno-1}/01/31'),
			minDate : new Date('${sessionScope.anno-2}/12/20'),
		});
	});
	$('#flag').on('change.bootstrapSwitch', function(e) {
		if ($('#flag').prop('checked')) 
		{
			$('#indirizzo_domicilio').prop('readonly', true);
			$('#frazione_domicilio').prop('readonly', true);
			$('#cap_domicilio').prop('readonly', true);
			$('#indirizzo_domicilio').prop('required', false);
			$('#cap_domicilio').prop('required', false);
			$('#cap_domicilio').val('');
			$('#indirizzo_domicilio').val('');
		} 
		else 
		{
			$('#indirizzo_domicilio').prop('readonly', false);
			$('#frazione_domicilio').prop('readonly', false);
			$('#cap_domicilio').prop('readonly', false);
			$('#indirizzo_domicilio').prop('required', true);
			$('#cap_domicilio').prop('required', true);
		}
		abilitaProvinciaDomicilio();
		abilitaDomicilio();
	    $('#saveData').removeClass('disabled');
	});

	//per visualizzare stile tooltip
	$('[data-toggle="tooltip"]').tooltip();
	$("[name='flag']").bootstrapSwitch();
	$('.selectpicker').selectpicker();

	$('#dataNascitaDiv').on("dp.change", function(e) {
		abilitaProvincia();
		abilitaComune();
		caricaProvincia();
    	abilitaResidenza();
		abilitaProvinciaResidenza();
		abilitaProvinciaDomicilio();
		abilitaDomicilio();
		checkAge();
	});

	function abilitaProvincia() 
	{
		var $this = $("#provincia");
		if (!!$("#data").val()) 
		{
			$this.prop("disabled", false);
		} else 
		{
			$this.prop("disabled", true);
			$this.val("");
		}
		$this.selectpicker("refresh");
	}

	function abilitaComune() 
	{
		var $this = $("#luogo");
		if (!!$("#data").val()) 
		{
			$this.prop("disabled", false);
		} else {
			$this.prop("disabled", true);
			$this.val("");
		}
		$this.selectpicker("refresh");
	}

	function abilitaProvinciaResidenza() 
	{
		var $this = $("#provincia_res");
		if (!!$("#data").val()) 
		{
			$this.prop("disabled", false);
		} else 
		{
			$this.prop("disabled", true);
			$this.val("");
		}
		$this.selectpicker("refresh");
	}

	function abilitaProvinciaDomicilio() 
	{
		var $this = $("#prov_domicilio");
		if (!!$("#data").val() && !$('#flag').prop('checked')) 
		{
			$this.prop("disabled", false);
		} else 
		{
			$this.prop("disabled", true);
			$this.val("");
		}
		$this.selectpicker("refresh");
	}

	function abilitaDomicilio() 
	{
		var $this = $("#domicilio");
		if (!!$("#data").val() && !$('#flag').prop('checked')) 
		{
			$this.prop("disabled", false);
		} else 
		{
			$this.prop("disabled", true);
			$this.val("");
		}
		$this.selectpicker("refresh");
	}

	function abilitaResidenza() 
	{
		var $this = $("#residenza");
		if (!!$("#data").val()) 
		{
			$this.prop("disabled", false);
		} else 
		{
			$this.prop("disabled", true);
			$this.val("");
		}
		$this.selectpicker("refresh");
	}

	$('#provincia').change(function() {
		caricaComune($('#provincia').find(":selected").data("info"), null, true);
		caricaUlss();
	});
	$('#provincia_res').change(function() {
		caricaComuneResidenza($('#provincia_res').find(":selected").data("info"), null, true);
	});
	$('#prov_domicilio').change(function() {
		caricaComuneDomicilio($('#prov_domicilio').find(":selected").data("info"), null, true);
	});
	$('#ulss_residenza').change(function() {
		$('#ulss_descrizione').val($('#ulss_residenza').val());
	});
	
	$("#saveData").click(function(evt) 
	{
		evt.preventDefault();
		if($('#form_nuova_domanda').validator('validate').has('.has-error').length > 0 ){
			return;
		}
		datiDomanda.nominativo = $('#nominativo').val();
		datiDomanda.data = $('#data').val();
		datiDomanda.codiceFiscale = $('#cod_fiscale').val();
		datiDomanda.protocollo = $('#protocollo').val();
		datiDomanda.luogoNascita = $('#luogo').val();
		datiDomanda.provincia = $('#provincia').val();
		datiDomanda.sesso = $('#sesso').val();
		datiDomanda.email = $('#inputEmail').val();
		datiDomanda.pec = $('#inputEmailPec').val();
		datiDomanda.codiceDomanda = $('#codice').val();
		var ulss = ($('#ulss_residenza').find(":selected").data("info")).split("/");
		datiDomanda.ulssReg = ulss[0];
		datiDomanda.ulssAzienda = ulss[1];
		datiDomanda.provinciaRes = $('#provincia_res').val();
		datiDomanda.luogoResidenza = $('#residenza').val();
		datiDomanda.cap = $('#inputName').val();
		datiDomanda.indirizzo = $('#indirizzo').val();
		datiDomanda.telefonoRes = $('#telefono').val();
		datiDomanda.frazione = $('#frazione').val();
		datiDomanda.dataDomanda = $('#data_domanda').val();
		datiDomanda.provDomicilio = ($('#prov_domicilio').val()=="" ? datiDomanda.provinciaRes : $('#prov_domicilio').val());
		datiDomanda.domicilio = ($('#domicilio').val()=="" ? datiDomanda.luogoResidenza : $('#domicilio').val());
		datiDomanda.capDomicilio = ($('#cap_domicilio').val() == "" ? null : $('#cap_domicilio').val());
		datiDomanda.indirizzoDomicilio = $('#indirizzo_domicilio').val();
		datiDomanda.telefonoDomicilio = $('#telefono_domicilio').val();
		datiDomanda.frazioneDomicilio = $('#frazione_domicilio').val();
		if(!update){
			datiDomanda.tipo = $('#tipo').val();
			datiDomanda.anno = $('#anno').val();
		}
		popolaAnagraficaHeader(datiDomanda);
		if(update){
			$.ajax({
						type : 'POST',
						url : Constants.contextPath + "gradDomanda/add.json",
						contentType : 'application/json',
						data : JSON.stringify(datiDomanda),
						dataType : 'json',
						success : function(data) {
						},
					});
		}
		// Apro il tab corrispondente al primo step
		$('.nav-tabs a[href="#menu2"]').tab('show');
		// Rimuovo classe dall'elemento datiAnagrafici
		$('.nav-tabs #init2').removeClass("disabled");
		// Scrollo verso l'alto
		window.scrollTo(0, 0);
		BootstrapDialog.show
		({
			title : 'Inserimento Domanda',
			message : function(dialog) 
			{
				var cf = $('#cod_fiscale').val();
				var codiceDomanda = $('#codice').val();
				var dati = new Object();
				if(update)
					dati.update=true;
				$.ajax({
					type : 'GET',
					url : '<spring:url value="/gradDomanda/checkCodFiscale/'+cf+'/'+codiceDomanda+'.json" />',
					async : false,
					contentType : 'application/json; charset=UTF-8',
					dataType : 'json',
					success : function(data) 
					{
						if (data.payload[0] == true)
							dati.isStored = true;
						if (data.payload[1] == false)
							dati.formato = true;
					}
			   });
				console.log(dati);
				var $modalBody = templateInserimentoParziale(dati);
				return $modalBody;
			},
			size : BootstrapDialog.SIZE_NORMAL,
			type : BootstrapDialog.TYPE_PRIMARY,
			closable : true,
			draggable : false,
			nl2br : false,
			buttons : 
				[{
					id : 'annullaConferma',
					label : 'Chiudi',
					action : function(dialogRef) 
					{
						dialogRef.close();
					}
				}]
		});
	});
	//Exit domanda
	function esci() 
	{
		BootstrapDialog.show
		({
			title : 'Attenzione',
			message : function(dialog) 
			{
				var uscita = true;
				var $modalBody = templateUscita();
				return $modalBody;
			},
			size : BootstrapDialog.SIZE_NORMAL,
			type : BootstrapDialog.TYPE_PRIMARY,
			closable : true,
			draggable : false,
			nl2br : false,
			buttons : 
			[{
				id : 'esci',
				icon : 'fa fa-check',
				label : 'Conferma',
				cssClass : 'btn-primary',
				autospin : true,
				action : function(dialog) 
				{
					dialog.enableButtons(false);
					dialog.setClosable(false);
					backToFirstTab(dialog);
				}
			  }, {
				id : 'annullaUscita',
				label : 'Annulla',
				cssClass : 'btn-primary',
				icon : 'fa fa-times',
				action : function(dialog) 
				{
					dialog.close();
				}
			}]
		});
	}
	function backToFirstTab(dialog) 
	{
		dialog.close();
		//Svuoto l'oggetto contenente di dati della domanda
		datiDomanda = {};
		// Apro il tab corrispondente allo step home
		$('.nav-tabs a[href="#home"]').tab('show');
		// Rimuovo classe dall'elemento datiAnagrafici
		$('.nav-tabs #init').addClass("disabled");
		// Scrollo verso l'alto
		window.scrollTo(0, 0);
		// Reset del form di inserimento della nuova domanda
		$('#form_nuova_domanda').trigger("reset");
	}
	function checkAge() 
	{
		$('#alert_age').css('display', 'none');
		var data = ($('#data').val()).split("/");
		var today = new Date();
		var annoToday = today.getFullYear();
		var annoSelezionato = data[2];
		if (parseInt(annoToday) - parseInt(annoSelezionato) >= 69)
			$('#alert_age').css('display', 'block');
	}
	$("#calcoloSingolo").click(function(evt) 
	{
		//Prevengo il propagarsi dell'evento
		evt.preventDefault();
		var url = '<spring:url value="/punteggi/calcoloSingolo/'+datiDomanda.codiceDomanda+'/'+datiDomanda.anno+'/'+datiDomanda.tipo+'.json"/>';
		$.ajax({
			url : url,
			contentType : 'application/json; charset=UTF-8',
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
				BootstrapDialog
				.show({
					title : 'Operazione completata',
					message : function(dialog) {
						var dati = new Object();
						dati.successo = true;
						dati.punteggio = data.payload; 
						var $modalBody = templatePunteggio(dati);
						return $modalBody;
					},
					size : BootstrapDialog.SIZE_NORMAL,
					type : BootstrapDialog.TYPE_PRIMARY,
					closable : true,
					draggable : false,
					nl2br : false,
					buttons : 
					[{
						id : 'annullaUscita',
						label : 'Chiudi',
						cssClass : 'btn-primary',
						icon : 'fa fa-times',
						action : function(dialog) 
						{
							dialog.close();
						}
					}]
				});
			},
			error : function(data) {
				mostraErrorePunteggio();
			}
		});	
	});
	Handlebars.registerHelper('fixed', function(punteggio) {
		var result = parseFloat(punteggio);
	    if(!isNaN(result)) 
	    { 
	     	return result.toFixed(2);   	      	
	    } 
	    else
	    {
	    	return 0.00;
	    }
	    return ""; 
	});	
	function mostraErrorePunteggio(){
		BootstrapDialog.show({
			title : 'Attenzione',
			message : function(dialog) {
				var dati = new Object();
				dati.errori = true;
				var $modalBody = templatePunteggio(dati);
				return $modalBody;
			},
			size : BootstrapDialog.SIZE_NORMAL,
			type : BootstrapDialog.TYPE_PRIMARY,
			closable : true,
			draggable : false,
			nl2br : false,
			buttons : 
			[{
				id : 'annullaUscita',
				label : 'Chiudi',
				cssClass : 'btn-primary',
				icon : 'fa fa-times',
				action : function(dialog) 
				{
					dialog.close();
				}
			}]
		});
	}
	$("#analiticaSingola").click(function(evt) {
		//Prevengo il propagarsi dell'evento
		evt.preventDefault();
		if(duplicata)
			var url ='<spring:url value="/report/analiticaSingola/PDF/'+${sessionScope.anno}+'/${sessionScope.tipoGraduatoria}/'+datiDomanda.codiceDomanda+'"/>';
		else
			var url ='<spring:url value="/report/analiticaSingola/PDF/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'"/>';
		window.open(url, '_blank');
	});
	$("#analitica_graduatoria").click(function(evt) {
		//Prevengo il propagarsi dell'evento
		evt.preventDefault();
		if(duplicata)
			var url ='<spring:url value="/report/analiticaSingolaMax/PDF/'+${sessionScope.anno}+'/${sessionScope.tipoGraduatoria}/'+datiDomanda.codiceDomanda+'"/>';
		else
			var url ='<spring:url value="/report/analiticaSingolaMax/PDF/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'"/>';
		window.open(url, '_blank');
	});
</script>