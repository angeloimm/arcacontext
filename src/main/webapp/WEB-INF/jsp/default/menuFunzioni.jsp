<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
   <!-- Menu ================================================== -->
   <div class="navbar navbar-default" role="navigation" style="z-index: 1000; position: relative; top: 0px;">
      <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Menu</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
            </button>
         </div> 
         <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav sm" >
               <li id="menuHome" class="menu_home">
                  <a href="<spring:url value="/home"/>">Home</a>
               </li>
               <li id="menuTabelle" class="menu_questionario">
                  <a href="#" class="has-submenu">GESTIONE TABELLARE<span class="sub-arrow">...</span></a>
                  <ul class="dropdown-menu">
                     <li id="menuTabelleTitoli"><a href="<spring:url value="/tabella/titoli"/>">TITOLI</a></li>
                     <li id="menuTabelleTitolarita"><a href="<spring:url value="/tabella/titolarita"/>">TITOLARITA'</a></li>
                     <li id="menuTabelleTipiGraduatorie"><a href="<spring:url value="/tabella/tipiGraduatoria"/>">TIPI GRADUATORIE</a></li>
                     <li id="menuTabelleStatoGraduatorie"><a href="<spring:url value="/tabella/statoGraduatorie"/>">STATO GRADUATORIE</a></li>
                     <li id="menuTabelleFestivita"><a href="<spring:url value="/tabella/festivita"/>">FESTIVITÀ INFRASETTIMANALI</a></li>
                     <li id="menuTabelleStampe" class="dropdown-submenu">
                     	<a href="#">STAMPE <span class="caret"></span></a>
                     	<ul class="dropdown-menu">
                     		<li id="menuTabelleStampeTitoli"><a href="javascript:openModalStampaTitoli();">TABELLA TITOLI</a></li>
                     		<li id="menuTabelleStampeTitolarita"><a href="javascript:openModalStampaTitolarita();">TABELLA TITOLARITÀ</a></li>		
                     	</ul>
                     </li>
                  </ul>
               </li>
               <li id="menuParametriAnno" class="menu_statistiche"><a href="#">PARAMENTRI ANNO<span class="sub-arrow">...</span></a>
                <ul class="dropdown-menu">
                     <li id="menuParametriAnnoTitoli"><a href="<spring:url value="/parametri/titoliGraduatoria"/>">TITOLI GRADUATORIA</a></li>
                     <li id="menuParametriAnnoTitolarita"><a href="<spring:url value="/parametri/titolaritaGraduatoria"/>">TITOLARITÀ GRADUATORIA</a></li>
                     <li id="menuParametriAnnoSpecializzazioni"><a href="<spring:url value="/parametri/specializzazioni"/>">SPECIALIZZAZIONI</a></li>
                     <li id="menuParametriAnnoDuplicazione"><a href="<spring:url value="/parametri/duplica"/>">DUPLICAZIONE PARAMETRI</a></li>
                     <li id="menuParametriAnnoStampe" class="dropdown-submenu">
                     	<a href="#">STAMPE <span class="caret"></span></a>
                     	<ul class="dropdown-menu">
                     		<li id="menuParametriAnnoStampeTitoli"><a href="javascript:openModalStampaRtbtit()">TITOLI GRADUATORIA</a></li>
                     		<li id="menuParametriAnnoStampeTitolarita"><a href="javascript:openModalStampaRstat02()">TITOLARITÀ GRADUATORIA</a></li>
                     		<li id="menuParametriAnnoStampeSpecializzazioni"><a href="javascript:openModalStampaSpec()">TABELLA SPECIALIZZAZIONI</a></li>			
                     	</ul>
                     </li>
                  </ul>
               </li>                              
               <li id="menuGestioneGraduatorie" class="menu_schede">
                  <a href="#" class="has-submenu">GESTIONE GRADUATORIE<span class="sub-arrow">...</span></a>
                  <ul class="dropdown-menu">
                   <li id="menuGestioneGraduatorieRicerca"><a href="<spring:url value="/domande" />">RICERCA/INSERIMENTO DOMANDE</a></li>
                   <li id="menuGestioneGraduatorieCalcoloPunteggio"><a href="<spring:url value="/calcPunt/punteggi" />">CALCOLO PUNTEGGIO</a></li>
                   <li id="menuGestioneGraduatorieStampe">
                   		<a href="#">STAMPE <span class="caret"></span></a>
                   		<ul class="dropdown-menu">
                     		<li id="menuGestioneGraduatorieStampeAnalitica"><a href="<spring:url value="javascript:openModalAnalitica();" />" class="test">ANALITICA</a></li>
                     		<li id="menuGestioneGraduatorieStampeIrregolarita"><a href="javascript:openModalReportIrregolarita();">IRREGOLARITÀ</a></li>
                     		<li id="menuGestioneGraduatorieStampeEtichette"><a href="javascript:openModalStampaEtichette();">ETICHETTE</a></li>
                     		<li id="menuGestioneGraduatorieStampeMgtitolo04"><a href="javascript:openModalTitolo4();">MG TITOLO 04</a></li>
                     		<li id="menuGestioneGraduatorieStampeGraduatorie">
                     			<a href="#">GRADUATORIE <span class="caret"></span></a>
                  				<ul class="dropdown-menu">
                  					<li id="menuGestioneGraduatorieStampeGraduatorieAlfabetica"><a href="javascript:openModalRepPunteggi();">ORDINE ALFABETICO</a></li>
                  					<li id="menuGestioneGraduatorieStampeGraduatoriePunteggio"><a href="javascript:openModalPunteggiLaurea();">PUNTEGGIO</a></li>
                  					<li id="menuGestioneGraduatorieStampeGraduatoriePubblicaPunteggio"><a href="javascript:openModalPunteggiPubblico();">GRADUATORIA PUBBLICA PUNTEGGIO</a></li>
                  					<li id="menuGestioneGraduatorieStampeGraduatoriePubblicaAlfabeitco"><a href="javascript:openModalAlfabeticaPubblica();">GRADUATORIA PUBBLICA ALFABETICO</a></li>
                  				</ul>
                     		</li>
                     	</ul>
                   </li>
                  </ul>
               </li>
            </ul>
            <ul class="nav navbar-nav pull-right sm" data-smartmenus-id="15067017494000352">
               <li><a href="<spring:url value="/documenti"/>">DOCUMENTI</a></li>
               <li><a href="<spring:url value="/logout"/>">Esci</a></li>
            </ul>
         </div>
      </div>
   </div>
	<script type="text/x-handlebars-template" id="templateReport">
	<div class="row">
<form name="templateReport">
	<!-- TIPO GRADUATORIA -->
	<div class="form-group col-md-6">
		<label for="tipoReport" class="control-label">Tipo graduatoria (*)</label>
		<select class="form-control selectpicker show-tick" id="tipoReport" 
		name="tipoReport" required value="${sessionScope.tipoGraduatoria}">
			<option selected="selected">MG</option>
			<option>PD</option>
		</select>
	</div>
	<!-- ANNO -->
	<div class="form-group col-md-6">
		<label for="annoReport" class="control-label"> Anno (*)</label>
		<div class="input-group date datepicker_anno">
			<input id="annoReport" name="anno" class="form-control" required readonly="readonly"
				type="text" value="${sessionScope.anno}" /> <span class="input-group-addon"> <span
				class="glyphicon glyphicon-calendar"></span>
			</span>
		</div>
	</div>
	{{#if tit}}
	<!-- CODICE TITOLARITA-->
	<div class="form-group col-md-6">
		<label for="codiceTitolarita" class="control-label"> Codice Titolarit&agrave; (*)</label>
			<input id="codiceTitolarita" name="codiceTitolarita" class="form-control" type="text" data-error="Inserire valori numerici"/> 
 				<div class="help-block with-errors"></div>		
	</div>
	{{/if}}
    <div class="cc-selector-2 col-md-6 margin20">
	<center>
       	<input id="pdf" type="radio" checked name="creditcard" value="PDF" />
		<i class="fa fa-file-pdf-o red size40 drinkcard-cc" aria-hidden="true" id="pdf" style="margin-right:10px;"></i>
 		<input id="excel" type="radio" name="creditcard" value="XLS" />
     	<i class="fa fa-file-excel-o green size40 drinkcard-cc" aria-hidden="true" id="excel"></i>
	</center>
</div>
</form>
</div>
<script>
$(function () {
 $('.selectpicker').selectpicker();
	var nextYear = new moment().add('years', 1).format('L'); 
    $(".datepicker_anno").datetimepicker({
        format: "YYYY",
        showClose: true,
        locale: 'it',
        showClear:true,
        ignoreReadonly:true,
		maxDate : nextYear,
		defaultDate: nextYear
    });
});
<{{!}}/script>
</script>
<script>
var templateModalReport = Handlebars.compile($("#templateReport").html());
function openModalGenerico(url, nomeFile){
	BootstrapDialog.show({
		title : 'Parametri Report',
		message : function(dialog) {
			var $modalBody = templateModalReport();
			return $modalBody;
		},
		size : BootstrapDialog.NORMAL,
		type : BootstrapDialog.TYPE_PRIMARY,
		closable : true,
		draggable : false,
		nl2br : false,
	 	onshown: function(dialogRef){
			  $('form[name="templateReport"] input, select, .datepicker_anno').on('keyup change dp.change',function(){
			    if($('#annoReport').val()===""){
			    	dialogRef.getButton('conferma').disable();
			    }else{
			    	dialogRef.getButton('conferma').enable();
			    }
			});  
	        },  
		buttons : [
				{
					id : 'conferma',
					icon : 'fa fa-check',
					label : 'Conferma',
					cssClass : 'btn-primary',
					autospin : true,
					action : function(dialogRef) {
						dialogRef.enableButtons(false);
						dialogRef.setClosable(false);
						var obj = new Object();
						obj.anno = $('#annoReport').val();
						obj.tipo = $('#tipoReport').val();
						if($('#pdf').prop('checked'))
							obj.formato = $('#pdf').val();
						else
							obj.formato = $('#excel').val();
						url = url + "/"+obj.formato+"/"+obj.anno+"/"+obj.tipo;
						xhr("GET",url,dialogRef,nomeFile);
					}
				}, {
					id : 'annullaConferma',
					icon : 'fa fa-times',
					label : 'Annulla',
					action : function(dialogRef) {
						dialogRef.close();
					}
				} ]
	});
}
function openModalReportIrregolarita(){
	var url = Constants.contextPath + "report/domaIrr";
	var nomeFile ="Irregolarità";
	openModalGenerico(url, nomeFile);
}
function openModalAnalitica(){
	var url = Constants.contextPath + "report/analitica";
	var nomeFile = "Stampa_analitica";
	openModalGenerico(url, nomeFile);
}
function openModalRepPunteggi(){
	var url = Constants.contextPath + "report/gradPunteggiDettaglio";
	var nomeFile = "Graduatoria_Punteggi";
	openModalGenerico(url, nomeFile);
}
function openModalPunteggiLaurea(){
	var url = Constants.contextPath + "report/gradPunteggi";
	var nomeFile = "Graduatoria_Dati_Laurea";
	openModalGenerico(url, nomeFile);
}
function openModalStampaTitoli(){
	var url = Constants.contextPath + "/report/stampaTitoli";
	var nomeFile = "Stampa_titoli";
	openModalGenerico(url, nomeFile);
}
function openModalStampaTitolarita(){
	var url = Constants.contextPath + "report/stampaTitolarita";
	var nomeFile = "Stampa_titolarita";
	openModalGenerico(url, nomeFile);
}
function openModalStampaEtichette(){
	var url = Constants.contextPath + "report/stampaEtichette";
	var nomeFile = "Stampa_etichette";
	openModalGenerico(url, nomeFile);
}
function openModalPunteggiPubblico(){
	var url = Constants.contextPath + "report/gradPunteggiPubblica";
	var nomeFile = "Graduatoria_punteggi_pubblica";
	openModalGenerico(url, nomeFile);
}
function openModalAlfabeticaPubblica(){
	var url = Constants.contextPath + "report/gradPunteggiDettaglioPubblico";
	var nomeFile = "Graduatoria_alfabetica_pubblica";
	openModalGenerico(url, nomeFile);
}
function openModalStampaSpec(){
	var url = Constants.contextPath + "report/stampaRtbspec";
	var nomeFile = "Stampa_specializzazioni";
	openModalGenerico(url, nomeFile);
}
function openModalTitolo4(){
	var url = Constants.contextPath + "report/titolo4";
	var nomeFile = "Titolo_4"
	openModalGenerico(url, nomeFile);
}
function openModalStampaRtbtit(){
	var url = Constants.contextPath + "report/stampaRtbtit";
	var nomeFile = "Stampa_rtbtit";
	openModalGenerico(url, nomeFile);
}
function openModalStampaRstat02(){
	BootstrapDialog.show({
		title : 'Parametri Report',
		message : function(dialog) {
			var dati = new Object();
			dati.tit=true;
			var $modalBody = templateModalReport(dati);
			return $modalBody;
		},
		onshow: function(dialog) 
		{
				dialog.getButton('conferma').disable();
		},
		onshown: function(dialogRef)
		{
			 $('form[name="templateReport"] input').on('keyup change dp.change',function(){
				 validaFormCodiceTitolo(dialogRef)
			 }); 
        },   
		size : BootstrapDialog.NORMAL,
		type : BootstrapDialog.TYPE_PRIMARY,
		closable : true,
		draggable : false,
		nl2br : false,
		buttons : [
				{
					id : 'conferma',
					icon : 'fa fa-check',
					label : 'Conferma',
					cssClass : 'btn-primary',
					autospin : true,
					action : function(dialogRef) 
					{
						dialogRef.enableButtons(false);
						dialogRef.setClosable(false);
						var obj = new Object();
						obj.anno = $('#annoReport').val();
						obj.tipo = $('#tipoReport').val();
						obj.codiceTitolarita = $('#codiceTitolarita').val();
						if($('#pdf').prop('checked'))
							obj.formato = $('#pdf').val();
						else
							obj.formato = $('#excel').val();
							xhr("GET", '<spring:url value="/report/stampaRstat02/'+obj.formato+'/'+obj.anno+'/'+obj.tipo+'/'+obj.codiceTitolarita+'" />', dialogRef,"Stampa_Rstat02"); 

					}
				}, {
					id : 'annullaConferma',
					icon : 'fa fa-times',
					label : 'Annulla',
					action : function(dialogRef) {
						dialogRef.close();
					}
				} ]
	});
}
function validaFormCodiceTitolo(dialogRef)
{
 	var cod_tit = $('#codiceTitolarita').val();
 	dialogRef.getButton('conferma').disable();
 	if((cod_tit != "") && (validation.isNumber(cod_tit)))
 	{
 		dialogRef.getButton('conferma').enable();
 	}
  	else
  	{
  		dialogRef.getButton('conferma').disable();
 	}	
 }
</script>