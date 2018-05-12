<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	var punteggiDt = null;
	var counter = 1;
	$(document).ready(function(){
		if (! $.fn.DataTable.isDataTable( '#puntdt' ))
	 	punteggiDt = $("#puntdt").DataTable({
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
			"url" : '<spring:url value="/gradPunt/elencoGraduatoriePunteggi.json" />',
			"dataSrc" : "payload"
					},
			"deferRender" : true,
			"columnDefs" : [{
							  "render" : function(data,type,row) {
										 return counter++;
										 },
										 "name" : "id.tbgrProgcalc",
										 "targets" : 0
										},
							{
							  "render" : function(data,type,row) {
										 if (row.nominativo && row.nominativo !== "") {
										 	return row.nominativo;
										 }
										 return "";
										 },
										 "name" : "nominativo",
										 "targets" : 1
										 },
							{
							  "render" : function(data,type,row) {
										 if (row.punteggio && row.punteggio !== "") {
										  	return row.punteggio;
										 }
										 return "";
										 },
										"name" : "punteggio",
										"targets" : 2
							},
							{
								  "render" : function(data,type,row) {
											 if (row.voto && row.voto !== "") {
											  	return row.voto;
											 }
											 return "";
											 },
											"name" : "t",
											"targets" : 3
							},
							{
								  "render" : function(data,type,row) {
											 if (row.dataLaurea && row.dataLaurea !== "") {
											  	return row.dataLaurea;
											 }
											 return "";
											 },
											"name" : "dataLaurea",
											"targets" : 4
							},
							{
								  "render" : function(data,type,row) {
											 if (row.data && row.data !== "") {
											  	return row.data;
											 }
											 return "";
											 },
											"name" : "dataNascita",
											"targets" : 5
							}]
							});
	});
	</script>
	<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="bs-panel">
							<div class="panel panel-default panel_padding_l_r">
								<div class="panel-body panel_min_height home_news">
								<div class="align_center">
								<h4>Seleziona il formato</h4>
								<a href="<spring:url value="/report/gradPunteggi/PDF/${sessionScope.anno}/${sessionScope.tipoGraduatoria}" />" target="_blank"><i class="fa fa-file-pdf-o red size40 drinkcard-cc" aria-hidden="true" id="pdf" style="margin-right:10px;"></i></a>
     							<a href="<spring:url value="/report/gradPunteggi/XLS/${sessionScope.anno}/${sessionScope.tipoGraduatoria}" />" target="_blank"><i class="fa fa-file-excel-o green size40 drinkcard-cc" aria-hidden="true" id="excel"></i></a>
								</div>
									<table id="puntdt"
										class="datatables-table table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Posizione graduatoria</th>
												<th>Nominativo</th>
												<th>Punteggio</th>
												<th>Voto laurea</th>
												<th>Data laurea</th>
												<th>Data nascita</th>
											</tr>
										</thead>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>