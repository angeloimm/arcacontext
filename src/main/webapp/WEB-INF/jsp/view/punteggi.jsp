<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<form role="form" id="form_punteggi">
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
				<div class="form-group col-md-2">
						<label for="progCalcolo" class="control-label">Progr.</label> <input
							type="number" min="0" class="form-control height40" id="progCalcolo">
					</div>
					<div class="form-group col-md-2">
						<label for="tipo" class="control-label">Anno</label> <input
							type="text" class="form-control height40" id="annoCalcolo" readonly>
					</div>
					<div class="form-group col-md-2">
						<label for="stato" class="control-label">Tipo grad.</label> <input
							type="text" class="form-control height40" id="tipoCalcolo" readonly>
					</div>
					<c:set var="today" value="<%=new Date()%>"/>
					<div class="form-group col-md-2">
					
						<label for="utente" class="control-label">Data</label> <input
							type="text" class="form-control height40" id="utente" readonly
							value="<fmt:formatDate type="date" value="${today}" pattern="dd/MM/yyyy"/>">
					</div>
					<div class="form-group col-md-4">
					<button type="submit" id="analiticaPunteggi" class="btn btn-default btn-large button_salva margin40"
					style="float:right;">Analitica</button>
					</div>
					<!-- TABELLA PUNTEGGI -->
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<ul class="nav nav-tabs punteggi" style="margin-top: 20px;">
								<li id="li1"><a data-toggle="tab" href="#step1">Titoli
										valutati</a></li>
								<li id="li2"><a data-toggle="tab" href="#step2">Titoli non
										valutabili</a></li>
								<li id="li3"><a data-toggle="tab" href="#step3">Tit. valut. spec. 98</a></li>
								<li id="li4"><a data-toggle="tab" href="#step4">Tit. valut. spec. 99</a></li>
								<li id="li5"><a data-toggle="tab" href="#step5">Tit. valut. spec. 97</a></li>
								<li id="li6"><a data-toggle="tab" href="#step6">Tit. valut. spec. 96</a></li>
								<li id="li7"><a data-toggle="tab" href="#step7">Punteggio
										ottenuto</a></li>
							</ul>
							<div class="tab-content">
								<div id="step1" class="tab-pane fade">
									<jsp:include page="titoliValutati.jsp" />
								</div>
								<div id="step2" class="tab-pane fade">
									<jsp:include page="titoliNonValutati.jsp" />
								</div>
								<div id="step3" class="tab-pane fade">
									<jsp:include page="titoliSpec98.jsp" />
								</div>
								<div id="step4" class="tab-pane fade">
									<jsp:include page="titoliSpec99.jsp" />
								</div>
								<div id="step5" class="tab-pane fade">
									<jsp:include page="titoliSpec97.jsp" />
								</div>
								<div id="step6" class="tab-pane fade">
									<jsp:include page="titoliSpec96.jsp" />
								</div>
								<div id="step7" class="tab-pane fade">
									<jsp:include page="punteggioOttenuto.jsp" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript" charset="UTF-8">
var progressivoCalcolo = 0;
var maxProgressivo = 0;
$(document).ready(function(){
	 activaTab('step1');
});
$("#progCalcolo").bind('click',function(evt){
	 if($(this).val() !==""){
	 progressivoCalcolo = $(this).val();
	 	if($('#li1').hasClass("active"))
	 		titoliValutatiDatatable();
	 	else if($('#li2').hasClass("active"))
		 	titoliEliminatiDatatable();
	 	else if($('#li3').hasClass("active"))
	 		titoli98Datatable();
	 	else if($('#li4').hasClass("active"))
	 		titoli99Datatable();
	 	else if($('#li5').hasClass("active"))
	 		titoli97Datatable();
	 	else if($('#li6').hasClass("active"))
	 		titoli96Datatable();
	 	else
	 		titoliPunteggiDatatable();
	 }
});
$("#progCalcolo").bind('focusout',function(evt){
	 progressivoCalcolo = maxProgressivo;
	 $('#progCalcolo').val(progressivoCalcolo);
	 titoliValutatiDatatable();
});
 function activaTab(tab){
    $('.nav-tabs a[href="#' + tab + '"]').tab('show');
}; 
$('.nav-tabs a[href="#menu5"]').on('click',function(evt) {
	$('#codiceFunzione').val('F-VISPTI');
	var url = Constants.contextPath + 'punteggi/getProgressivoCalcolo/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'.json';
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
			$('#progCalcolo').val(data.payload);
			progressivoCalcolo = data.payload;
			maxProgressivo = data.payload;
			titoliValutatiDatatable();
		},
		error : function(data) {
		}
	});	
	
});
$("#li1").on("click", function() {
	titoliValutatiDatatable();
});
function titoliValutatiDatatable(){
	tTitoliValutati = $('#titValutati').DataTable(
		{
			"info": false,
			"bSort": false,
			"destroy" : true,
			"processing" : true,
			"serverSide" : true,
			"mark" : true,
			"responsive" : true,
			"pageLength" : '${numeroMassimoRecord}',
			"language" : {"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'},
			"ajax" : {
				"url" : '<spring:url value="/punteggi/elencoTitValutati/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'/'+progressivoCalcolo+'.json" />',
				"dataSrc" : "payload"
			},
			"deferRender" : true,
			"columnDefs" : [
					{
					"render" : function(data, type, row) {
						if (!isNaN(row.codiceTitolo)) {
							return row.codiceTitolo;
						}
						return "";
					},
					"name" : "",
					"orderable" : false,
					"targets" : 0
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoDal)) {
								return row.giornoDal;
							}
							return "";
						},
						"name" : "tiokPeriodoGgDal",
						"targets" : 1,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoAl)) {
								return row.giornoAl;
							}
							return "";
						},
						"name" : "tiokPeriodoGgAl",
						"targets" : 2,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag1 && row.flag1 !== "") {
								return row.flag1;
							}
							return "";
						},
						"name" : "tiokFlag1",
						"targets" : 3,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag2 && row.flag2 !== "") {
								return row.flag2;
							}
							return "";
						},
						"name" : "tiokFlag2",
						"targets" : 4,
					},
					{
						"render" : function(data, type, row) {
							if (row.spec && row.spec !="") {
								return row.spec;
							}
							return "";
						},
						"name" : "tiokCodspec",
						"targets" : 5,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "tiokNumero",
						"targets" : 6,
					},
					{
						"render" : function(data, type, row) {
							if (row.ulssReg && row.ulssReg !="") {
								return row.ulssReg;
							}
							return "";
						},
						"name" : "tiokCodulssReg",
						"targets" : 7,
					},
					{
						"render" : function(data, type, row) {
							if (row.ulssAz && row.ulssAz !="") {
								return row.ulssAz;
							}
							return "";
						},
						"name" : "tiokCodulssAzi",
						"targets" : 8,
					},
					{
						"render" : function(data, type, row) {
							if (row.annoTitolo && row.annoTitolo !== 0) {
								return row.annoTitolo;
							}
							return "";
						},
						"name" : "id.tiokAnno",
						"targets" : 9,
					},
					{
						"render" : function(data, type, row) {
							if (row.mese && row.mese !== 0) {
								return row.mese
							}
							return "";
						},
						"name" : "tiokPeriodoMm",
						"targets" : 10,
					},
					{
						"render" : function(data, type, row) {
							if (row.dal && row.dal !== "") {
								return moment(row.dal).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "tiokPeriodoDal",
						"targets" : 11,
					},
					{
						"render" : function(data, type, row) {
							if (row.al && row.al !== "") {
								return moment(row.al).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "tiokPeriodoAl",
						"targets" : 12,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.ore)) {
								return row.ore;
							}
							return "";
						},
						"name" : "tiokPeriodoOre",
						"targets" : 13,
					}]	
		});	
}
$("#li2").on("click", function() {
	titoliEliminatiDatatable();
});
	function titoliEliminatiDatatable(){
	tTitoliEliminati = $('#titEliminati').DataTable(
		{
			"info": false,
			"bSort": false,
			"destroy" : true,
			"processing" : true,
			"serverSide" : true,
			"mark" : true,
			"responsive" : true,
			"pageLength" : '${numeroMassimoRecord}',
			"language" : {"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'},
			"ajax" : {
				"url" : '<spring:url value="/punteggi/elencoTitElim/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'/'+progressivoCalcolo+'.json" />',
				"dataSrc" : "payload"
			},
			"deferRender" : true,
			"columnDefs" : [
					{
					"render" : function(data, type, row) {
						if (!isNaN(row.codiceTitolo)) {
							return row.codiceTitolo;
						}
						return "";
					},
					"name" : "",
					"orderable" : false,
					"targets" : 0
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoDal)) {
								return row.giornoDal;
							}
							return "";
						},
						"name" : "elimPeriodoGgDal",
						"targets" : 1,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoAl)) {
								return row.giornoAl;
							}
							return "";
						},
						"name" : "elimPeriodoGgAl",
						"targets" : 2,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag1 && row.flag1 !== "") {
								return row.flag1;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 3,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag2 && row.flag2 !== "") {
								return row.flag2;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 4,
					},
					{
						"render" : function(data, type, row) {
							if (row.spec && row.spec !="") {
								return row.spec;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 5,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 6,
					},
					{
						"render" : function(data, type, row) {
							if (row.ulssReg && row.ulssReg !="") {
								return row.ulssReg;
							}
							return "";
						},
						"name" : "elimCodulssReg",
						"targets" : 7,
					},
					{
						"render" : function(data, type, row) {
							if (row.ulssAz && row.ulssAz !="") {
								return row.ulssAz;
							}
							return "";
						},
						"name" : "elimCodulssAzi",
						"targets" : 8,
					},
					{
						"render" : function(data, type, row) {
							if (row.annoTitolo && row.annoTitolo !== 0) {
								return row.annoTitolo;
							}
							return "";
						},
						"name" : "elimPeriodoDal",
						"targets" : 9,
					},
					{
						"render" : function(data, type, row) {
							if (row.mese && row.mese !== 0) {
								return row.mese
							}
							return "";
						},
						"name" : "elimPeriodoDal",
						"targets" : 10,
					},
					{
						"render" : function(data, type, row) {
							if (row.dal && row.dal !== "") {
								return moment(row.dal).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "elimPeriodoDal",
						"targets" : 11,
					},
					{
						"render" : function(data, type, row) {
							if (row.al && row.al !== "") {
								return moment(row.al).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "elimPeriodoAl",
						"targets" : 12,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.ore)) {
								return row.ore;
							}
							return "";
						},
						"name" : "elimPeriodoOre",
						"targets" : 13,
					}]	
		});
}
$("#li3").on("click", function() {
	titoli98Datatable();
});

	function titoli98Datatable(){
	tTitoli98 = $('#titSpec98').DataTable(
		{
			"info": false,
			"bSort": false,
			"destroy" : true,
			"processing" : true,
			"serverSide" : true,
			"mark" : true,
			"responsive" : true,
			"pageLength" : '${numeroMassimoRecord}',
			"language" : {"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'},
			"ajax" : {
				"url" : '<spring:url value="/punteggi/elencoTit98/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'/'+progressivoCalcolo+'.json" />',
				"dataSrc" : "payload"
			},
			"deferRender" : true,
			"columnDefs" : [
					{
					"render" : function(data, type, row) {
						if (!isNaN(row.codiceTitolo)) {
							return row.codiceTitolo;
						}
						return "";
					},
					"name" : "",
					"orderable" : false,
					"targets" : 0
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoDal)) {
								return row.giornoDal;
							}
							return "";
						},
						"name" : "elimPeriodoGgDal",
						"targets" : 1,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoAl)) {
								return row.giornoAl;
							}
							return "";
						},
						"name" : "elimPeriodoGgAl",
						"targets" : 2,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag1 && row.flag1 !== "") {
								return row.flag1;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 3,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag2 && row.flag2 !== "") {
								return row.flag2;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 4,
					},
					{
						"render" : function(data, type, row) {
							if (row.spec && row.spec !="") {
								return row.spec;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 5,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 6,
					},
					{
						"render" : function(data, type, row) {
							if (row.ulssReg && row.ulssReg !="") {
								return row.ulssReg;
							}
							return "";
						},
						"name" : "cco1CodulssReg",
						"targets" : 7,
					},
					{
						"render" : function(data, type, row) {
							if (row.ulssAz && row.ulssAz !="") {
								return row.ulssAz;
							}
							return "";
						},
						"name" : "cco1CodulssAzi",
						"targets" : 8,
					},
					{
						"render" : function(data, type, row) {
							if (row.annoTitolo && row.annoTitolo !== 0) {
								return row.annoTitolo;
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 9,
					},
					{
						"render" : function(data, type, row) {
							if (row.mese && row.mese !== 0) {
								return row.mese
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 10,
					},
					{
						"render" : function(data, type, row) {
							if (row.dal && row.dal !== "") {
								return moment(row.dal).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 11,
					},
					{
						"render" : function(data, type, row) {
							if (row.al && row.al !== "") {
								return moment(row.al).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "titlPeriodoAl",
						"targets" : 12,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.ore)) {
								return row.ore;
							}
							return "";
						},
						"name" : "cco1PeriodoOre",
						"targets" : 13,
					}]	
		});
	}
$("#li4").on("click", function() {
	titoli99Datatable();
});
	function titoli99Datatable(){
	tTitoli99 = $('#titSpec99').DataTable(
		{
			"info": false,
			"bSort": false,
			"destroy" : true,
			"processing" : true,
			"serverSide" : true,
			"mark" : true,
			"responsive" : true,
			"pageLength" : '${numeroMassimoRecord}',
			"language" : {"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'},
			"ajax" : {
				"url" : '<spring:url value="/punteggi/elencoTit99/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'/'+progressivoCalcolo+'.json" />',
				"dataSrc" : "payload"
			},
			"deferRender" : true,
			"columnDefs" : [
					{
					"render" : function(data, type, row) {
						if (!isNaN(row.codiceTitolo)) {
							return row.codiceTitolo;
						}
						return "";
					},
					"name" : "",
					"orderable" : false,
					"targets" : 0
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoDal)) {
								return row.giornoDal;
							}
							return "";
						},
						"name" : "elimPeriodoGgDal",
						"targets" : 1,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoAl)) {
								return row.giornoAl;
							}
							return "";
						},
						"name" : "elimPeriodoGgAl",
						"targets" : 2,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag1 && row.flag1 !== "") {
								return row.flag1;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 3,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag2 && row.flag2 !== "") {
								return row.flag2;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 4,
					},
					{
						"render" : function(data, type, row) {
							if (row.spec && row.spec !="") {
								return row.spec;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 5,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 6,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 7,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 8,
					},
					{
						"render" : function(data, type, row) {
							if (row.annoTitolo && row.annoTitolo !== 0) {
								return row.annoTitolo;
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 9,
					},
					{
						"render" : function(data, type, row) {
							if (row.mese && row.mese !== 0) {
								return row.mese
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 10,
					},
					{
						"render" : function(data, type, row) {
							if (row.dal && row.dal !== "") {
								return moment(row.dal).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 11,
					},
					{
						"render" : function(data, type, row) {
							if (row.al && row.al !== "") {
								return moment(row.al).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "titlPeriodoAl",
						"targets" : 12,
					},
					{
						"render" : function(data, type, row) {
							if (row.ore && row.ore !==0) {
								return row.ore;
							}
							return "";
						},
						"name" : "titlPeriodoOre",
						"targets" : 13,
					}]	
		});	
	}
$("#li5").on("click", function() {
	titoli97Datatable();
});
	function titoli97Datatable(){
	tTitoli97 = $('#titSpec97').DataTable(
		{
			"info": false,
			"bSort": false,
			"destroy" : true,
			"processing" : true,
			"serverSide" : true,
			"mark" : true,
			"responsive" : true,
			"pageLength" : '${numeroMassimoRecord}',
			"language" : {"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'},
			"ajax" : {
				"url" : '<spring:url value="/punteggi/elencoTit97/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'/'+progressivoCalcolo+'.json" />',
				"dataSrc" : "payload"
			},
			"deferRender" : true,
			"columnDefs" : [
					{
					"render" : function(data, type, row) {
						if (!isNaN(row.codiceTitolo)) {
							return row.codiceTitolo;
						}
						return "";
					},
					"name" : "",
					"orderable" : false,
					"targets" : 0
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoDal)) {
								return row.giornoDal;
							}
							return "";
						},
						"name" : "elimPeriodoGgDal",
						"targets" : 1,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoAl)) {
								return row.giornoAl;
							}
							return "";
						},
						"name" : "elimPeriodoGgAl",
						"targets" : 2,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag1 && row.flag1 !== "") {
								return row.flag1;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 3,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag2 && row.flag2 !== "") {
								return row.flag2;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 4,
					},
					{
						"render" : function(data, type, row) {
							if (row.spec && row.spec !="") {
								return row.spec;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 5,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 6,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 7,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 8,
					},
					{
						"render" : function(data, type, row) {
							if (row.annoTitolo && row.annoTitolo !== 0) {
								return row.annoTitolo;
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 9,
					},
					{
						"render" : function(data, type, row) {
							if (row.mese && row.mese !== 0) {
								return row.mese
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 10,
					},
					{
						"render" : function(data, type, row) {
							if (row.dal && row.dal !== "") {
								return moment(row.dal).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 11,
					},
					{
						"render" : function(data, type, row) {
							if (row.al && row.al !== "") {
								return moment(row.al).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "titlPeriodoAl",
						"targets" : 12,
					},
					{
						"render" : function(data, type, row) {
							if (row.ore && row.ore !==0) {
								return row.ore;
							}
							return "";
						},
						"name" : "titlPeriodoOre",
						"targets" : 13,
					}]	
		});	
	}
$("#li6").on("click", function() {
	titoli96Datatable();
});
	function titoli96Datatable(){
		tTitoli96 = $('#titSpec96').DataTable(
		{
			"info": false,
			"bSort": false,
			"destroy" : true,
			"processing" : true,
			"serverSide" : true,
			"mark" : true,
			"responsive" : true,
			"pageLength" : '${numeroMassimoRecord}',
			"language" : {"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'},
			"ajax" : {
				"url" : '<spring:url value="/punteggi/elencoTit96/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'/'+progressivoCalcolo+'.json" />',
				"dataSrc" : "payload"
			},
			"deferRender" : true,
			"columnDefs" : [
					{
					"render" : function(data, type, row) {
						if (!isNaN(row.codiceTitolo)) {
							return row.codiceTitolo;
						}
						return "";
					},
					"name" : "",
					"orderable" : false,
					"targets" : 0
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoDal)) {
								return row.giornoDal;
							}
							return "";
						},
						"name" : "elimPeriodoGgDal",
						"targets" : 1,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.giornoAl)) {
								return row.giornoAl;
							}
							return "";
						},
						"name" : "elimPeriodoGgAl",
						"targets" : 2,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag1 && row.flag1 !== "") {
								return row.flag1;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 3,
					},
					{
						"render" : function(data, type, row) {
							if (row.flag2 && row.flag2 !== "") {
								return row.flag2;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 4,
					},
					{
						"render" : function(data, type, row) {
							if (row.spec && row.spec !="") {
								return row.spec;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 5,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 6,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 7,
					},
					{
						"render" : function(data, type, row) {
							if (row.numero && row.numero !=0) {
								return row.numero;
							}
							return "";
						},
						"name" : "titlPeriodoMm",
						"targets" : 8,
					},
					{
						"render" : function(data, type, row) {
							if (row.annoTitolo && row.annoTitolo !== 0) {
								return row.annoTitolo;
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 9,
					},
					{
						"render" : function(data, type, row) {
							if (row.mese && row.mese !== 0) {
								return row.mese
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 10,
					},
					{
						"render" : function(data, type, row) {
							if (row.dal && row.dal !== "") {
								return moment(row.dal).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "titlPeriodoDal",
						"targets" : 11,
					},
					{
						"render" : function(data, type, row) {
							if (row.al && row.al !== "") {
								return moment(row.al).format("DD/MM/YYYY");
							}
							return "";
						},
						"name" : "titlPeriodoAl",
						"targets" : 12,
					},
					{ 
						"render" : function(data, type, row) {
							if (!isNaN(row.ore)) {
								return row.ore;
							}
							return "";
						},
						"name" : "titlPeriodoOre",
						"targets" : 13,
					}]	
		});	
}
$("#li7").on("click", function() {
	titoliPunteggiDatatable();
});
	function titoliPunteggiDatatable(){
	tPunteggi = $('#calcPunt').DataTable(
	{
			"info": false,
			"bSort": false,
			"paging": false, 
			"info": false,
			"bFilter" : false,
			"bSort": false,
			"destroy" : true,
			"processing" : true,
			"serverSide" : true,
			"mark" : true,
			"responsive" : true,
			"pageLength" : '${numeroMassimoRecord}',
			"language" : {"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'},
			"ajax" : {
				"url" : '<spring:url value="/punteggi/puntCalc/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'/'+progressivoCalcolo+'.json" />',
				"dataSrc" : "payload"
			},
			"deferRender" : true,
			"columnDefs" : [
					{
					"render" : function(data, type, row) {
						if (!isNaN(row.codice)) {
							return row.codice;
						}
						return "";
					},
					"name" : "ptgiCodtit",
					"orderable" : false,
					"targets" : 0
					},
					{
						"render" : function(data, type, row) {
							if (row.descrizione && row.descrizione !="") {
								return row.descrizione;
							} 
							return "";
						},
						"name" : "descrizione",
						"targets" : 1,
					},
					{
						"render" : function(data, type, row) {
							if (!isNaN(row.punteggio) && row.punteggio !=null) {
								return row.punteggio.toFixed(2);
							}else{
								return 0.00;
							}
							return "";
						},
						"type": "num",
						"name" : "ptgiPunti",
						"targets" : 2,
					}],
					 "footerCallback": function ( row, data, start, end, display ) {
						 var punteggioComplessivo=0;
						 $.each(data, function(key, value) {
								punteggioComplessivo+=value.punteggio;
							});
				            // Update footer
				            $( tPunteggi.column( 2 ).footer() ).html(punteggioComplessivo.toFixed(2));
				        }
		});	
}
$("#analiticaPunteggi").click(function(evt) {
	//Prevengo il propagarsi dell'evento
	evt.preventDefault();
	var url ='<spring:url value="/report/analiticaSingola/PDF/'+datiDomanda.anno+'/'+datiDomanda.tipo+'/'+datiDomanda.codiceDomanda+'"/>';
	window.open(url, '_blank');
});
</script>