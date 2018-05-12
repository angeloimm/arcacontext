<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Graduatoria Medici - Ricerca domande</title>
		<script type="text/x-handlebars-template"
			id="templateConfermaCancellazioneDomanda">
			{{#if errori}}
				<div id="erroreCancellazioneContainer" class="alert alert-danger">
					<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
					È avvenuto un errore durante la cancellazione della domanda
					<br/>
					Ti preghiamo di riprovare più tardi.
				</div>
			{{else if successo}}
				<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
					<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
					Cancellazione domanda terminata con successo
				</div>
			{{else if nonCancellabile}}
				<div id="erroreCancellazioneContainer" class="alert alert-danger">
					<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
					Impossibile cancellare la domanda. Lo stato della graduatoria è <strong>chiuso</strong> 
					<br/>
					Ti preghiamo di riprovare con un'altra domanda.
				</div>
			{{else}}
				<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
					Confermi di voler cancellare la domanda 
                	{{#if cf}}
						associata al codice fiscale <strong>{{cf}}</strong>
					{{/if}} 
                	dell'anno <strong>{{anno}}</strong>, graduatoria <strong>{{graduatoria}}</strong> e con codice <strong>{{codiceDomanda}}</strong>?
                	<br/><br/>
                	<strong>Attenzione!</strong> L'operazione non è annullabile
				</div>
			{{/if}}
		</script>
		<script type="text/x-handlebars-template" id="templateErroreCopia">
			{{#if errori}}
				<div id="erroreCancellazioneContainer" class="alert alert-danger">
					<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
					È avvenuto un errore nella duplicazione della domanda.
					<br/>
					Ti preghiamo di riprovare più tardi.
				</div>
			{{/if}}
		</script>
		<script type="text/javascript" charset="UTF8">
			var datiDomanda = {};
			var elencoDomandeDt = null;
			var templateConfermaCancellazioneDomanda = Handlebars.compile($(
					"#templateConfermaCancellazioneDomanda").html());
			var templateErroreCopia = Handlebars.compile($(
			"#templateErroreCopia").html());
			$(function() {
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
				$("#ricercaGraduatorie").click(function(evt) {
					//Prevengo il propagarsi dell'evento
					evt.preventDefault();
					$('#risultati').show();
					reloadTabella();
				});
				$('#risultati').hide();
				elencoDomandeDt = $("#elencoDomande").DataTable(
								{
									"drawCallback": function( settings ) {
									  $('[data-toggle="tooltip"]').tooltip();
									},
									"processing" : true,
									"serverSide" : true,
									"searching" : true,
									"mark" : true,
									"responsive" : true,
									"pageLength" : '${numeroMassimoRecord}',
									 "order": [[ 0, "desc" ],[2,"asc"]], 
									"language" : {
										"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'
									},
									"ajax" : {
										"url" : '<spring:url value="/ricerca/elencoDomande.json" />',
										"dataSrc" : "payload"
									},
									"deferRender" : true,
									"columnDefs" : [
											{
												"render" : function(data, type, row) {
													if (row.anno && row.anno !== 0) {
														return row.anno;
													}
													return "";
												},
												"name" : "id.domaAnno",
												"targets" : 0,
												"class" : "dettaglioDomanda",
											},
											{
												"render" : function(data, type, row) {
													if (row.graduatoria && row.graduatoria !== "") {
														return row.graduatoria;
													}
													return "";
												},
												"name" : "id.domaTipograd",
												"targets" : 1,
												"class" : "dettaglioDomanda",
												"orderable": false,
											},
											{
												"render" : function(data, type, row) {
													if (row.codiceDomanda && row.codiceDomanda !== "") {
														return row.codiceDomanda;
													}
													return "";
												},
												"name" : "id.domaCod",
												"orderable" : true,
												"targets" : 2,
												"class" : "dettaglioDomanda",
											},
											{
												"render" : function(data, type, row) {
													if (row.nominativo && row.nominativo !== "") {
														return row.nominativo;
													}
													return "";
												},
												"name" : "domaNominativo",
												"targets" : 3,
												"class" : "dettaglioDomanda",
												"orderable": false,
											},
											{
												"render" : function(data, type, row) {
													if (row.codiceFiscale && row.codiceFiscale !== "") {
														return row.codiceFiscale;
													}
													return "";
												},
												"name" : "domaCodfisc",
												"targets" : 4,
												"class" : "dettaglioDomanda",
												"orderable": false,
											},
											{
												"render" : function(data, type, row) {
													if (row.dataNascita && row.dataNascita !== 0) {
														return moment(row.dataNascita).format("DD/MM/YYYY");
													}
													return "-";
												},
												"name" : "domaNasData",
												"targets" : 5,
												"class" : "dettaglioDomanda",
												"orderable": false,
											},
											{
												"render" : function(data, type, row) {
												var str='';
												if(row.stato=="AP"){
													str+='<a href="#" class="cancellazioneDomanda" data-toggle="tooltip" title="Cancella domanda"><i class="fa fa-times red" aria-hidden="true"></i></a>';
													if(${sessionScope.stato=='AP'}){
														str+='&nbsp;<a href="#" class="copiaDomanda" data-toggle="tooltip" title="Copia domanda"><i class="fa fa-plus green" aria-hidden="true"></i></a>';
													}else{
														str+='&nbsp;<span class="helper" data-toggle="tooltip" title="Concorso chiuso! Impossibile editare la domanda."><a href="#" class="copiaDomanda disabled"><i class="fa fa-plus green" aria-hidden="true"></i></a></span>';
													} 
												}else{
												    	str+= '<span class="helper" data-toggle="tooltip" title="Concorso chiuso! Impossibile editare la domanda."><a href="#" class="cancellazioneDomanda disabled"><i class="fa fa-times red" aria-hidden="true"></i></a></span>';
														if(${sessionScope.stato=='AP'}){
															str+='&nbsp;<a href="#" class="copiaDomanda" data-toggle="tooltip" title="Copia domanda"><i class="fa fa-plus green" aria-hidden="true"></i></a>';
														}
														else{
															str+='&nbsp;<span class="helper" data-toggle="tooltip" title="Concorso chiuso! Impossibile editare la domanda."><a href="#" class="copiaDomanda disabled"><i class="fa fa-plus green" aria-hidden="true"></i></a></span>';
														}
												}
												return str;
												},
												"name" : "",
												"orderable" : false,
												"targets" : 6
											} ]
								});
				$('#elencoDomande tbody').on('click','td a.cancellazioneDomanda',function(evt) {
						evt.preventDefault();
							var tr = $(this).closest('tr');
							var row = elencoDomandeDt.row(tr);
							var datiDomanda = row.data();
							confermaCancellazioneDomanda(
							  datiDomanda.anno,
							  datiDomanda.graduatoria,
							  datiDomanda.codiceDomanda,
							  datiDomanda.codiceFiscale);
				});
				$('#elencoDomande tbody').on('click','tr .dettaglioDomanda',function(evt) {
					evt.preventDefault();
					var tr = $(this).closest('tr');
					var row = elencoDomandeDt.row(tr);
					var datiDomanda = row.data();
					findDomanda(
						datiDomanda.anno,
						datiDomanda.graduatoria,
						datiDomanda.codiceDomanda,
						datiDomanda.stato);
				});
				$('#elencoDomande tbody').on('click','td a.copiaDomanda',
						function(evt) {
							evt.preventDefault();
							var tr = $(this).closest('tr');
							var row = elencoDomandeDt.row(tr);
							var datiDomanda = row.data();
							dettaglioDomanda(
									datiDomanda.anno,
									datiDomanda.graduatoria,
									datiDomanda.codiceDomanda);
				});
				$(".datepicker_data").datetimepicker({
					format : "DD/MM/YYYY",
					showClose : true,
					locale : 'it',
					showClear : true,
					ignoreReadonly : true,
					maxDate : 'now',
				});
			});
			function reloadTabella() {
				if (elencoDomandeDt && elencoDomandeDt != null) {
					var baseUrl = '<spring:url value="/ricerca/elencoDomande.json" />';
					var filtri = new Object();
					if ($("#codice_domanda").val() !== "") {
						filtri.codice_domanda = $("#codice_domanda").val();
					}
					if ($("#nome").val() !== "") {
						filtri.nome = $("#nome").val();
					}
					if ($("#dataCompilazione").val() !== "") {
						filtri.dataCompilazione = $("#dataCompilazione").val();
					}
					if ($("#codice_fiscale").val() !== "") {
						filtri.codice_fiscale = $("#codice_fiscale").val();
					}
					if ($("#annoRicerca").val() !== "") {
						filtri.annoRicerca = $("#annoRicerca").val();
					}
					if ($("#tipoRicerca").val() !== "") {
						filtri.tipoRicerca = $("#tipoRicerca").val();
					}
					if (baseUrl.indexOf('?') > -1) {
						baseUrl += '&';
					} else {
						baseUrl += '?';
					}
					baseUrl += $.param(filtri);
					elencoDomandeDt.ajax.url(baseUrl).load();
				}
			}
			function confermaCancellazioneDomanda(anno, graduatoria,codiceDomanda, cf) {
				BootstrapDialog.show({
							title : 'Cancellazione Domanda',
							message : function(dialog) {
								var datiDom = new Object();
								datiDom.anno = anno;
								datiDom.graduatoria = graduatoria;
								datiDom.codiceDomanda = codiceDomanda;
								datiDom.cf = cf;
								var $modalBody = templateConfermaCancellazioneDomanda(datiDom);
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
											cancellaDomanda(anno, graduatoria,
											codiceDomanda, dialogRef);
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
			function cancellaDomanda(anno, graduatoria, codiceDomanda, dialogRef) {
				//cancellazioneDomandaContainer
				$.ajax({
							url : '<spring:url value="/ricerca/domanda/'+anno+'/'+graduatoria+'/'+codiceDomanda+'.json" />',
							dataType : 'json',
							contentType : 'application/json; charset=UTF-8',
							type : 'DELETE',
							statusCode: {
								403: function (response){
									dialogRef.setClosable(true);
									dialogRef.getModalFooter().hide();
									var dati = new Object();
									dati.nonCancellabile = true;
									var htmlDialog = templateConfermaCancellazioneDomanda(dati);
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
									var htmlDialog = templateConfermaCancellazioneDomanda(dati);
									dialogRef.getModalBody().html(htmlDialog);
									//Ricarico la tabella aggiornata
									if (elencoDomandeDt != null) {
										elencoDomandeDt.ajax.reload();
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
				var htmlDialog = templateConfermaCancellazioneDomanda(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
			function resetFiltri(){
				$('#form_ricerca_medico').trigger("reset");
				$('#tipoRicerca').val("");
				$('#tipoRicerca').selectpicker('refresh');
				reloadTabella();
			}
			// Funzione per recuperare il dettaglio della domanda al fine di duplicarla
			function dettaglioDomanda(anno, graduatoria, codiceDomanda) {
				$.ajax({
						url : '<spring:url value="/gradDomanda/duplicaDomanda/'+anno+'/'+graduatoria+'/'+codiceDomanda+'.json" />',
						dataType : 'json',
						contentType : 'application/json; charset=UTF-8',
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
						success : function(data) {
							// Apro il tab corrispondente al primo step
							$('.nav-tabs a[href="#menu1"]').tab('show');
							// Rimuovo classe dall'elemento datiAnagrafici e titoli di studio
							$('.nav-tabs #init').removeClass("disabled");
							$('.nav-tabs #init2').removeClass("disabled");		
							window.scrollTo(0, 0);
							var obj = data.payload;
							update = true;
							duplicata = true;
							destroyDataTables();
							// Elimino i messaggi relativi agli errori non bloccanti
							$('#alert_age').css('display','none');
							// Rimuovo la visibilità degli errori non bloccanti relativi alla lode
							$('#errorScoreLimit').removeClass("show");
							$('#errorScoreLimit2').removeClass("show");	
							$('#errorScoreSpecLimit').removeClass("show");
							$('#errorScoreSpecLimit2').removeClass("show");	
							//Controllo per disabilitare la sezione della specializzazione nel caso di concorso MG
							if(obj.tipo==="MG")
								$('#divSpec').addClass('disabled');
							else
								$('#divSpec').removeClass('disabled');
							popolaAnagraficaDuplicata(obj);
						},
						error : function(data) {
							mostraErroreCopia();
						}
				});
			}
			// Funzione che recupera la domanda al fine di modificarla
			function findDomanda(anno, graduatoria, codiceDomanda,stato) {
				 $.ajax({
						url : '<spring:url value="/gradDomanda/dettaglioDomanda/'+anno+'/'+graduatoria+'/'+codiceDomanda+'.json" />',
						dataType : 'json',
						contentType : 'application/json; charset=UTF-8',
						success : function(data) {
							// Apro il tab corrispondente al primo step
							$('.nav-tabs a[href="#menu1"]').tab('show');
							// Rimuovo classe dall'elemento datiAnagrafici
							$('.nav-tabs li').removeClass("disabled");
							// Scrollo verso l'alto
							window.scrollTo(0, 0);
							var obj = data.payload;
							resetAllFormsDomanda();
							if(stato =="CH")
							{
								$('#saveData').prop('disabled',true);
								$('#saveData').prop('title', 'Impossibile editare la domanda!');
								$('#persistData').prop('disabled',true);
							}
							else
							{
								$('#saveData').prop('disabled',false);
								$('#saveData').removeProp('title');
								$('#persistData').prop('disabled',false);
							}
							duplicata = false;
							// Flag utile per consentire la persistenza delle modifiche già nel primo tab della domanda
							update = true;
							obj.update = true;
							if(stato=='AP')
							{
								updatable = true;
							}
							else
							{
								updatable = false;
								$("#addRow").prop('title', 'Impossibile editare la domanda!');
								$("#addRowTitoli").prop('title', 'Impossibile editare la domanda!')
							}
							countBootpag = 2;
							destroyDataTables();
							// Elimino i messaggi relativi agli errori non bloccanti
							$('#alert_age').css('display','none');
							// Rimuovo la visibilità degli errori non bloccanti relativi alla lode
							$('#errorScoreLimit').removeClass("show");
							$('#errorScoreLimit2').removeClass("show");	
							$('#errorScoreSpecLimit').removeClass("show");
							$('#errorScoreSpecLimit2').removeClass("show");	
							// Mostro la tabella del titolo universitario
							$('#tabellaLaurea').show();
							//Controllo per disabilitare la sezione della specializzazione nel caso di concorso MG
							if(obj.tipo==="MG")
								$('#divSpec').addClass('disabled');
							else
								$('#divSpec').removeClass('disabled');
							popolaAnagraficaDuplicata(obj);
						},
						error : function(data) {
							mostraErroreCopia();
						}
				}); 
			}
			function mostraErroreCopia(dialogRef) {				
				BootstrapDialog.show({
					title : 'Duplicazione domanda',
					message : function(dialog) {
						var dati = new Object();
						dati.errori = true;
						var $modalBody = templateErroreCopia(dati);
						return $modalBody;
					},
					size : BootstrapDialog.NORMAL,
					type : BootstrapDialog.TYPE_PRIMARY,
					closable : true,
					draggable : false,
					nl2br : false,
				});
			}
			function popolaAnagraficaDuplicata(obj){
				$('#data').val(obj.data);
				if(obj.indirizzoDomicilio==null)
				{
					var check=true;
					abilitaSelect(check);
				}
				else
				{
					var check=false;
					abilitaSelect(check);
				}
				popolaSelect(obj.provincia,obj.provinciaRes,obj.provDomicilio,obj.ulssReg,obj.ulssAzienda);
				//Setto il comune di nascita che arriva dal db come selected
				$('#luogo').val(obj.luogoNascita);
				$('#luogo').html("<option value='"+obj.luogoNascita+"' selected='selected'>"+obj.luogoNascita+"</option>");
				$('#luogo').selectpicker('refresh');
				// Setto il comune di residenza che arriva dal db come selected
				$('#residenza').val(obj.luogoResidenza);
				$('#residenza').html("<option value='"+obj.luogoResidenza+"' selected='selected'>"+obj.luogoResidenza+"</option>");
				$('#residenza').selectpicker('refresh');
				// Setto il comune di domicilio che arriva dal db come selected dopo aver verificato se è diverso da null
				if(obj.domicilio != null && (obj.domicilio != obj.luogoResidenza))
				{
				$('#domicilio').val(obj.domicilio);
				$('#domicilio').html("<option value='"+obj.domicilio+"' selected='selected'>"+obj.domicilio+"</option>");
				$('#domicilio').selectpicker('refresh');
				}
				//Dati anagrafici
				$('#codice').val(obj.codiceDomanda);
				$('#nominativo').val(obj.nominativo);
				$('#cod_fiscale').val(obj.codiceFiscale);
				//Gestione select sesso
				$('#sesso').val(obj.sesso).prop('selected', true);
				$('#sesso').selectpicker('refresh');
				$('#inputEmail').val(obj.email);
				$('#inputEmailPec').val(obj.pec);
				$('#protocollo').val(obj.protocollo);						
				$('#score').val(obj.voto);
				$('#limitScore').val(obj.votoMax);
				$('#dataLaurea').val(obj.dataLaurea);
				$('#provincia_res').val(obj.provinciaRes);
				$('#inputName').val(obj.cap);				
				$('#indirizzo').val(obj.indirizzo);
				$('#telefono').val(obj.telefonoRes);  
				$('#frazione').val(obj.frazione);
				$('#annoAbilitazione').val(obj.abilitazioneAnno);
				$('#note').val(obj.note);
				$('#data_domanda').val(obj.dataDomanda);
				$('#annoCalcolo').val(obj.anno);
				$('#tipoCalcolo').val(obj.tipo);
				obj.telefonoDomicilio != null ? $('#telefono_domicilio').val(obj.telefonoDomicilio) : null;
				$('#sessione').val(obj.sessione);
				datiDomanda = obj;
				//Sezione domicilio
				if (obj.indirizzoDomicilio==null) 
				{
					disabilitaSezioneDomicilio();
				}else
				{
					$('#cap_domicilio').val(obj.capDomicilio);
					$('#indirizzo_domicilio').val(obj.indirizzoDomicilio);
					$('#telefono_domicilio').val(obj.telefonoRes);   
					$('#frazione_domicilio').val(obj.frazioneDomicilio);
				}
				//Sezione voti
				$('#dataLaureaSpec').val(obj.dataSpecializzazione);
				$('#scoreSpec').val(obj.votoSpecializzazione);
				$('#limitScoreSpec').val((obj.votoMaxSpecializzazione != null ? obj.votoMaxSpecializzazione : '110'));
				if(obj.lode==='S')
				{
					$('#lode').val(obj.lode);
					$('#lode').prop('checked',true);
				}
				else
				{
					$('#lode').val('');
					$('#lode').prop('checked',false);
				}
				if(obj.lodeSpecializzazione==='S')
				{
					$('#lodeSpec').val(obj.lodeSpecializzazione);
					$('#lodeSpec').prop('checked',true);
				}
				else
				{
					$('#lodeSpec').val('');
					$('#lodeSpec').prop('checked',false);
				}
				popolaAnagraficaHeader(datiDomanda);
			}
		function abilitaSelect(check){
		 	$("#luogo").prop("disabled", false);
			$("#provincia").prop("disabled", false);
			$("#provincia_res").prop("disabled",false);
			$('#residenza').prop("disabled",false);
			$('#ulss_residenza').prop("disabled",false);
			if(check)
			{
				// Setto a true lo stato del flag(bootstrapSwitch) che denota la coincidenza tra domicilio e residenza
				$("[name='flag']").bootstrapSwitch('toggleState', true, true);
				$("#domicilio").prop("disabled",true);
				$("#prov_domicilio").prop("disabled",true);
			}else
			{
				$("#domicilio").prop("disabled",false);
				$("#prov_domicilio").prop("disabled",false);
			}
		}
		function popolaSelect(provinciaNascita,provinciaRes,provinciaDom,ulssReg,codAzienda){
			caricaProvinciaDuplicazione(provinciaNascita,provinciaRes,provinciaDom);
			caricaUlssDuplicazione(codAzienda,ulssReg);
		}
		function disabilitaSezioneDomicilio(){
				$('#flag').prop('checked',true);
				$('#indirizzo_domicilio').prop('readonly', true);
				$('#frazione_domicilio').prop('readonly', true);
				$('#cap_domicilio').prop('readonly', true);
				$('#indirizzo_domicilio').prop('required', false);
				$('#cap_domicilio').prop('required', false);
		}
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
								<label for="tipo_esteso" class="control-label">Tipo grad.</label> <input
									type="text" class="form-control height40" id="tipo_esteso" readonly
									value="Graduatoria medici generici">
							</div>
						</c:when>
						<c:otherwise>
							<div class="form-group col-md-3">
								<label for="tipo_esteso" class="control-label">Tipo grad.</label> <input
									type="text" class="form-control height40" id="tipo_esteso" readonly
									value="Graduatoria medici pediatri" required>
							</div>
						</c:otherwise>
					</c:choose>
					<div class="form-group col-md-2">
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
							id="codiceFunzione" readonly value="F_INSDOM">
					</div>
				</div>
			</div>
			<div class="container">
				<ul class="nav nav-tabs" style="margin-top: 20px;">
					<li class="active"><a data-toggle="tab" href="#home">Ricerca
							Domanda</a></li>
					<li class="disabled" id="init"><a data-toggle="tab"
						href="#menu1">Dati anagrafici</a></li>
					<li class="disabled" id="init2"><a data-toggle="tab" href="#menu2">Titoli
							di studio e note</a></li>
					<li class="disabled"><a data-toggle="tab" href="#menu3">Titolarità
							presentate</a></li>
					<li class="disabled"><a data-toggle="tab" href="#menu4">Titoli
							presentati</a></li>
					<li class="disabled"><a data-toggle="tab" href="#menu5">Punteggi
							calcolati</a></li>
				</ul>

				<div class="tab-content">
					<div id="home" class="tab-pane fade in active">
						<jsp:include page="ricercaMedico.jsp" />
					</div>
					<div id="menu1" class="tab-pane fade">
						<jsp:include page="datiAnagraficiDomanda.jsp" />
					</div>
					<div id="menu2" class="tab-pane fade">
						<jsp:include page="titoliStudioNote.jsp" />
					</div>
					<div id="menu3" class="tab-pane fade">
						<jsp:include page="titolarita.jsp" />
					</div>
					<div id="menu4" class="tab-pane fade">
						<jsp:include page="titoli.jsp" />
					</div>
					<div id="menu5" class="tab-pane fade">
						<jsp:include page="punteggi.jsp" />
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>