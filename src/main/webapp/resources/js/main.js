String.prototype.abbr = String.prototype.abbr || function(n) {
	return (this.length > n) ? this.substr(0, n-1) + '...' : this;
};

var months = moment.localeData('it').months().map(function (month) { 
	return month.charAt(0).toUpperCase() + month.slice(1).toLowerCase();
});

$(document).ready(function() {
	// posizione header allo scroll
	$('.navbar-static-top').scrollToFixed();
	// posizione suite di pulsanti del dettaglio
	$('#btn-suite').scrollToFixed({
        bottom: 15,
        zIndex: 999,
        limit: function() { return $('#btn-suite-marker').offset().top; }
    });
	
	// apre la modale con un campo in errore
	var $fieldError = $('.modal .field-error');
	if($fieldError.length) {
		$fieldError.closest('.modal').modal('show');
	}
	
	$('.convert-month').each(function() {
		var $this = $(this);
		var monthNum = $this.text();
		var monthName = months[monthNum - 1];
		$this.text(monthName);
	});
	
	// datetimepicker
	$('.datepicker-year').datetimepicker({
		format: 'YYYY',
        showClear: true
	});
	$('.datepicker-month').datetimepicker({
		format: 'M',
        showClear: true
	});
	$('.datepicker-date').datetimepicker({
		format: 'DD/MM/YYYY',
        showClear: true
	});
	
	// slim-formatter
	$('.currency-control').each(function() {
		formatField(this);
	});
	
	$('.currency-control').focusout(function() {
		parseField(this);
		formatField(this);
	});
	
	$('.nav-table').on('click', 'tr', function() {
		window.location.href = $(this).data('href');
	});
});

function formatField(obj) {
	if(obj.value) {
		obj.value = formatCurrency(obj.value);
	}
}

function formatCurrency(num) {
	if($.isNumeric(num)) {
		return slimFormatter.currency(parseFloat(num),'','.',',');
	}
	return '';
}

function parseField(obj) {
	if(obj.value) {
		obj.value = parseCurrency(obj.value);
	}
}

function parseCurrency(value) {
	if ($.isNumeric(value))
		return parseFloat(value);
	else if(typeof value === 'string') {
		var parsedString = value.replace(/\./g, '').replace(/,/g, '.');
		return parseFloat(parsedString);
	}
	return '';
}

function parseAllCurrency() {
	$('.currency-control').each(function() {
		parseField(this);
	});
	return true;
}