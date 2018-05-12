<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<button type="button" class="btn btn-default btn-large button_salva" id="checkCont">
	<i class="fa fa-check" aria-hidden="true"></i>&nbsp;Controllo
	contemporaneit&agrave;
</button>
<div class="bs-panel">
	<div class="panel panel-default panel_padding_l_r">
		<div class="panel-body panel_min_height home_news">
			<table id="tdc"
				class="datatables-table table table-striped table-bordered table-hover">
				<thead>
					<tr id="addRowContemp">
						<th>Ant.</th>
						<th>Qst</th>
						<th>Errore</th>
					</tr>
				</thead>
				<tbody>
				<tr>
				<td colspan="3" align="center">Per visualizzare gli eventuali errori, clicca su 'Verifica contemporaneit&agrave;'</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript" charset="UTF-8">
$('#checkCont').click(function(){
	$.ajax({
		url : '<spring:url value="/cont/checkCont.json" />',
		dataType : 'json',
		contentType : 'application/json; charset=UTF-8',
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
		success : function(data) {
			if(data.payload.length>0){
			$('#tdc>tbody>tr').empty();
			$.each(data.payload, function(key, value) {
				$("#tdc>tbody").append("<tr><td>"+value.codAntag+"</td><td>"+value.codQues+"</td><td>"+value.errore+"</td></tr>");
			});
			}else{
				$('#tdc>tbody>tr').empty();
				$("#tdc>tbody").append("<tr><td align='center' colspan=3>Nessun errore riscontrato nella verifica di contemporaneit&agrave;</td></tr>");
			}
		},
		error : function(data) {
			mostraErrore();
		}
	});
})
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
</script>