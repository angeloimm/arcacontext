<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<spring:url value="/rest/simpleJson.json" var="urlJson"/>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Home page</title>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="sfondo_body">
			<div class="container container_min_height">
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body panel_min_height home_news">
									<h4 class="panel-title text-center">
										<label class="sub-title">AGGIORNAMENTI</label>
									</h4>
									<div class="alert alert-danger" role="alert">
										<span class="glyphicon glyphicon-warning-sign"
											aria-hidden="true"></span> &nbsp;&nbsp;Si prega di fare
										particolare attenzione ai seguenti avvisi:
										<c:choose>
											<c:when test="${not empty notizie}">
												<div style="margin-left: 35px;">
													<ul style="list-style: disc;">
														<c:forEach var="notizia" items="${notizie}">
															<li>
																<ul>${notizia.descrizione}</ul>
															</li>
														</c:forEach>
													</ul>
												</div>
											</c:when>
											<c:otherwise>
											<div style="margin-left: 35px;">
													Nessun avviso presente
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
<script type="text/x-handlebars-template" id="templateModalParametri">
{{#if errore}}
<div id="erroreModal" class="alert alert-danger">
<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
È avvenuto un errore durante il processo.
<br/>Ti preghiamo di riprovare più tardi.</div>
{{else if redirect}}
<div id="erroreModal" class="alert alert-danger">
<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;<strong>Attenzione!</strong> 
Non &egrave; possibile settare in sessione la graduatoria selezionata, in quanto non esistente.
</div>
<br>La finestra per impostare anno e graduatoria si aprir&agrave; nuovamente tra 5 secondi.
{{else}}
<div class="row">
<form id="form_parametri" role="form" name="form_parametri">
	<!-- TIPO GRADUATORIA -->
	<div class="form-group col-md-12">
		<label for="tipoGrad" class="control-label">Tipo graduatoria (*)</label>
		<select class="form-control selectpicker show-tick" id="tipoGrad" 
		name="tipoGrad" required value="${sessionScope.tipoGraduatoria}">
		<c:choose>
		<c:when test="${sessionScope.tipoGraduatoria!='PD'}">
			<option selected="selected">MG</option>
			<option>PD</option>
		</c:when>
		<c:otherwise>
		<option >MG</option>
		<option selected="selected">PD</option>
		</c:otherwise>
		</c:choose>
		</select>
	</div>
	<!-- ANNO -->
	<div class="form-group col-md-12">
		<label for="annoParam" class="control-label"> Anno (*)</label>
		<div class="input-group date datepicker_anno">
			<c:choose>
				<c:when test="${not empty sessionScope.anno}">
					<input id="annoParam" name="anno" class="form-control" required readonly="readonly"	type="text" value="${sessionScope.anno}" />
				</c:when>
				<c:otherwise>
					<input id="annoParam" name="anno" class="form-control" required readonly="readonly"	type="text" value="" />
				</c:otherwise>
			</c:choose>
			<span class="input-group-addon"> 
				<span class="glyphicon glyphicon-calendar"></span>
			</span>
		</div>
	</div>
	<div class="error-block red align_center" style="display:none;margin:1%;" id="error">
	<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>&nbsp;
	I campi contrassegnati dall'asterisco sono obbligatori
	</div>
</form>
</div>
{{/if}}
<script>
/* per visualizzare solo anno*/
$(function () {
 $('.selectpicker').selectpicker();
	var nextYear = new moment().add('years', 1).format('L'); 
    $(".datepicker_anno").datetimepicker({
        format: "YYYY",
        showClose: true,
        locale: 'it',
        showClear:true,
        ignoreReadonly:true,
		defaultDate: nextYear,
		useCurrent: false
    });
});
<{{!}}/script>
</script>
<script type="text/javascript" charset="UTF8">
var templateModalParametri = Handlebars.compile($("#templateModalParametri").html());
$(document).ready(function() {
   if(${sessionScope.stato==null})
	   BootstrapDialog.show({
			title : 'Imposta anno e graduatoria',
			message : function(dialog) {
				var $modalBody = templateModalParametri();
				return $modalBody;
			},
			onshown : function(diaologRef){
				 $('form[name="form_parametri"] input, select, .datepicker_anno').on('keyup change dp.change',function(){
					 if($('#annoParam').val()=="")
					    {
					    	$('#error').css('display','block');
					    	diaologRef.getButton('conferma').disable();
					    }
					    else
					    {
					    	$('#error').css('display','none');	
					    	diaologRef.getButton('conferma').enable();
					    }
					}); 
			},
			size : BootstrapDialog.SIZE_NORMAL,
			type : BootstrapDialog.TYPE_PRIMARY,
			closable : false,
			draggable : false,
			nl2br : false,
			buttons : [ {
				id : 'conferma',
				icon : 'fa fa-cog',
				label : 'Imposta',
				cssClass : 'btn-primary',
				autospin : true,
				action : function(dialogRef) {
					dialogRef.enableButtons(false);
					dialogRef.setClosable(false);
					var parametri = new Object();
					parametri.tipo = $('#tipoGrad').val();
					parametri.anno = $('#annoParam').val();
					impostaParametri(dialogRef, parametri);
				}
			}]
		});
});
function impostaParametri(dialogRef, parametri) {
	var url = Constants.contextPath + "domande/parametri";
	$.ajax({
				url : url,
				type : 'POST',
				data : {
					anno : parametri.anno,
					tipo : parametri.tipo,
				},
				success : function(data,status,response) {
					if(response.status === 201)
					{
						dialogRef.getModalFooter().hide();
						var dati = new Object();
						dati.redirect = true;
						var htmlDialog = templateModalParametri(dati);
						dialogRef.getModalBody().html(htmlDialog);	
						setTimeout(function () {
							   dialogRef.close();
							   BootstrapDialog.show({
									title : 'Imposta anno e graduatoria',
									message : function(dialog) {
										var $modalBody = templateModalParametri();
										return $modalBody;
									},
									onshown : function(diaologRef){
										 $('form[name="form_parametri"] input, select, .datepicker_anno').on('keyup change dp.change',function(){
											 if($('#annoParam').val()=="")
											    {
											    	$('#error').css('display','block');
											    	diaologRef.getButton('conferma').disable();
											    }
											    else
											    {
											    	$('#error').css('display','none');	
											    	diaologRef.getButton('conferma').enable();
											    }
											}); 
									},
									size : BootstrapDialog.SIZE_NORMAL,
									type : BootstrapDialog.TYPE_PRIMARY,
									closable : false,
									draggable : false,
									nl2br : false,
									buttons : [ {
										id : 'conferma',
										icon : 'fa fa-cog',
										label : 'Imposta',
										cssClass : 'btn-primary',
										autospin : true,
										action : function(dialogRef) {
											dialogRef.enableButtons(false);
											dialogRef.setClosable(false);
											var parametri = new Object();
											parametri.tipo = $('#tipoGrad').val();
											parametri.anno = $('#annoParam').val();
											impostaParametri(dialogRef, parametri);
										}
									}]
								}); 
						    }, 5000); 
					}
					else
					{
					   dialogRef.close();						
					}
				},
				error : function(data) {
					mostraErroreModal(dialogRef);
				}
			});
}
function mostraErroreModal(dialogRef) {
	dialogRef.setClosable(true);
	dialogRef.getModalFooter().hide();
	var dati = new Object();
	dati.errore = true;
	var htmlDialog = templateModalParametri(dati);
	dialogRef.getModalBody().html(htmlDialog);
}
</script>