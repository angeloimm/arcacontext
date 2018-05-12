<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="bs-panel">
			<div class="panel panel-default panel_padding_l_r">
				<div class="panel-body panel_min_height home_news">
					<h3>TITOLI VALUTATI</h3>
					<table id="titoliAnnoTable"
						class="datatables-table table table-striped table-bordered table-hover">
						<thead>
							<tr id="addRow">
								<th>Cod.</th>
								<th>Titolo</th>
								<th>Un.Mis.</th>
								<th>Punti</th>
								<th>P.Max.</th>
								<th>Tipo</th>
								<th>Obbl.</th>
								<th>ULSS</th>
								<th></th>
							</tr>
						</thead>
						</tbody>
					</table>
					<button type="button" id="nuovoTitolo"
						class="btn btn-default btn-large button_salva">
						<i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Nuovo
					</button>
					<button type="button"
						class="btn btn-default btn-large button_salva"
						id="stampaTitoliAnno">
						<i class="fa fa-print" aria-hidden="true"></i>&nbsp;Stampa
					</button>
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
					<table id="titoliObblTable"
						class="datatables-table table table-striped table-bordered table-hover">
						<thead>
							<tr id="addRow">
								<th>Cod.Titolo</th>
								<th>Cod.Titolo Obbl.</th>
								<th>Titolo obbligatorio / note</th>
								<th></th>
							</tr>
						</thead>
						</tbody>
					</table>
					<button type="button"
						class="btn btn-default btn-large button_salva" id="nuovoTitoloObbl">
						<i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Nuovo
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" charset="UTF-8">
$(function(){
$('#stampaTitoliAnno').click(function(evt){
	//Prevengo il propagarsi dell'evento
	evt.preventDefault();
	var url = Constants.contextPath + "report/stampaRtbtit/PDF/"+${sessionScope.anno}+"/${sessionScope.tipoGraduatoria}";
	window.open(url, '_blank');
})	
})
</script>