<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="bs-panel">
			<div class="panel panel-default panel_padding_l_r">
				<div class="panel-body panel_min_height home_news">
				<!-- FORM RICERCA -->
					<form role="form" id="form_ricerca_medico">
					<!-- ANNO -->
					<div class="form-group col-md-3">
						<label for="annoRicerca" class="control-label">Anno</label> <input
							type="text" class="form-control" id="annoRicerca">
					</div>
					<!-- TIPO GRADUATORIA -->
					<div class="form-group col-md-3">
						<label for="tipoRicerca" class="control-label">Tipo grad.</label>
						<select class="form-control" id="tipoRicerca">
						<option value="">Nessuna selezione</option>
						<option value="MG">MG</option>
						<option value="PD">PD</option>
						</select>
					</div>
					<!-- CODICE DOMANDA -->
					<div class="form-group col-md-6">
						<label for="codice_domanda" class="control-label">Cod. dom.</label> <input
							type="text" class="form-control" id="codice_domanda">
					</div>
					<!-- NOMINATIVO -->
						<div class="form-group col-md-8">
							<label for="nome" class="control-label">Nominativo</label>
							<input type="text" class="form-control" id="nome"
								placeholder="Nome">
						</div>
					<!-- DATA DI NASCITA -->
						<div class="form-group col-md-4">
							<label for="dataCompilazione" class="control-label">Data di
								nascita</label>
							<div class="input-group date datepicker_data">
								<input id="dataCompilazione" name="dataCompilazione"
									class="form-control" readonly="readonly" type="text" value="" />
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>

						</div>
					<!-- CODICE FISCALE -->
						<div class="form-group col-md-8">
							<label for="codice_fiscale" class="control-label">Codice
								fiscale</label> <input type="text" class="form-control"
								id="codice_fiscale" placeholder="Codice fiscale">
						</div>
						<div class="form-group col-md-5 margin10">
							<button type="submit" id="ricercaGraduatorie" class="btn btn-default btn-large button_salva">
							<i class="fa fa-search" aria-hidden="true"></i>&nbsp;Ricerca</button>
							<c:choose>
							<c:when test ="${stato=='CH'}">
							<span title="AVVISO : Concorso chiuso! Impossibile inserire una nuova domanda"
							data-toggle="tooltip"><button type="button" class="btn btn-default btn-large button_salva disabled" ><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Nuova</button></span>
							</c:when>
							<c:otherwise>
							<button type="button" class="btn btn-default btn-large button_salva" onclick="javascript:nuovaDomanda();"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Nuova</button>
							</c:otherwise>
							</c:choose>
							<button type="button" class="btn btn-default btn-large button_salva" onclick="javascript:resetFiltri();"><i class="fa fa-reply" aria-hidden="true"></i>&nbsp;Pulisci</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="risultatiRicerca.jsp"></jsp:include>