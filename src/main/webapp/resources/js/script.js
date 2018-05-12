/* =========================== COSTANTI APPLICAZIONE ============ */

var Constants = {};
Constants.contextPath = "/graduatoriaMedici/";
Constants.loaderImg = "resources/img/busy.gif"

/* =========================== VARIABILI DATATABLES ============= */
var tTitoli96 = null;
var tTitoli97 = null;
var tTitoli98 = null;
var tTitoli99 = null;
var tTitoliValutati = null;
var tTitoliEliminati = null;
var tPunteggi = null;
var t = null;
var countBootpag = 2;
// Flag utile per rendere persistenti le modifiche già nel primo tab di anagrafica domanda
var update = false;
// Flag per memorizzare lo stato della graduatoria selezionata
var updatable = false;
var duplicata = false;

function caricaProvincia() {
	if (!!$("#data").val()) {
		var url = Constants.contextPath + 'province/load.json';
		var dataNascita = $("#data").val();

		$.ajax({
			type: 'GET',
			url: url,
			contentType : 'application/json; charset=UTF-8',
			data: {
				dataNascita : dataNascita
			},
			timeout: 100000,
			dataType: 'json',
			success: function(data) {
				displayProvincia(data);
				displayProvinciaDomicilio(data);
				displayProvinciaResidenza(data);
			}
		});
	} else {
		$select = $('#provincia');
		$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
		$select.selectpicker('refresh');
	}
};
function caricaProvinciaDuplicazione(siglaProvincia,provinciaRes,provinciaDom) {
	if (!!$("#data").val()) {
		var url = Constants.contextPath + 'province/load.json';
		var dataNascita = $("#data").val();

		$.ajax({
			type: 'GET',
			url: url,
			contentType : 'application/json; charset=UTF-8',
			data: {
				dataNascita : dataNascita
			},
			timeout: 100000,
			dataType: 'json',
			success: function(data) {
				// Il toUpperCase è stato necssario per gli inserimenti ereditati dal vecchio applicativo
				displayProvinciaDuplicazione(data,siglaProvincia.toUpperCase());
				displayProvinciaResidenzaDuplicazione(data, provinciaRes.toUpperCase());
				if(provinciaDom != null)
					displayProvinciaDomicilioDuplicazione(data,provinciaDom);
				else
					displayProvinciaDomicilio(data);
			}
		});
	} else {
		$select = $('#provincia');
		$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
		$select.selectpicker('refresh');
	}

};
function displayProvinciaDuplicazione(data,siglaProvincia) {
	$select = $('#provincia');
	$select.html('');
	var map = new Object();
	if (data.payload != null) {
		$.each(data.payload, function(key, value) {
			map[value.siglaProvincia]=value;
			var $option = "<option data-info='"+value.codProvincia+"' value='" + value.siglaProvincia + "'>" + value.descrizione + '</option>';
			$select.append($option);
		});
		$select.prepend("<option value='"+map[siglaProvincia].siglaProvincia+"' data-info='"+map[siglaProvincia].codProvincia+"' selected='selected'>"+map[siglaProvincia].descrizione+"</option>");
	}
	$select.val('');
	$select.selectpicker('refresh');
}

function displayProvincia(data) {
	$select = $('#provincia');
	$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
	if (data.payload != null) {
		$.each(data.payload, function(key, value) {
			var $option = "<option data-info='"+value.codProvincia+"' value='" + value.siglaProvincia + "'>" + value.descrizione + '</option>';
			$select.append($option);
		});
	}
	$select.val('');
	$select.selectpicker('refresh');
}

function caricaComune(codProvincia, codComNascita, asNascita) {
	if (codProvincia != '') {
		var url = Constants.contextPath + 'province/load/comuni.json';

		var codiceProvincia = codProvincia;
		var dataNascita = $("#data").val();

		$.ajax({
			type: 'GET',
			contentType: 'application/json',
			url: url,
			data: {
				dataNascita : dataNascita,
				codiceProvincia : codiceProvincia,
			},
			dataType: 'json',
			timeout: 100000,
			success: function(data) {
				displayComune(data, codProvincia, asNascita);
			}
		});
	} else {
		var $select = $('#luogo');
		$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
		$select.selectpicker('refresh');
	}
};
function displayComune(data, codProvincia, asNascita) {
	$select = $('#luogo');
	$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
	if (data.payload != null) {
		$.each(data.payload, function(key, value) {
			var $option = "<option value='" + value.descrizione + "'>" + value.descrizione + '</option>';
			$select.append($option);
		});
	}
	$select.val('');
	$select.selectpicker('refresh');
}
function displayProvinciaResidenza(data) {
	$select = $('#provincia_res');
	$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
	if (data.payload != null) {
		$.each(data.payload, function(key, value) {
			var $option = "<option  data-info='"+value.codProvincia+"' value='" + value.siglaProvincia + "'>" + value.descrizione + '</option>';
			$select.append($option);
		});
	}
	$select.val('');
	$select.selectpicker('refresh');
}
function displayProvinciaResidenzaDuplicazione(data,siglaProvincia) {
	$select = $('#provincia_res');
	$select.html('');
	if (data.payload != null) {
		var map = new Object();
		$.each(data.payload, function(key, value) {
			map[value.siglaProvincia] = value;
			var $option = "<option  data-info='"+value.codProvincia+"' value='" + value.siglaProvincia + "'>" + value.descrizione + '</option>';
			$select.append($option);
		});
		$select.prepend("<option  data-info='"+map[siglaProvincia].codProvincia+"' value='" + map[siglaProvincia].siglaProvincia + "'>" + map[siglaProvincia].descrizione + '</option>');
	}
	$select.val('');
	$select.selectpicker('refresh');
}
function displayProvinciaDomicilio(data) {
	$select = $('#prov_domicilio');
	$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
	if (data.payload != null) {
		$.each(data.payload, function(key, value) {
			var $option = "<option data-info='"+value.codProvincia+"' value='" + value.siglaProvincia + "'>" + value.descrizione + '</option>';
			$select.append($option);
		});
	}
	$select.val('');
	$select.selectpicker('refresh');
}
function displayProvinciaDomicilioDuplicazione(data,siglaProvincia) {
	$select = $('#prov_domicilio');
	$select.html('');
	if (data.payload != null) {
		var map = new Object();
		$.each(data.payload, function(key, value) {
			map[value.siglaProvincia] = value;
			var $option = "<option data-info='"+value.codProvincia+"' value='" + value.siglaProvincia + "'>" + value.descrizione + '</option>';
			$select.append($option);
		});
		$select.prepend("<option  data-info='"+map[siglaProvincia].codProvincia+"' value='" + map[siglaProvincia].siglaProvincia + "'>" + map[siglaProvincia].descrizione + '</option>');
	}
	$select.val('');
	$select.selectpicker('refresh');
}
function caricaComuneResidenza(codProvincia, codComNascita, asNascita) {
	if (codProvincia != '') {
		var url = Constants.contextPath + 'province/load/comuni.json';
		var codiceProvincia = codProvincia;
		var dataNascita = $("#data").val();

		$.ajax({
			type: 'GET',
			contentType: 'application/json',
			url: url,
			data: {
				dataNascita : dataNascita,
				codiceProvincia : codiceProvincia,
			},
			dataType: 'json',
			timeout: 100000,
			success: function(data) {
				displayComuneResidenza(data, codProvincia, asNascita);
			}
		});
	} else {
		var $select = $('#residenza');
		$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
		$select.selectpicker('refresh');
	}
};


function displayComuneResidenza(data, codProvincia, asNascita) {
	$select = $('#residenza');
	$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
	if (data.payload != null) {
		$.each(data.payload, function(key, value) {
			var $option = "<option value='" + value.descrizione + "'>" + value.descrizione + '</option>';
			$select.append($option);
		});
	}
	$select.val('');
	$select.selectpicker('refresh');
}


function caricaComuneDomicilio(codProvincia, codComNascita, asNascita) {
	if (codProvincia != '') {
		var url = Constants.contextPath + 'province/load/comuni.json';
		var codiceProvincia = codProvincia;
		var dataNascita = $("#data").val();

		$.ajax({
			type: 'GET',
			contentType: 'application/json',
			url: url,
			data: {
				dataNascita : dataNascita,
				codiceProvincia : codiceProvincia,
			},
			dataType: 'json',
			timeout: 100000,
			success: function(data) {
				displayComuneDomicilio(data, codProvincia, asNascita);
			}
		});
	} else {
		var $select = $('#domicilio');
		$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
		$select.selectpicker('refresh');
	}
};
function displayComuneDomicilio(data, codProvincia, asNascita) {
	$select = $('#domicilio');
	$select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>");
	if (data.payload != null) {
		$.each(data.payload, function(key, value) {
			var $option = "<option value='" + value.descrizione + "'>" + value.descrizione + '</option>';
			$select.append($option);
		});
	}
	$select.val('');
	$select.selectpicker('refresh');
}
function caricaUlss(){ 
	  $.ajax({ 
	    type: 'GET', 
	    url: Constants.contextPath + "aziende/elenco.json", 
	    contentType : 'application/json; charset=UTF-8', 
	    timeout: 100000, 
	    dataType: 'json', 
	    success: function(data) { 
	      displayAziende(data); 
	    }, 
	  }); 
	} 
	function displayAziende(data) { 
	  $select = $('#ulss_residenza'); 
	  $select.html("<option value='' selected='selected'>NESSUNA SELEZIONE</option>"); 
	  if (data.payload != null) { 
	    $.each(data.payload, function(key, value) { 
	      var $option = "<option data-info='"+value.codRegione+"/"+value.codAzienda+"'value='"+value.descrizione+"'>"+value.codRegione+"/"+value.codAzienda+ " - " +value.descrizione+'</option>'; 
	      $select.append($option); 
	    }); 
	  } 
	  $select.val(''); 
	  $select.selectpicker('refresh'); 
	} 
	function caricaUlssDuplicazione(codUlss,codAzienda){
		  $.ajax({ 
		    type: 'GET', 
		    url: Constants.contextPath + "aziende/elenco.json", 
		    contentType : 'application/json; charset=UTF-8', 
		    timeout: 100000, 
		    dataType: 'json', 
		    success: function(data) { 
		      displayAziendeDuplicazione(data,codUlss,codAzienda); 
		    }, 
		    error : function(data){ 
		      console.log('Errore',data); 
		    } 
		  }); 
		}
	function displayAziendeDuplicazione(data,codUlss,codAzienda) {
		  $select = $('#ulss_residenza');
		  $select.html('');
		  if (data.payload != null) {
			  var descrizione='';
		    $.each(data.payload, function(key, value) {
		      if(value.codRegione===codUlss && value.codAzienda===codAzienda){
		    	  descrizione=value.descrizione;
		      }
		      var $option = "<option data-info='"+value.codRegione+"/"+value.codAzienda+"' value='"+value.descrizione+"'>"+value.codRegione+"/"+value.codAzienda+" - " +value.descrizione+'</option>'; 
		      $select.append($option); 
		    });
		    $select.prepend("<option data-info='"+codUlss+"/"+codAzienda+"'  value='"+descrizione+"' selected='selected'>"+codUlss+"/"+codAzienda+"</option>"); 
		    $('#ulss_descrizione').val(descrizione);
		  } 
		  $select.val(''); 
		  $select.selectpicker('refresh'); 
		}
function popolaAnagraficaHeader(datiDomanda) 
{
	popolaTitolaritaHeader(datiDomanda);
	popolaTitoliHeader(datiDomanda);
	popolaPunteggiHeader(datiDomanda);
	popolaLaureaStudioHeader(datiDomanda);
}
//Nuova domanda
function nuovaDomanda() 
{
	$.ajax({
		url : Constants.contextPath + "gradDomanda/nextVal",
		contentType : 'application/json; charset=UTF-8',
		type : 'GET',
		success : function(data) 
		{
			// Reset dei form nel caso in cui la richiesta di nuova anagrafica sia successiva all'apertura di un dettaglio
			resetAllFormsDomanda();
			// Destroy Datatables
			destroyDataTables(false);
			// Apro il tab corrispondente al primo step
			$('.nav-tabs a[href="#menu1"]').tab('show');
			// Disabilito i list item se la richiesta di nuova anagrafica sia successiva all'apertura di un dettaglio
			$('.nav-tabs li').addClass("disabled");
			// Rimuovo classe dall'elemento datiAnagrafici
			$('.nav-tabs #init').removeClass("disabled");
			// Setto a none la visibilità degli errori non bloccanti
			$('#alert_age').css('display','none');
			// Rimuovo la visibilità degli errori non bloccanti relativi alla lode
			$('#errorScoreLimit').removeClass("show");
			$('#errorScoreLimit2').removeClass("show");	
			$('#errorScoreSpecLimit').removeClass("show");
			$('#errorScoreSpecLimit2').removeClass("show");	
			
			$('#saveData').prop('disabled',false);
			$('#saveData').removeProp('title');
			$('#persistData').prop('disabled',false);
			$('#persistData').removeProp('title');
			$('#codice').val(data);
			// Setto a false il flag che indica l'eventuale modifica dell'anagrafica domanda
			update = false;
			// Setto a true il flag per l'aggiunta di titoli e tiolarità alla domanda
			updatable = true;
			duplicata = false;
			//Controllo per disabilitare la sezione della specializzazione nel caso di concorso MG
			var tipoSession = $('#tipo').val();;
			if(tipoSession==="MG")
				$('#divSpec').addClass('disabled');
			// Scrollo verso l'alto
			window.scrollTo(0, 0);
		},
	});	
}
function resetAllFormsDomanda()
{
	$('#form_nuova_domanda').trigger("reset");
	$('#form_titoli').trigger("reset");
	$('#form_titolarita').trigger("reset");
	$('#form_punteggi').trigger("reset");
	$('#form_laurea').trigger("reset");
	//Refresh dei selectpicker
	caricaProvincia();
	caricaComune("",null,true);
	caricaComuneResidenza("", null, true);
	caricaComuneDomicilio("", null, true);
	caricaUlss();
}
function popolaTitolaritaHeader(datiDomanda)
{
	$('#form_titolarita #cfHeader').val(datiDomanda.codiceFiscale);
	$('#form_titolarita #nomeHeader').val(datiDomanda.nominativo);
	$('#form_titolarita #luogoHeader').val($('#luogo').find('option:selected').text());
	$('#form_titolarita #data_header').val(datiDomanda.data);
	$('#form_titolarita #codiceHeader').val(datiDomanda.codiceDomanda);
	$('#form_titolarita #sessoHeader').val(datiDomanda.sesso);
	$('#form_titolarita #provinciaHeader').val(datiDomanda.provincia);
}
function popolaTitoliHeader(datiDomanda)
{
	$('#form_titoli #codiceHeader').val(datiDomanda.codiceDomanda);
	$('#form_titoli #data_header').val(datiDomanda.data);
	$('#form_titoli #provinciaHeader').val(datiDomanda.provincia);
	$('#form_titoli #sessoHeader').val(datiDomanda.sesso);
	$('#form_titoli #luogoHeader').val($('#luogo').find('option:selected').text());
	$('#form_titoli #nomeHeader').val(datiDomanda.nominativo);
	$('#form_titoli #cfHeader').val(datiDomanda.codiceFiscale);
}
function popolaPunteggiHeader(datiDomanda)
{
	$('#form_punteggi #data_header').val(datiDomanda.data);
	$('#form_punteggi #cfHeader').val(datiDomanda.codiceFiscale);
	$('#form_punteggi #nomeHeader').val(datiDomanda.nominativo);
	$('#form_punteggi #luogoHeader').val($('#luogo').find('option:selected').text());
	$('#form_punteggi #data_header').val(datiDomanda.data);
	$('#form_punteggi #provinciaHeader').val(datiDomanda.provincia);
	$('#form_punteggi #codiceHeader').val(datiDomanda.codiceDomanda);
	$('#form_punteggi #sessoHeader').val(datiDomanda.sesso);
}
function popolaLaureaStudioHeader(datiDomanda)
{
	$('#cfHeader').val(datiDomanda.codiceFiscale);
	$('#nomeHeader').val(datiDomanda.nominativo);
	$('#sessoHeader').val(datiDomanda.sesso);
	$('#luogoHeader').val($('#luogo').find('option:selected').text());
	$('#provinciaHeader').val(datiDomanda.provincia);
	$('#codiceHeader').val(datiDomanda.codiceDomanda);
	$('#data_header').val(datiDomanda.data);
}
function destroyDataTables(){
	if(tTitoli96 != null){
		tTitoli96.destroy();
		tTitoli96.clear().draw();
	}
	if(tTitoli97 != null){
		tTitoli97.destroy();
		tTitoli96.clear().draw();
	}
	if(tTitoli98 != null){
		tTitoli98.destroy();
		tTitoli98.clear().draw();
	}
	if(tTitoli99 != null){
		tTitoli99.destroy();
		tTitoli99.clear().draw();
	}
	if(tTitoliValutati != null){
		tTitoliValutati.destroy();
		tTitoliValutati.clear().draw();
	}
	if(tTitoliEliminati != null){
		tTitoliEliminati.destroy();
		tTitoliEliminati.clear().draw();
	}
	if(tPunteggi != null){
		tPunteggi.destroy();
		tPunteggi.clear().draw();
	}
	if(t != null){
		t.destroy();
	}
	if(tTitoli != null){
		tTitoli.destroy();
	}
	// Setto a 1 la pagina selezionata di bootpag
	$('.elencoTitoli').bootpag({
		page :1
	});
}
// Funzione per verificare se l'anno dato in ingresso è quello dell'ultimo concorso
function isConcorsoAttuale(anno){
	var myDate = new Date();
	var year = myDate.getFullYear()+1;
	return anno == year;
}
function formatDate(date){
	var app = date.split("/");
	return app[1]+"/"+app[0]+"/"+app[2];
}
// Generica funzione per chiamate ajax con javascript 
function xhr(method, uri,dialogRef,nomeFile) {
  var req = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
  req.responseType = "blob";
  req.onload = function (e) {
		$.unblockUI();
	    if (this.status === 200) {
	        var file = window.URL.createObjectURL(this.response);
	        var a = document.createElement("a");
	        a.href = file;
	        if (this.response.type==='application/x-pdf') {
	        	 a.download = nomeFile+".xls";
			}else{
				a.download = nomeFile+".pdf";
			}
	        document.body.appendChild(a);
	        a.click();
	        dialogRef.close();
	    };
	    if(this.status === 201){
	    	dialogRef.setClosable(true);
			dialogRef.getModalFooter().hide();
			var dati = new Object();
			dati.errori = true;
			var text = '<div id="cancellazioneTitolo" class="alert alert-warning" role="alert">'+
					   '<i class="fa fa-exclamation-triangle red" aria-hidden="true"></i>'+
				       '&nbsp; Impossibile generare il report. Non &egrave; stato trovato alcun elemento</div>';
			var htmlDialog = text;
			dialogRef.getModalBody().html(htmlDialog);
	    }
  }
  req.open(method, uri, true);
  req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  beforeSend(dialogRef);
  req.send();
}
function beforeSend(dialogRef){
	dialogRef.getModalBody().html('<center><h2><img src="'+Constants.contextPath+Constants.loaderImg+'" /></h2>'
			+' Stiamo processando la richiesta...');
}
// Validazione input: campo vuoto, numerico e maggiore di
validation = {
	    isNotEmpty:function (str) {
	        var pattern =/\S+/;
	        return pattern.test(str);  // controlla che la stringa passata in ingresso non sia vuota; ritorna un booleano
	    },
	    isNumber:function(str) {
	        var pattern = /^\d+$/;
	        return pattern.test(str);  // controlla che la stringa passata in ingresso sia un numero; ritorna un booleano
	    },
	    isGreaterThan: function(str1, str2){
	    	return str1>=str2;          // controlla che, tra due parametri in ingresso, il primo sia maggiore o uguale al secondo; ritorna un booleano
	    },
}; 
function manageMenu(str){
	var listItems = ['menuHome','menuTabelle','menuParametriAnno','menuGestioneGraduatorie','menuDocumenti'];
	$.each(listItems, function(key, value) {
		if(value !== str)
			$('#'+listItems).removeClass('active');
	});
}
/**
 * Apre una finestra modale generica
 * @param str, template per il body del modal
 */
function modalErrore(str){
	BootstrapDialog.show({
		title : 'Errore',
		message : function(dialog) {
			var $modalBody = str();
			return $modalBody;
		},
		size : BootstrapDialog.NORMAL,
		type : BootstrapDialog.TYPE_PRIMARY,
		closable : true,
		draggable : false,
		nl2br : false,
		buttons : [
				 {
					id : 'annullaConferma',
					label : 'Chiudi',
					action : function(dialogRef) {
						dialogRef.close();
					}
				} ]
	});
}
function verificaVotoLode(){
	abilitaLode();
	var score=$('#score').val();
	var voto = parseInt(score); 
	var limitScore=$('#limitScore').val();
	var limite = parseInt(limitScore); 
	var lode = $('#lode').val();
	if(voto===limite && lode==="S")
	{
		$('#errorScoreLimit').removeClass("show");
		$('#errorScoreLimit2').removeClass("show");	
	}
	else if(voto<limite && lode==="S")
	{
		$('#errorScoreLimit').addClass("show");	
		$('#errorScoreLimit2').removeClass("show");	
	}
	else if(voto>limite && lode==="S")
	{
		$('#errorScoreLimit2').addClass("show");	
		$('#errorScoreLimit').removeClass("show");
	}
}