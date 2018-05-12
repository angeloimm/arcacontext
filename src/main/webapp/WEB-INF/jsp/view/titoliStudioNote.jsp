<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<style>
.form-group {
	margin-bottom: 0px;
}
</style>
<script type="text/x-handlebars-template"
	id="templateInserimentoDomanda">
			{{#if errore}}
				<div id="erroreInserimentoContainer" class="alert alert-danger">
					<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
					Si &egrave; verificato un errore durante il salvataggio della domanda
					<br/>
					Ti preghiamo di riprovare pi&ugrave; tardi.
				</div>
			{{else if successo}}
				<div id="erroreInserimentoContainer" class="alert alert-success" role="alert">
					<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
					Salvataggio domanda avvenuto correttamente.<br>
					Ora &egrave; possibile procedere con l'inserimento dei titoli e delle titolarit&agrave;. 
				</div>
			{{else}}
				<div id="domanda_irregolare" class="alert alert-warning">
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
					Domanda inserita con successo, ma segnata come irregolare!
				</div>
				<small>
				{{#each listaErrori}}
				<p> - {{this}} </p>
				{{/each}}
				</small>
			{{/if}}
		</script>
<!-- FORM TITOLI STUDIO E NOTE -->
<form role="form" id="form_laurea">
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
					<div class="col-md-12">
						<div class="col-md-3">
							<label for="indirizzo" class="control-label"> Laurea in
								medicina e chirurgia</label>
						</div>
						<div class="col-md-2">
							<label for="indirizzo" class="control-label nowrap"> Conseguita
								in data (*)
							</label>
						</div>
						<!-- DATA LAUREA -->
						<div class="form-group col-md-2 ">
							<div class="input-group date datepicker_data largeDate">
								<input id="dataLaurea" name="dataLaurea"
									class="form-control" type="text" value="" required /> <span
									class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<div class="col-md-1">
							<label for="indirizzo" class="control-label nowrap">Con
								punti</label>
						</div>
						<div class="col-md-1 form-group ">
							<input type="text" id="score" name="score"
								class="form-control " 
								placeholder="0"					
								data-error="Valore non valido" 
								value="0">	
						</div>
						<div class="col-md-1 form-group">
							<input type="text" id="limitScore" name="limitScore" required
								class="form-control" 
								placeholder="110"
								value="" >
							<div class="alert-warning hide" id="errorLimitScore">
							</div>		
						</div>
						<!-- CHECK LODE -->
						<div class="form-group col-md-1">
							<div class="checkbox " id="checkLode">
								<label> <input type="checkbox" id="lode" name="lode" value=""> Lode
								</label>
							</div>
						</div>
					<div class="hide" id="errorScoreLimit">
						<label class="control-label posiz_alert">Lode inserita per punteggio inferiore al voto massimo!</label>
					</div>
					<div class="hide" id="errorScoreLimit2">
						<label class="control-label posiz_alert">Lode inserita per punteggio superiore al voto massimo!</label>
					</div>
					</div>
					<div class="col-md-12" id="divSpec">
						<div class="col-md-3">
							<label for="indirizzo" class="control-label">
								Specializzazione in pediatria</label>
						</div>
						<div class="col-md-2">
							<label for="indirizzo" class="control-label nowrap"> Conseguita
								in data
							</label>
						</div>
						<!-- DATA SPECIALIZZAZIONE -->
						<div class="form-group col-md-2 ">
							<div class="input-group date datepicker_data largeDate">
								<input id="dataLaureaSpec" name="dataLaureaSpec"
									class="form-control" type="text" value="" 
									pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}"/>
									 <span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<div class="col-md-1">
							<label for="indirizzo" class="control-label nowrap">Con
								punti</label>
						</div>
						<div class="col-md-1 form-group">						
							<input type="text" id="scoreSpec" name="scoreSpec"  
								class="form-control " 
								placeholder="0"
								data-error="Valore non valido"
								value="0">	
											
						</div>
						<div class="col-md-1 form-group">
							<input type="text" id="limitScoreSpec" name="limitScoreSpec"
								class="form-control" 
								placeholder="110"
								value="" >
							 <div class="alert-warning hide" id="errorLimitScoreSpec" > 
							</div>		
						</div>
						<!-- CHECK LODE -->
						<div class="form-group col-md-1">
							<div class="checkbox " id="checkLodeSpec">
								<label> <input type="checkbox" id="lodeSpec" name="lodeSpec" value=""> Lode
								</label>
							</div>
						</div>	
						<div class="hide" id="errorScoreSpecLimit">
							<label class="control-label posiz_alert">Lode inserita per punteggio inferiore al voto massimo!</label>
						</div>
						<div class="hide" id="errorScoreSpecLimit2">
							<label class="control-label posiz_alert">Lode inserita per punteggio superiore al voto massimo!</label>
						</div>
					</div>
					<hr class="divisor">
					<!-- CHECK RISERVA -->
					<div class="form-group col-md-4">
						<div class="checkbox positioncheckbox">
							<label><input type="checkbox" name="flagRiserva" id="flagRiserva"
								data-on-text="Si" data-off-text="No" value="isChecked">
								<strong>Riserva D.L. vo 168/2000</strong> </label>
						</div>
					</div>
					<!-- ANNO ABILITAZIONE -->
					<div class="form-group col-md-3">
						<label for="annoAbilitazione" class="control-label">Abilitazione
							conseguita nell'anno (*)</label>
					</div>
					<div class="form-group col-md-3">
						<div class="form-group col-md-12">
							<div class="input-group date datepicker_anno">
								<input id="annoAbilitazione" name="annoAbilitazione" class="form-control" required
									type="text" value=""  pattern="[0-9]{4}"/> <span
									class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>
					<!-- SESSIONE CONSEGUIMENTO -->
					<div class="col-md-2 form-group">
						<input type="text" id="sessione" name="sessione"
							class="form-control" placeholder="Sessione" />
					</div>
					<!-- NOTE -->
					<div class="form-group col-md-12">
						<label for="note" class="control-label">Note </label>
						<textarea class="form-control" rows="4" cols="50" id="note"></textarea>
					</div>
					<sec:authorize access="hasRole('GRADMED_ADMIN')">
					<div class="divOver">
						<div class="row">
							<div class="col-sm-12">
								<button type="submit"
									class="btn btn-default btn-large button_salva" id="persistData">
									<i class="fa fa-floppy-o" aria-hidden="true"></i>&nbsp;Salva
								</button>
								<button type="button"
									class="btn btn-default btn-large button_salva">
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
					</sec:authorize>
				</div>
			</div>
		</div>
	</div>
</form>

<script>
	var templateInserimentoDomanda = Handlebars.compile($("#templateInserimentoDomanda").html());
	/* Datepicker per visualizzare solo data*/
	$(function() {
		$(".datepicker_data").datetimepicker({
			format : "DD/MM/YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			ignoreReadonly : true,
			maxDate : 'now',
		});
	/* per visualizzare solo anno*/
		$(".datepicker_anno").datetimepicker({
			format : "YYYY",
			showClose : true,
			locale : 'it',
			showClear : true,
			ignoreReadonly : true,
			maxDate : 'now'
		});
	});
	$("#persistData").click(function(evt) {
		evt.preventDefault();
			if($('#form_laurea').validator('validate').has('.has-error').length > 0 ){
				return;
			}
			// popolo l'oggetto relativo alla domanda
			datiDomanda.voto = $('#score').val() != "" ? $('#score').val() : '0';
			datiDomanda.votoMax = $('#limitScore').val();
			datiDomanda.dataLaurea = $('#dataLaurea').val();
			datiDomanda.lode = $('#lode').val();					
			datiDomanda.votoSpecializzazione = $('#scoreSpec').val() != "" ? $('#scoreSpec').val() : '0';
			datiDomanda.votoMaxSpecializzazione = $('#limitScoreSpec').val();
			datiDomanda.dataSpecializzazione = ($('#dataLaureaSpec').val() == "" ? null: $('#dataLaureaSpec').val()) ;
			datiDomanda.lodeSpecializzazione = $('#lodeSpec').val();
			datiDomanda.abilitazioneAnno = $('#annoAbilitazione').val();
			datiDomanda.note = $('#note').val();
			datiDomanda.sessione = $('#sessione').val();
			var url = Constants.contextPath + "gradDomanda/add.json";
			$.ajax({
						type : 'POST',
						url : url,
						contentType : 'application/json',
						data : JSON.stringify(datiDomanda),
						dataType : 'json',
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
						success : function(data) {
							var codiceEsito = data.codiceOperazione;
							if (codiceEsito == 200) {
								BootstrapDialog.show({
											title : 'Inserimento Domanda',
											message : function(dialog) {
												var dati = new Object();
												dati.successo = true;
												var $modalBody = templateInserimentoDomanda(dati);
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
												} ]
										});
							}else if (codiceEsito == 201) {
								BootstrapDialog.show({
									title : 'Inserimento Domanda',
									message : function(
											dialog) {
										var dati = new Object();
										dati.irregolare = true;
										dati.listaErrori = data.payload;
										var $modalBody = templateInserimentoDomanda(dati);
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
											} ]
								});
							}else{
								mostraErroreInsertDomanda();
							}
							$('.nav-tabs li').removeClass("disabled");
							// Scrollo verso l'alto
							window.scrollTo(0, 0);
							// Apro il tab corrispondente al terzo step
							$('.nav-tabs a[href="#menu3"]').tab('show');
							// Carica le titolarita per l'anno ed il tipo settati in sessione
							loadSelectCodTitolarita();
						},														
						error : function(data) {
							mostraErroreInsertDomanda();
						}
					});
		});
	function mostraErroreInsertDomanda() {
		BootstrapDialog.show({
			title : 'Inserimento Domanda',
			message : function(dialog) {
				var dati = new Object();
				dati.errore = true;
				var $modalBody = templateInserimentoDomanda(dati);
				return $modalBody;
			},
			size : BootstrapDialog.SIZE_NORMAL,
			type : BootstrapDialog.TYPE_PRIMARY,
			closable : true,
			draggable : false,
			nl2br : false,
		});
	}
	$('#score').on("change", function(e) 
	{
		verificaVotoLode();
	});
	$('#scoreSpec').on("change",function(e){
		var scoreSpec=$('#scoreSpec').val();
		var voto = parseInt(scoreSpec); 
		var limitScoreSpec=$('#limitScoreSpec').val();
		var limite = parseInt(limitScoreSpec);
		var lodeSpec = $('#lodeSpec').val();
		if(voto===limite && lodeSpec==="S")
		{
			$('#errorScoreSpecLimit').removeClass("show");
			$('#errorScoreSpecLimit2').removeClass("show");	
		}
		else if(voto<limite && lodeSpec==="S")
		{
			$('#errorScoreSpecLimit').addClass("show");	
			$('#errorScoreSpecLimit2').removeClass("show");	
		}else if(voto>limite && lodeSpec==="S"){
			$('#errorScoreSpecLimit2').addClass("show");	
			$('#errorScoreSpecLimit').removeClass("show");
		}
	})
	$('#limitScore').on("change",function(e){
		var scoreSpec=$('#score').val();
		var voto = parseInt(scoreSpec); 
		var limitScore=$('#limitScore').val();
		var limite = parseInt(limitScore);
		var lode = $('#lode').val();
		if(voto===limite && lode==="S")
		{
			$('#errorScoreLimit').removeClass("show");	
		}
		else if(voto<limite && lode==="S")
		{
			$('#errorScoreLimit').addClass("show");	
			$('#errorScoreLimit2').removeClass("show");
		}
		else if(voto>limite && lode==="S")
		{
			$('#errorScoreLimit2').addClass("show");
			$('#errorScoreLimit').removeClass("show");	
		}
	})
	$('#limitScoreSpec').on("change",function(e){
		var scoreSpec=$('#scoreSpec').val();
		var voto = parseInt(scoreSpec); 
		var limitScoreSpec=$('#limitScoreSpec').val();
		var limite = parseInt(limitScoreSpec);
		var lodeSpec = $('#lodeSpec').val();
		if(voto===limite && lodeSpec==="S")
		{
			$('#errorScoreSpecLimit').removeClass("show");	
		}
		else if(voto<limite && lodeSpec==="S")
		{
			$('#errorScoreSpecLimit').addClass("show");	
			$('#errorScoreSpecLimit2').removeClass("show");	
		}
		else if(voto>limite && lodeSpec==="S")
		{
			$('#errorScoreSpecLimit2').addClass("show");
			$('#errorScoreSpecLimit').removeClass("show");
		}
	})
	function abilitaLode()
	{
		var score=$('#score').val();
		var voto = parseInt(score);     	
	 	if($('#score').val() === "" || $('#score').val()==='0'){	
	  		voto=0;     
	  		$('#errorScore').removeClass("show");
	  		$('#lode').val('');
	 	}
	 	else
	 		{
	 			$('#checkLode').removeClass("disabled");
	 		}
	}
	function abilitaLodeSpec()
	{
		var scoreSpec=$('#scoreSpec').val();
		var voto = parseInt(scoreSpec);		
	  	if($('#scoreSpec').val() === "" || $('#scoreSpec').val()==='0' ){	
	  		voto=0;
	  		$('#error').removeClass("show");
	  		//$('#checkLodeSpec').addClass("disabled");
	  	  	$('#lodeSpec').val('');
	  	} 
	  	else{
	  			$('#checkLodeSpec').removeClass("disabled");
	  		}
	}
	$('#lode').click(function() {
		var score=$('#score').val();
		var voto = parseInt(score); 
		var limitScore=$('#limitScore').val();
		var limite = parseInt(limitScore); 
	    if($('#lode').prop('checked')){	
	    	$('#lode').val('S');
	    	if(voto==limite )
	    	{    	
	    		$('#errorScoreLimit').removeClass("show");
	        	
	    	}
	    	else if(voto<limite )
	    	{
	    	 	$('#errorScoreLimit').addClass("show");	
	    	 	$('#errorScoreLimit2').removeClass("show");	
	    	}
	    	else
	    	{
	    		$('#errorScoreLimit2').addClass("show");	
	    		$('#errorScoreLimit').removeClass("show");	
	    	}
	    }
	    else
	    {
	    	$('#errorScoreLimit').removeClass("show");
	    	$('#errorScoreLimit2').removeClass("show");
	    	$('#lode').val(''); 
	    }
	});
	$('#lodeSpec').click(function() {
		var scoreSpec=$('#scoreSpec').val();
		var voto = parseInt(scoreSpec);	
		var limitScoreSpec=$('#limitScoreSpec').val();
		var limiteSpec= parseInt(limitScoreSpec);
		if($('#lodeSpec').prop('checked')){
			$('#lodeSpec').val('S');
			if(voto==limiteSpec )
			{ 
				$('#errorScoreSpec').removeClass("show");			
	    	}
	    	else if(voto>limiteSpec)
	    	{
	    		$('#errorScoreSpecLimit2').addClass("show");	   
	    	}
	    	else
	    	{
	    		$('#errorScoreSpecLimit').addClass("show");
	    	}
	    }
		else
		{
	    	$('#errorScoreSpecLimit').removeClass("show");
	    	$('#errorScoreSpecLimit2').removeClass("show");
	    	$('#lodeSpec').val(''); 
	    }
	});
</script>