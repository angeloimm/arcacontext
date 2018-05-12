<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Graduatoria Medici - Titolarit&agrave; graduatoria</title>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
	<script type="text/x-handlebars-template" id="templateInserimento">
	<form role="form" id="form_inserimento">
	<div class="row">
	<p style="margin-left:10px;"><strong>Titolarit&agrave;</strong></p>
	<div class="form-group col-md-2">
         <label for="codiceTitolarita" class="control-label">Cod (*)</label>
         <input type="text" class="form-control"
         id="codiceTitolarita" required="true"/>
    </div>
	<div class="form-group col-md-10">
         <label for="descrizioneTitolarita" class="control-label">Descrizione (*)</label>
         <input type="text" class="form-control" readonly="true"
         id="descrizioneTitolarita" required="true"/>
    </div>
	</div>
	</div>
	<hr>
	<div class="row">
	<p style="margin-left:10px;"><strong>Titolo corrispondente</strong></p>
	<div class="form-group col-md-2">
         <label for="codiceTitolo" class="control-label">Cod (*)</label>
         <input type="text" class="form-control"
         id="codiceTitolo" required="true"/>
    </div>
	<div class="form-group col-md-10">
         <label for="descrizioneTitolo" class="control-label">Descrizione (*)</label>
         <input type="text" class="form-control" readonly="true"
         id="descrizioneTitolo" required="true"/>
    </div>
	</div>
	</div>
	</form>
	</script>
	<script type="text/x-handlebars-template" id="templateModifica">
	{{#if modifica}}
	<div class="row">
	<form role="form" name="formTitolarita">
	<div class="alert alert-warning">
  	Stai modificando la titolarit&agrave; anno con codice
	<strong> {{codiceTitolarita}}</strong>, dell'anno <strong>${sessionScope.anno}</strong>
	 e tipo <strong>${sessionScope.tipoGraduatoria}</strong> .
	</div>
	<div class="form-group col-md-6">
         <label for="codiceTitolo" class="control-label">Codice titolo (*)</label>
         <input type="text" class="form-control"
         id="codiceTitolo" required="true"/>
         </div>
	</div>
 		<script>
         $(function(){
         $('#codiceTitolo').val(codiceTitoloModal);
         })
         <{{!}}/script>
	</form>
	{{else if modificaSuccess}}
	<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
	Modifica titolarit&agrave; anno avvenuta correttamente 
	</div>
	{{else if insertSuccess}}
	<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
		Inserimento titolarit&agrave; anno avvenuta correttamente 
	</div>
	{{else}}
	<div id="erroreCancellazioneContainer" class="alert alert-danger">
		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
		È avvenuto un errore durante la modifica della titolarit&agrave;
		<br/>
		Ti preghiamo di riprovare più tardi.
	</div>
	{{/if}}
	</script>
	<script type="text/x-handlebars-template" id="templateCancellazione">
	{{#if successo}}
	<div id="erroreCancellazioneContainer" class="alert alert-success" role="alert">
		<i class="fa fa-check green" aria-hidden="true"></i>&nbsp;<strong>Successo!</strong> 
		Cancellazione titolarit&agrave; terminata con successo
	</div>
	{{else if nonCancellabile}}
	<div id="erroreCancellazioneContainer" class="alert alert-danger">
			<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
			Impossibile cancellare la titolarità. Vi sono dati ad essa associati.
			<br/>
			Ti preghiamo di riprovare con un'altra titolarit&agrave;.
	</div>
	{{else if errori}}
	<div id="erroreCancellazioneContainer" class="alert alert-danger">
		<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
		È avvenuto un errore durante la cancellazione della titolarit&agrave;
		<br/>
		Ti preghiamo di riprovare più tardi.
	</div>
	{{else}}
	<div id="cancellazioneDomandaContainer" class="alert alert-warning" role="alert">
			Confermi di voler cancellare la titolarit&agrave; anno
            <strong>{{anno}}</strong>, graduatoria <strong>{{tipo}}</strong> e
            descrizione <i>{{descrizione}}</i> ?
			<br/><br/>
            <strong>Attenzione!</strong> L'operazione non è annullabile
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
							id="codiceFunzione" readonly value="F_TBTLYR">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body panel_min_height home_news">
									<h3>TABELLA TITOLARIT&Aacute; PER GRADUATORIA</h3>
									<table id="titolaritaAnnoTable"
										class="datatables-table table table-striped table-bordered table-hover">
										<thead>
											<tr id="addRow">
												<th>Codice</th>
												<th>Titolarit&agrave; / note</th>
												<th>Cod.Titolo</th>
												<th>Descrizione Titolo</th>
												<th></th>
											</tr>
										</thead>
										</tbody>
									</table>
						<div class="form-group col-md-5 margin10">
							<button type="submit" id="nuovaTitGrad" class="btn btn-default btn-large button_salva">
							<i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Nuovo</button>
						</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" charset="UTF-8">
		var templateCancellazione = Handlebars.compile($("#templateCancellazione").html());
		var templateModifica = Handlebars.compile($("#templateModifica").html());
		var templateInserimento = Handlebars.compile($('#templateInserimento').html());
		var codiceTitoloModal = null;
		var elencoTitolarita = null;
		$(function(){
		elencoTitolaritaDt = $("#titolaritaAnnoTable").DataTable(
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
						"url" : '<spring:url value="/cont/elencoTitolaritaAnno.json" />',
						"dataSrc" : "payload"
					},
					"deferRender" : true,
					"columnDefs" : [
							{
								"render" : function(data, type,row) {
									if(row.codiceTitolarita && row.codiceTitolarita !=""){
										return row.codiceTitolarita;
									}
									return "";
								},
								"visible" : true,
								"name" : "codiceTitolarita",
								"targets" : 0,
							},
							{
								"render" : function(data, type,row) {
									if(row.descrizione && row.descrizione !=""){
										return row.descrizione;
									}
									return "";
								},
								"name" : "descrizione",
								"targets" : 1,
							},
							{
								"render" : function(data, type,row) {
									if (row.codice && row.codice !== 0) {
										return row.codice;
									}
									return "";
								},
								"name" : "codice",
								"targets" : 2,
							},
							{
								"render" : function(data, type,row) {
									if(row.descrizioneTitolo && row.descrizioneTitolo !==""){
										return row.descrizioneTitolo;
									}
									return "";
								},
								"name" : "descrizioneTitolo",
								"targets" : 3,
							},
							{
                                "render": function(data, type, row) {
                                    return '<a href="#" class="cancellazione" data-toggle="tooltip" title="Cancella"><i class="fa fa-times red" aria-hidden="true"></i></a>'
                                		+  ' &nbsp; <a href="#" class="modifica" data-toggle="tooltip" title="Modifica"><i class="fa fa-refresh green" aria-hidden="true"></i></a>'
                                },
                                "name": "",
                                "orderable": false,
                                "targets": 4
                            }]
				});
		$('#titolaritaAnnoTable tbody').on('click','tr .cancellazione',function(evt) {
			evt.preventDefault();
			var tr = $(this).closest('tr');
			var row = elencoTitolaritaDt.row(tr);
			var dati = row.data();
			cancellaRiga(dati);
		});
		$('#titolaritaAnnoTable tbody').on('click','tr .modifica',function(evt) {
			evt.preventDefault();
			var tr = $(this).closest('tr');
			var row = elencoTitolaritaDt.row(tr);
			var dati = row.data();
			modificaRiga(dati);
		});
		});
		$('#nuovaTitGrad').click(function(evt){
			BootstrapDialog.show({
     			title : 'Inserimento titolarit&agrave;',
     			message : function(dialog) { 
     				var $modalBody = templateInserimento();
     				return $modalBody;
     			},
     			size : BootstrapDialog.NORMAL,
     			type : BootstrapDialog.TYPE_PRIMARY,
     			closable : true,
     			draggable : false,
     			nl2br : false,
			 	onshown: function(dialog){
			 		$('#form_inserimento').validator();
			 		$('#codiceTitolarita').blur(function(evt){
			 			var codiceTitolarita = $('#codiceTitolarita').val();
			 			$.ajax({
							type : 'GET',
							url : '<spring:url value="/cont/findTitolarita/'+codiceTitolarita+'.json" />',
							contentType : 'application/json; charset=UTF-8',
							dataType : 'json',
							success : function(data) 
							{
								$('#descrizioneTitolarita').val(data.payload.descrizione);
							}
					   });
			 		})
			 			$('#codiceTitolo').blur(function(evt){
			 			var codiceTitolo = $('#codiceTitolo').val();
			 			$.ajax({
							type : 'GET',
							url : '<spring:url value="/cont/findTitolaritaByTitolo/'+codiceTitolo+'.json" />',
							contentType : 'application/json; charset=UTF-8',
							dataType : 'json',
							success : function(data) 
							{
								$('#descrizioneTitolo').val(data.payload.descrizione);
							}
					   });
			 		})
			    },  
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
     							data.codiceTitolarita = $('#codiceTitolarita').val();
     							data.codice = $('#codiceTitolo').val();
     							data.descrizioneTitolo = $('#descrizioneTitolo').val();;
     							data.descrizione = $('#descrizioneTitolarita').val();
     							storeRecord(data, dialogRef);
     						}
     					}, {
     						id : 'annullaConferma',
     						label : 'Annulla',
     						action : function(dialogRef) {
     							dialogRef.close();
     						}
     					} ]
     		});
		})
		function storeRecord(data,dialogRef){
			if($('#form_inserimento').validator('validate').has('.has-error').length > 0 ){
    			return;
    		}
			$.ajax({
                type: 'POST',
                url: '<spring:url value="/cont/salvaTitolaritaAnno.json" />',
                dataType: 'json',
                data: JSON.stringify(data),
                contentType: 'application/json; charset=UTF-8',
                success: function(data) {
                    var codiceEsito = data.codiceOperazione;
                    if (codiceEsito == 200) {
                        dialogRef.setClosable(true);
                        dialogRef.getModalFooter().hide();
                        var dati = new Object();
                        dati.insertSuccess = true;
                        var htmlDialog = templateModifica(dati);
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
		function modificaRiga(obj){
     		BootstrapDialog.show({
     			title : 'Modifica titolarit&agrave;',
     			message : function(dialog) { 
     				var dati = new Object();
     				codiceTitoloModal = obj.codice;
     				dati.codiceTitolarita = obj.codiceTitolarita;
     				dati.modifica = true;
     				var $modalBody = templateModifica(dati);
     				return $modalBody;
     			},
     			size : BootstrapDialog.NORMAL,
     			type : BootstrapDialog.TYPE_PRIMARY,
     			closable : true,
     			draggable : false,
     			nl2br : false,
			 	onshown: function(dialog){
					 $('form[name="formTitolarita"] input, select, .datepicker_periodoDal, .datepicker_periodoAl').on('keyup change dp.change',function(){
					   if($('#codiceTitolo').val() ===""){
						   dialog.getButton('conferma').disable();
					   }else{
						   dialog.getButton('conferma').enable();
					   }
					}); 
			        },  
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
     							data.titolarita  = obj.codiceTitolarita;
     							data.codiceTitolo = $('#codiceTitolo').val();
     							confermaModificaTitolarita(data, dialogRef);
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
		function confermaModificaTitolarita(data, dialogRef){
			$.ajax({
                type: 'GET',
                url: '<spring:url value="/cont/modificaTitolaritaAnno/'+data.titolarita+'/'+data.codiceTitolo+'.json" />',
                dataType: 'json',
                contentType: 'application/json; charset=UTF-8',
                success: function(data) {
                    var codiceEsito = data.codiceOperazione;
                    if (codiceEsito == 200) {
                        dialogRef.setClosable(true);
                        dialogRef.getModalFooter().hide();
                        var dati = new Object();
                        dati.modificaSuccess = true;
                        var htmlDialog = templateModifica(dati);
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
		function mostraErroreModifica(dialogRef){
			//dialogRef.setType(BootstrapDialog.TYPE_DANGER);
     		dialogRef.setClosable(true);
     		dialogRef.getModalFooter().hide();
     		var dati = new Object();
     		dati.modificaError = true;
     		var htmlDialog = templateModifica(dati);
     		dialogRef.getModalBody().html(htmlDialog);
		}
		function cancellaRiga(obj){
			BootstrapDialog.show({
				title : 'Cancellazione titolarit&agrave;',
				message : function(dialog) {
					var dati = new Object();
					dati.anno = ${sessionScope.anno};
					dati.tipo = '${sessionScope.tipoGraduatoria}';
					dati.codiceTitolo = obj.codiceTitolo;
					dati.codiceTitolarita = obj.codiceTitolarita;
					dati.descrizione = obj.descrizione;
					var $modalBody = templateCancellazione(dati);
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
								cancellaTitolaritaAnno(${sessionScope.anno}, '${sessionScope.tipoGraduatoria}',obj.codiceTitolarita, dialogRef);
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
		function cancellaTitolaritaAnno(anno,tipo,codice,dialogRef){
			$.ajax({
				url : '<spring:url value="/cont/cancellaTitolarita/'+anno+'/'+tipo+'/'+codice+'.json" />',
				dataType : 'json',
				contentType : 'application/json; charset=UTF-8',
				type : 'DELETE',
				statusCode: {
					403: function (response){
						dialogRef.setClosable(true);
						dialogRef.getModalFooter().hide();
						var dati = new Object();
						dati.nonCancellabile = true;
						var htmlDialog = templateCancellazione(dati);
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
						var htmlDialog = templateCancellazione(dati);
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
			function mostraErroreCancellazione(dialogRef) {
				dialogRef.setClosable(true);
				dialogRef.getModalFooter().hide();
				var dati = new Object();
				dati.errori = true;
				var htmlDialog = templateCancellazione(dati);
				dialogRef.getModalBody().html(htmlDialog);
			}
		}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>