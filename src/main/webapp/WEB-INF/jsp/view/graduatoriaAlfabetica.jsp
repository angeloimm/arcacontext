<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	var alfabeticaDt = null;
	$(document).ready(function(){
		if (! $.fn.DataTable.isDataTable( '#alfabeticaDt' ))
			alfabeticaDt = $("#alfabeticaDt").DataTable({
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
			"url" : '<spring:url value="/gradPunt/elencoGraduatorieAlfabetica.json" />',
			"dataSrc" : "payload"
					},
			"deferRender" : true,
			"columnDefs" : [{
							  "render" : function(data,type,row) {
										 if (row.nominativo && row.nominativo !== "") {
										 	return row.nominativo;
										 }
										 return "";
										 },
										 "name" : "nominativo",
										 "targets" : 0
										 },
							{
							  "render" : function(data,type,row) {
										 if (row.punteggio && row.punteggio !== "") {
										  	return row.punteggio;
										 }
										 return "";
										 },
										"name" : "punteggio",
										"targets" : 1
							},
							{
								  "render" : function(data,type,row) {
											 if (row.luogoResidenza && row.luogoResidenza !== "") {
											  	return row.luogoResidenza;
											 }
											 return "";
											 },
											"name" : "t",
											"targets" : 2
							},
							{
								  "render" : function(data,type,row) {
											 if (row.frazione && row.frazione !== "") {
											  	return row.frazione;
											 }
											 return "n.d.";
											 },
											"name" : "frazione",
											"targets" : 3
							},
							{
								  "render" : function(data,type,row) {
											 if (row.provincia && row.provincia !== "") {
											  	return row.provincia.toUpperCase();
											 }
											 return "";
											 },
											"name" : "provinciaRes",
											"targets" : 4
							}]
							});
	});
	</script>
	<div class="row">
			<div class="container" id="cont">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body panel_min_height home_news">
								<div class="align_center">
								<h4>Seleziona il formato</h4>
								<a href="<spring:url value="/report/gradPunteggiDettaglio/PDF/${sessionScope.anno}/${sessionScope.tipoGraduatoria}" />" target="_blank"><i class="fa fa-file-pdf-o red size40 drinkcard-cc" aria-hidden="true" id="pdf" style="margin-right:10px;"></i></a>
     							<a href="<spring:url value="/report/gradPunteggiDettaglio/XLS/${sessionScope.anno}/${sessionScope.tipoGraduatoria}" />" target="_blank"><i class="fa fa-file-excel-o green size40 drinkcard-cc" aria-hidden="true" id="excel"></i></a>
								</div>
									<table id="alfabeticaDt"
										class="datatables-table table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Nominativo</th>
												<th>Punteggio</th>
												<th>Residenza luogo</th>
												<th>Residenza frazione</th>
												<th>Residenza provincia</th>
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