<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Graduatoria Medici - Titolarit&agrave;</title>
		<script type="text/x-handlebars-template" id="templateCancellazioneTitolarita">
    {{#if errori}}
    <div id="erroreCancellazioneContainer" class="alert alert-danger">
        <i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> È avvenuto un errore durante la cancellazione della titolarit&agrave;
        <br/> Ti preghiamo di riprovare più tardi.
    </div>
	{{else if nonCancellabile}}
	<div id="erroreCancellazioneContainer" class="alert alert-danger">
      	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> Impossibile effettuare la cancellazione. Vi sono dati associati alla titolarit&agrave;
    </div>
	{{else if nonCancellabile}}
	<div id="erroreCancellazioneContainer" class="alert alert-danger">
      	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> E' avvenuto un errore durante la modifica della titolarit&agrave;
    </div>
    {{else if successo}}
    <div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
        <i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> Cancellazione titolarit&agrave; terminata con successo
    </div>
    {{else}}
    <div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
        Confermi di voler cancellare la titolarit&agrave; relativa all'anno
        <strong>{{anno}}</strong>, graduatoria <strong>{{graduatoria}}</strong> e codice <strong>{{codice}}</strong>?
        <br/>
        <br/>
        <strong>Attenzione!</strong> L'operazione non è annullabile
    </div>
    {{/if}}
</script>
<script type="text/x-handlebars-template" id="templateTitolarita">
    {{#if insert}}
    <div class="row">
        <form method="POST" id="form_titolo">
            <div class="form-group col-md-6">
                <label for="anno" class="control-label"> Anno (*)</label>
                <div class="input-group date datepicker_anno">
                    <input id="anno" name="anno" class="form-control" required="true" readonly="readonly" type="text" value="${sessionScope.anno}" /> <span class="input-group-addon"> <span
				class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
            <div class="form-group col-md-6">
                <label for="descrizione" class="control-label">Tipo graduatoria (*)</label>
                <input type="text" class="form-control" id="descrizione" required="true" readonly value="${sessionScope.tipoGraduatoria}"/>
            </div>
            <div class="form-group col-md-6">
                <label for="codiceTitolo" class="control-label">Codice (*)</label>
                <input type="text" class="form-control" id="codiceTitolo" required="true" />
            </div>
            <div class="form-group col-md-6">
                <label for="codice" class="control-label">Descrizione breve (*)</label>
                <input type="text" class="form-control" id="descrizione_breve" required="true" maxlength="15" data-error="Inserire non più di 15 caratteri"/>
            </div>
            <div class="form-group col-md-12">
                <label for="descrizioneTitolo" class="control-label">Descrizione (*)</label>
                <textarea rows="4" cols="50" class="form-control" id="descrizioneTitolo" placeholder="Descrizione completa" required="true" maxlength="50" data-error="Inserire non più di 50 caratteri"/>
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
  		<strong>Attenzione!</strong> Stai modificando la titolarit&agrave; con codice <strong>{{codice}}</strong>
		relativo all'anno <strong>{{anno}}</strong> e tipo <strong>{{tipo}}</strong>.
		</div>
            <div class="form-group col-md-12">
                                            <label for="codice" class="control-label">Descrizione breve (*)</label>
                                            <input type="text" class="form-control" id="descrizione_breve" required="true" maxlength="15" data-error="Inserire non più di 15 caratteri"/>
                                        </div>
                                        <div class="form-group col-md-12">
                                            <label for="descrizioneTitolo" class="control-label">Descrizione (*)</label>
                                            <textarea rows="2" cols="50" class="form-control" id="descrizioneTitolo" placeholder="Descrizione completa" required="true" maxlength="50" data-error="Inserire non più di 50 caratteri"/>
                                        </div>
										<div class="align_center red" style="display:none;" id="error">
											<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
											&nbsp; I campi contrassegnati dall'asterisco sono obbligatori
										</div>
                                    </form>
                                </div>
								<script>
								$(function(){
									$('#descrizioneTitolo').val(descrizioneModal);
									$('#descrizione_breve').val(descrizioneBreveModal);
								});
								{{else if modificaSuccess}}
                                <div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
                                    <i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> Modifica titolarit&agrave; avvenuta con successo
                                </div>
        {{else if insertSuccess}}
        <div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
            <i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> Inserimento titolarit&agrave; effettuato con successo
        </div>
        {{else}}
        <div id="erroreCancellazioneContainer" class="alert alert-danger">
            <i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> È avvenuto un errore durante l'inserimento della titolarit&agrave;
            <br/> Ti preghiamo di riprovare più tardi.
        </div>
        {{/if}}
		</script>
		<script type="text/javascript" charset="UTF8">
			var elencoTitolaritaDt = null;
			var templateCancellazioneTitolarita = Handlebars.compile($(
					"#templateCancellazioneTitolarita").html());
			var templateTitolarita = Handlebars
					.compile($("#templateTitolarita").html());
			var descrizioneModal = null;
			var descrizioneBreveModal = null;
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
				$("#ricercaTitolarita").click(function(evt) {
					//Prevengo il propagarsi dell'evento
					evt.preventDefault();
					reloadTabella();
				});
				elencoTitolaritaDt = $("#elencoTitolarita")
						.DataTable(
								{
									"drawCallback" : function(settings) {
										$('[data-toggle="tooltip"]').tooltip();
									},
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
										"url" : '<spring:url value="/table/elencoTitolarita.json" />',
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
												"class" : "dettaglioClickable",
												"name" : "id.ttl1Anno",
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
												"class" : "dettaglioClickable",
												"name" : "id.ttl1Tipograd",
												"targets" : 1
											},
											{
												"render" : function(data, type,
														row) {
													if (row.codice
															&& row.codice !== "") {
														return row.codice;
													}
													return "";
												},
												"class" : "dettaglioClickable",
												"name" : "id.ttl1Titolarita",
												"orderable" : true,
												"targets" : 2
											},
											{
												"render" : function(data, type,
														row) {
													if (row.descrizione
															&& row.descrizione !== "") {
														return row.descrizione;
													}
													return "";
												},
												"class" : "dettaglioClickable",
												"name" : "ttl1Descr",
												"targets" : 3
											},
											{
												"render" : function(data, type,
														row) {
													if (row.descrizioneBreve
															&& row.descrizioneBreve !== "") {
														return row.descrizioneBreve;
													}
													return "";
												},
												"class" : "dettaglioClickable",
												"name" : "ttl1Descabb",
												"targets" : 4
											},
											{
												"render" : function(data, type,
														row) {
													return '<a href="#" class="cancellazione" data-toggle="tooltip" title="Cancella"><i class="fa fa-times red" aria-hidden="true"></i></a>'
												},
												"name" : "",
												"orderable" : false,
												"targets" : 5
											} ]
								});
				$('#elencoTitolarita tbody').on('click','tr .dettaglioClickable',function(evt) {
					evt.preventDefault();
					var tr = $(this).closest('tr');
					var row = elencoTitolaritaDt.row(tr);
					var datiTitolarita = row.data();
					findTitolarita(datiTitolarita);
				});
				$('#elencoTitolarita tbody').on(
						'click',
						'td a.cancellazione',
						function(evt) {
							evt.preventDefault();
							var tr = $(this).closest('tr');
							var row = elencoTitolaritaDt.row(tr);
							var dati = row.data();
							confermaCancellazioneTitolarita(dati.anno,
									dati.tipo, dati.codice);
						});
				$('#nuovaTitolarita').click(function(evt) {
					evt.preventDefault();
					BootstrapDialog.show({
												title : 'Inserimento titolatit&agrave;',
												message : function(dialog) {
													var dati = new Object();
													dati.insert = true;
													var $modalBody = templateTitolarita(dati);
													return $modalBody;
												},
												onshown: function(dialog){
													$('#form').validator();
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
															label : 'Salva',
															cssClass : 'btn-primary',
															autospin : false,
															action : function(dialogRef) {
																dialogRef.enableButtons(true);
																dialogRef.setClosable(true);
																var data = new Object();
																data.descrizione = $('#descrizioneTitolo').val();
																data.descrizioneBreve = $('#descrizione_breve').val();
																data.codice = $('#codiceTitolo').val();
																salvaTitolarita(data,dialogRef);

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
								$('#stampaTabellaTitolarita').click(function() {
									var dialog = BootstrapDialog.show({
                                		title : 'Download in corso',
                                		message : function(dialog) {
                                			var $modalBody = '<center><h2><img src="'+Constants.contextPath+Constants.loaderImg+'" /></h2>'
                                				+' Stiamo processando la richiesta...';
                                			return $modalBody;
                                		},
                                		size : BootstrapDialog.NORMAL,
                                		type : BootstrapDialog.TYPE_PRIMARY,
                                		closable : true,
                                		draggable : false,
                                		nl2br : false,
                                	});
									var codice = $('#codice').val();
									var descrizione = $('#descrizione').val();
								 	if(window.ActiveXObject)
								    {
								      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
								    }
								    else if(window.XMLHttpRequest)
								    {
								      xmlHttp=new XMLHttpRequest();
								    }
									var url = Constants.contextPath + 'report/stampaRicercaTitolarita?codice='+codice+'&descrizione='+descrizione;
								    xmlHttp.open("GET",url, true);
								    xmlHttp.responseType = "blob";
								    xmlHttp.onload = function(e) {
												if (this.status === 200) {
													var file = window.URL.createObjectURL(this.response);
													var a = document.createElement("a");
													a.href = file;
													a.download = "Stampa_titolarita.pdf";
													document.body.appendChild(a);
													a.click();
													setTimeout(function(){dialog.close(); }, 1000);
												}
												;
											};
								    xmlHttp.setRequestHeader('Content-Type', 'application/json');
								    xmlHttp.send();
										})
			});
			function reloadTabella() {
				if (elencoTitolaritaDt && elencoTitolaritaDt != null) {
					var baseUrl = '<spring:url value="/table/elencoTitolarita.json" />';
					var filtri = new Object();
					if ($("#codice").val() !== "") {
						filtri.codice = $("#codice").val();
					}
					if ($("#descrizione").val() !== "") {
						filtri.descrizione = $("#descrizione").val();
					}
					if ($("#anno").val() !== "") {
						filtri.anno = $("#anno").val();
					}
					if ($("#tipo").val() !== "") {
						filtri.tipo = $("#tipo").val();
					}
					if (baseUrl.indexOf('?') > -1) {
						baseUrl += '&';
					} else {
						baseUrl += '?';
					}
					baseUrl += $.param(filtri);
					elencoTitolaritaDt.ajax.url(baseUrl).load();
				}
			}
			function salvaTitolarita(obj, dialogRef) {
				// Controllo sui campi obbligatori
				if($('#form_titolo').validator('validate').has('.has-error').length > 0 ){
            		$('#error').css('display','block');
        			return;
        		}
				$.ajax({
					type : 'POST',
					url : '<spring:url value="/table/salvaTitolarita.json" />',
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
							var htmlDialog = templateTitolarita(dati);
							dialogRef.getModalBody().html(htmlDialog);
							//Ricarico la tabella aggiornata
							if (elencoTitolaritaDt != null) {
								elencoTitolaritaDt.ajax.reload();
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
			function confermaCancellazioneTitolarita(anno, tipo, codice) {
				BootstrapDialog.show({
					title : 'Cancellazione titolarit&agrave;',
					message : function(dialog) {
						var dati = new Object();
						dati.anno = anno;
						dati.graduatoria = tipo;
						dati.codice = codice;
						var $modalBody = templateCancellazioneTitolarita(dati);
						return $modalBody;
					},
					size : 'size-wide',
					type : BootstrapDialog.TYPE_PRIMARY,
					closable : true,
					draggable : false,
					nl2br : false,
					buttons : [ {
						id : 'conferma',
						icon : 'fa fa-trash-o',
						label : 'Conferma',
						cssClass : 'btn-warning',
						autospin : false,
						action : function(dialogRef) {
							dialogRef.enableButtons(false);
							dialogRef.setClosable(false);
							cancellaTitolarita(anno, tipo, codice, dialogRef);

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
			function cancellaTitolarita(anno, tipo, codice, dialogRef) {
				$.ajax({
							url : '<spring:url value="/table/cancellaTitolarita/'+anno+'/'+tipo+'/'+codice+'.json" />',
							dataType : 'json',
							contentType : 'application/json; charset=UTF-8',
							type : 'DELETE',
							statusCode: {
								403: function (response){
									dialogRef.setClosable(true);
									dialogRef.getModalFooter().hide();
									var dati = new Object();
									dati.nonCancellabile = true;
									var htmlDialog = templateCancellazioneTitolarita(dati);
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
									var htmlDialog = templateCancellazioneTitolarita(dati);
									dialogRef.getModalBody().html(htmlDialog);
									//Ricarico la tabella aggiornata
									if (elencoTitolaritaDt != null) {
										elencoTitolaritaDt.ajax.reload();
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
				//dialogRef.setType(BootstrapDialog.TYPE_DANGER);
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				dati.errori = true;
				var htmlDialog = templateCancellazioneTitolarita(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
			function mostraErroreInserimento(dialogRef) {
				//dialogRef.setType(BootstrapDialog.TYPE_DANGER);
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var htmlDialog = templateTitolarita();
				dialogRef.getModalBody().html(htmlDialog);
			}
			function findTitolarita(obj){
				BootstrapDialog.show({
					title : 'Modifica titolatit&agrave;',
					message : function(dialog) {
						descrizioneModal = obj.descrizione;
						descrizioneBreveModal = obj.descrizioneBreve;
						var dati = new Object();
						dati.anno = obj.anno;
						dati.tipo = obj.tipo;
						dati.codice = obj.codice;
						dati.modifica = true;
						var $modalBody = templateTitolarita(dati);
						return $modalBody;
					},
					onshown: function(dialog){
						$('#form_titolo').validator();
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
									dialogRef.enableButtons(true);
									dialogRef.setClosable(true);
									var data = new Object();
									data.anno = obj.anno;
									data.tipo = obj.tipo;
									data.codice = obj.codice;
									data.descrizione = $('#descrizioneTitolo').val();
									data.descrizioneBreve = $('#descrizione_breve').val();
									modificaTitolarita(data,dialogRef);
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
			function modificaTitolarita(obj, dialogRef){
            	// Controllo sui campi obbligatori
				if($('#form_titolo').validator('validate').has('.has-error').length > 0 ){
            		$('#error').css('display','block');
        			return;
        		}
                $.ajax({
                    type: 'POST',
                    url: '<spring:url value="/table/modificaTitolarita.json" />',
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
                            var htmlDialog = templateTitolarita(dati);
                            dialogRef.getModalBody().html(htmlDialog);
                            //Ricarico la tabella aggiornata
                            if (elencoTitolaritaDt != null) {
                            	elencoTitolaritaDt.ajax.reload();
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
			 function mostraErroreModifica(dialogRef) {
                 dialogRef.setClosable(true);
                 dialogRef.getModalFooter().hide();
                 var dati = new Object();
                 dati.erroriModifica = true;
                 var htmlDialog = templateTitolarita(dati);
                 dialogRef.getModalBody().html(htmlDialog);
             }
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">

		<div class="sfondo_body">
			<div class="container">
				<div class="row">
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
								id="codiceFunzione" readonly value="${funzione}">
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="bs-panel">
								<div class="panel panel-default panel_padding_l_r">
									<div class="panel-body panel_min_height home_news">
										<!-- ANNO -->
										<div class="form-group col-md-4">
											<label for="anno" class="control-label">Anno</label> <input
												type="text" class="form-control" id="anno" readonly
												value="${sessionScope.anno}" required>
										</div>
										<!-- TIPO GRADUATORIA -->
										<div class="form-group col-md-4">
											<label for="tipo" class="control-label">Tipo grad.</label> <input
												type="text" class="form-control" id="tipo" readonly
												value="${sessionScope.tipoGraduatoria}" required>
										</div>
										<!-- FORM RICERCA -->
										<form  role="form">
											<!-- CODICE -->
											<div class="form-group col-md-6">
												<label for="codice" class="control-label">Codice</label> <input
													type="text" class="form-control" id="codice">
											</div>
											<!-- DESCRIZIONE -->
											<div class="form-group col-md-6">
												<label for="descrizione" class="control-label">Descrizione
												</label> <input type="text" class="form-control" id="descrizione">
											</div>
											<div class="form-group col-md-5 margin10">
												<button type="submit" id="ricercaTitolarita"
													class="btn btn-default btn-large button_salva">
													<i class="fa fa-search" aria-hidden="true"></i>&nbsp;Ricerca
												</button>
												<button type="button"
													class="btn btn-default btn-large button_salva"
													id="nuovaTitolarita">
													<i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Nuovo
												</button>
												<button type="button"
													class="btn btn-default btn-large button_salva"
													id="stampaTabellaTitolarita">
													<i class="fa fa-print" aria-hidden="true"></i>&nbsp;Stampa
												</button>
											</div>
										</form>
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
									<table id="elencoTitolarita"
										class="datatables-table table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Anno</th>
												<th>Grad</th>
												<th>Codice</th>
												<th>Descrizione</th>
												<th>Descrizione breve</th>
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