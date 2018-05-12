<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<title>Graduatoria Medici - Titoli</title>
		<script type="text/javascript" charset="UTF8">
			var elencoTipiDt = null;
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
				$("#ricercaTipi").click(function(evt) {
					//Prevengo il propagarsi dell'evento
					evt.preventDefault();
					reloadTabella();
				});
				elencoTipiDt = $("#elencoTipi").DataTable(
								{
									"processing" : true,
									"serverSide" : true,
									"searching" : true,
									"mark" : true,
									"responsive" : true,
									"pageLength" : '${numeroMassimoRecord}',
									"language" : {
										"url" : '<spring:url value="/resources/vendor/dataTables/i18n/Italian.lang"/>'
									},
									"ajax" : {
										"url" : '<spring:url value="/table/elencoTipGrad.json" />',
										"dataSrc" : "payload"
									},
									"deferRender" : true,
									"columnDefs" : [
											{
												"render" : function(data, type,
														row) {
													if (row.tipo
															&& row.tipo !== "") {
														return row.tipo;
													}
													return "";
												},
												"name" : "tbtgTipograd",
												"targets" : 0
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
												"name" : "tbtgDescr",
												"targets" : 1
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
												"name" : "tbtgDescabb",
												"targets" : 2
											} ]
								});
			});

			function reloadTabella() {
				if (elencoTipiDt && elencoTipiDt != null) {
					var baseUrl = '<spring:url value="/table/elencoTipGrad.json" />';
					var filtri = new Object();
					if ($("#descrizione").val() !== "") {
						filtri.descrizione = $("#descrizione").val();
					}
					if ($("#tipoRicerca").val() !== "") {
						filtri.tipo = $("#tipoRicerca").val();
					}
					if (baseUrl.indexOf('?') > -1) {
						baseUrl += '&';
					} else {
						baseUrl += '?';
					}
					baseUrl += $.param(filtri);
					elencoTipiDt.ajax.url(baseUrl).load();
				}
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">

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
							id="codiceFunzione" readonly value="F_TBTG">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body home_news">
									<!-- FORM RICERCA -->
									<form role="form">
									<!-- TIPO GRADUATORIA -->
									<div class="form-group col-md-4">
										<label for="tipoRicerca" class="control-label">Tipo grad.</label> <input
											type="text" class="form-control" id="tipoRicerca">
									</div>
										<!-- DESCRIZIONE -->
										<div class="form-group col-md-6">
											<label for="descrizione" class="control-label">Descrizione
											</label> <input type="text" class="form-control" id="descrizione">
										</div>
										<div class="form-group col-md-5 margin10">
											<button type="submit" id="ricercaTipi"
												class="btn btn-default btn-large button_salva">
												<i class="fa fa-search" aria-hidden="true"></i>&nbsp;Ricerca
											</button>
										</div>
									</form>
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
									<table id="elencoTipi"
										class="datatables-table table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Tip grad</th>
												<th>Descrizione</th>
												<th>Descrizione breve</th>
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