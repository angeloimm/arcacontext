<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<spring:url value="/docs/" var="baseDocsUrl"/>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Graduatoria Medici - Documenti</title>
		<script type="text/javascript" charset="UTF8">
			$(document).ready(function() {

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

			});			
		</script>
		<script type="text/x-handlebars-template" id="templateAzioniDocumento">
			<a data-toggle="tooltip" title="" class="btn btn-default btn-xs button_scarica download" href="${baseDocsUrl}download/{{idDocumento}}" id="downloadDoc_{{idDocumento}}" data-original-title="Scarica Documento">
				<span class="glyphicon glyphicon-download"></span>
			</a>
			<a data-toggle="tooltip" title="Cancella Documento" id="cancellaDoc_{{idDocumento}}" class="btn btn-danger btn-xs button_elimina cancellazioneDocumento" href="#" data-original-title="Cancella Documento">
				<span class="glyphicon glyphicon-trash"></span>
			</a>	
		</script>
		<script type="text/x-handlebars-template" id="templateconfermaCancellazioneDocumento">
			{{#if errori}}
				<div id="erroreCancellazioneContainer" class="alert alert-danger">
					<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
					È avvenuto un errore durante la cancellazione della documento
					<br/>
					Ti preghiamo di riprovare più tardi.
				</div>
			{{else if successo}}
				<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
					<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
					Cancellazione documento terminata con successo
				</div>
			{{else}}
				<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
					Confermi di voler cancellare il documento <strong>{{nomeDocumento}}</strong>?
                	<br/><br/>
                	<strong>Attenzione!</strong> L'operazione non è annullabile
				</div>
			{{/if}}
		</script>		
		<script type="text/javascript" charset="UTF8">
			var elencoDocumentiDt = null;
			var templateconfermaCancellazioneDocumento = Handlebars.compile($("#templateconfermaCancellazioneDocumento").html());
			var templateAzioniDocumento = Handlebars.compile($("#templateAzioniDocumento").html());
			$(function() {
				$("#ricercaGraduatorie").click(function(evt){
					//Prevengo il propagarsi dell'evento
					evt.preventDefault();
					reloadTabella();
				});
				elencoDocumentiDt = $("#elencoDomande").DataTable({
					"processing" : true,
					"serverSide" : true,
					"searching"  : true,
					"mark"       : true,
					"pageLength":'${numeroMassimoRecord}',
					"language" : {
						"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'
					},
					"ajax" : {
						"url" : '<spring:url value="/docs/elencoDocumenti.json" />',
						"dataSrc" : "payload"
					},
					"deferRender" : true,
					"drawCallback" : function (settings)
					{
						abilitaTooltip();
					},
					"columnDefs" : 
					[
							{
								"render" : 	function(data, type, row) 
											{
												if (row.nome && row.nome !== 0) 
												{
	
													return row.nome;
											 	}
											 	return "";
											 },
								"name" : "nome",
								"targets" : 0
							},						
							{
								"render" : 	function(data, type, row) 
											{
												if (row.descrizione && row.descrizione !== 0) 
												{

													return row.descrizione;
											 	}
											 	return "";
											 },
								"name" : "descrizione",
								"targets" : 1
							},
							{
								"render" : 	function(data, type, row) 
											{
												if (row.versione && row.versione !== "") 
												{

													return row.versione;
												}
												return "";
											},
								"name" : "versione",
								"targets" : 2
							},
							{
								"render" : 	function(data, type, row) 
											{
												var dati = new Object();
												dati.idDocumento = row.idDoc;
												return templateAzioniDocumento(dati);
											},
								"name" : "",
								"orderable" : false,
								"targets" : 3
							}
					]
				});
				$('#elencoDomande tbody').on(
						'click',
						'td a.cancellazioneDocumento',
						function(evt) {
							evt.preventDefault();
							var tr = $(this).closest('tr');
							var row = elencoDocumentiDt.row(tr);
							var datiDocumento = row.data();
							var nomeDocumento = datiDocumento.fileName;
							if( nomeDocumento == null || nomeDocumento === "" )
							{
								nomeDocumento = datiDocumento.nome;
							}
							confermaCancellazioneDocumento(datiDocumento.idDoc, nomeDocumento);
						});
			});
			function abilitaTooltip()
			{
				 $('[data-toggle="tooltip"]').tooltip(); 
			}
			function reloadTabella()
			{
				if(elencoDocumentiDt && elencoDocumentiDt != null)
				{
					var baseUrl = elencoDocumentiDt.ajax.url();
					var filtri = new Object();
					if( $("#codice_domanda").val() !== "" )
					{
						filtri.codice_domanda = $("#codice_domanda").val();
					}
					if( $("#nome").val() !== "" )
					{
						filtri.nome = $("#nome").val();
					}	
					if( $("#dataCompilazione").val() !== "" )
					{
						filtri.dataCompilazione = $("#dataCompilazione").val();
					}
					if( $("#codice_fiscale").val() !== "" )
					{
						filtri.codice_fiscale = $("#codice_fiscale").val();
					}
					if( baseUrl.indexOf('?') > -1 )
					{
						baseUrl += '&';
					}
					else
					{
						baseUrl += '?';
					}
					baseUrl += $.param( filtri );
					elencoDocumentiDt.ajax.url(baseUrl).load();
				}
			}
			function confermaCancellazioneDocumento(idDocumento, nomeDocumento)
			{
				
				BootstrapDialog.show({
		            title: 'Cancellazione Documento',
		            message: function(dialog) {
		                var datiDoc = new Object();
		                datiDoc.nomeDocumento = nomeDocumento;
		                var $modalBody = templateconfermaCancellazioneDocumento(datiDoc);
		                return $modalBody;
		            },
		            size: 'size-wide',
		            type: BootstrapDialog.TYPE_PRIMARY,
		            closable: true, 
		            draggable: false,
		            nl2br:false,
		            buttons: [{
		            	id  : 'conferma',
		                icon: 'fa fa-trash-o',
		                label: 'Conferma',
		                cssClass: 'btn-warning',
		                autospin: true,
		                action: function(dialogRef){
		                	
		                    dialogRef.enableButtons(false);
		                    dialogRef.setClosable(false);
		                    cancellaDocumento(idDocumento, dialogRef);
		                   
		                }
		            }, {
		            	id  : 'annullaConferma',
		                label: 'Annulla',
		                action: function(dialogRef){
		                    dialogRef.close();
		                }
		            }]
		        });
			}
			function cancellaDocumento(idDocumento, dialogRef)
			{
				//cancellazioneDomandaContainer
				$.ajax({
					url : '<spring:url value="/docs/cancella/'+idDocumento+'.json" />',
					dataType : 'json',
					contentType : 'application/json; charset=UTF-8',
					type : 'DELETE',
					success : function(data) 
								{
									var codiceEsito = data.codiceOperazione;
									if (codiceEsito == 200) 
									{
										//dialogRef.setType(BootstrapDialog.TYPE_SUCCESS);
										dialogRef.setClosable(true);
										dialogRef.getModalFooter().hide();
										var dati = new Object();
										dati.successo = true;
										var htmlDialog = templateconfermaCancellazioneDocumento(dati);
										dialogRef.getModalBody().html(htmlDialog);
										//Ricarico la tabella aggiornata
										if( elencoDocumentiDt != null )
										{
											elencoDocumentiDt.ajax.reload();
										}
									}
									else if (codiceEsito == 500) 
									{
										mostraErroreCancellazione(dialogRef);
									} 
								},
					error : function(data)	
								{
									mostraErroreCancellazione(dialogRef);
								}
				});
			}
			function mostraErroreCancellazione(dialogRef)
			{
				//dialogRef.setType(BootstrapDialog.TYPE_DANGER);
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				dati.errori = true;
				var htmlDialog = templateconfermaCancellazioneDocumento(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
		</script>		
	</tiles:putAttribute>
	<tiles:putAttribute name="body">

		<div class="sfondo_body">
			<div class="container">
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body panel_min_height home_news">
									<table id="elencoDomande" class="datatables-table table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Nome</th>
												<th>Descrizione</th>
												<th>Versione</th>
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