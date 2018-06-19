<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<spring:message code="arca.context.web.msgs.upload.add" var="msgAggiungi"/>
<tiles:insertDefinition name="defaultTemplate">
	<tiles:putAttribute name="head">
		<spring:url value="/resources/images/busy.gif" var="urlBusyImg" />
		<title><spring:message code="arca.context.web.msgs.home.page.title" /></title>
			<!-- File Upload  -->
	<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
	<link rel="stylesheet" href='<spring:url value="/adminWebTheme/vendor/fileUpload/css/jquery.fileupload.css"/>'>
	<link rel="stylesheet" href='<spring:url value="/adminWebTheme/vendor/fileUpload/css/jquery.fileupload-ui.css"/>'>

	<!-- CSS adjustments for browsers with JavaScript disabled -->
	<noscript><link rel="stylesheet" href='<spring:url value="/adminWebTheme/vendor/fileUpload/css/jquery.fileupload-noscript.css"/>'>
	<noscript><link rel="stylesheet" href='<spring:url value="/adminWebTheme/vendor/fileUpload/css/jquery.fileupload-ui-noscript.css"/>'></noscript>
	<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/load-image.all.min.js"/>'></script>

<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/canvas-to-blob.min.js"/>'></script>

<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/jquery-ui.min.js"/>'></script>

	<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/jquery.iframe-transport.js"/>'></script>
<!-- The basic File Upload plugin -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/jquery.fileupload.js"/>'></script>
<!-- The File Upload processing plugin -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/jquery.fileupload-process.js"/>'></script>
<!-- The File Upload image preview & resize plugin -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/jquery.fileupload-image.js"/>'></script>
<!-- The File Upload audio preview plugin -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/jquery.fileupload-audio.js"/>'></script>
<!-- The File Upload video preview plugin -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/jquery.fileupload-video.js"/>'></script>
<!-- The File Upload validation plugin -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/jquery.fileupload-validate.js"/>'></script>
<!-- The File Upload user interface plugin -->
<script src='<spring:url value="/adminWebTheme/vendor/fileUpload/jquery.fileupload-ui.js"/>'></script>	
		<script type="text/x-handlebars-template" id="templateErroreUploadFile">
		<div class="alert alert-danger">
  			<spring:message code="arca.context.web.msgs.upload.error.msg" />
				<ul class="list-group">
					{{#each this}}
						<li class="list-group-item">
							<strong>{{this.fileName}}</strong>
							<ul class="list-group">
								{{#each this.errori}}
									<li class="list-group-item">{{this}}</li>
								{{/each}}
							</ul>
						</li>
  					{{/each}}
				</ul>
		</div>
		</script>
		<script type="text/x-handlebars-template" id="templateDownload">
			{{! Il class template-download serve ad abilitare il pulsante di elimina; il class fade a dare degli effetti nella comparsa della riga }}
			
			<div id="tmplDownloadDiv" class="template-download fade">
				<div class="row">
					{{#if error}}
		  				<div class="col-xs-12">
							<div class="alert alert-danger">
								<strong><i class="fa fa-warning" aria-hidden="true"></i></strong> {{{error}}}
							</div>
  						</div>					
					{{else}}
	  					<div class="col-xs-12">
							<div class="alert alert-info">
								<strong><i class="fa fa-file" aria-hidden="true"></i></strong> <i>{{file.name}}</i> <spring:message code="arca.context.web.msgs.upload.success" />
							</div>
  						</div>
						{{!--
	  					<div class="col-xs-5">
    						<button class="btn btn-danger delete" >
        	            		<i class="glyphicon glyphicon-trash"></i>
            	        		<span><spring:message code="arca.context.web.msgs.upload.delete" /></span>
                			</button>
  						</div>
						--}}
					{{/if}}
				</div>
			</div>
		</script>
		<script type="text/x-handlebars-template" id="templateUpload">
			 {{! Il class template-upload serve ad abilitare il pulsante di upload; il class fade a dare degli effetti nella comparsa della riga }}
			<div class="template-upload fade">
				<div class="row">
  					<div class="col-xs-12">
						<div class="alert alert-info">
  							<strong><i class="fa fa-file" aria-hidden="true"></i></strong> <i>{{file.name}}</i> ({{dimensione}})
						</div>
	  				</div>
				</div>
				<div class="row">
					<div class="col-xs-6 posizColSup">
                		<button type="submit" class="btn btn-primary start">
                    		<i class="glyphicon glyphicon-upload"></i>
                    		<span><spring:message code="arca.context.web.msgs.upload.start" /></span>
                		</button>
                		<button class="btn btn-warning cancel">
                    		<i class="glyphicon glyphicon-ban-circle"></i>
	                    	<span><spring:message code="arca.context.web.msgs.upload.cancel" /></span>
    	            	</button>    
					</div>
				</div>
				<div class="row">
    	     		<div class="col-xs-12">
        	 			<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
			 				<div class="progress-bar progress-bar-success" style="width:0%;"></div>
						</div>
					</div>
				</div>
			</div>
		</script>
		<script type="text/javascript" charset="UTF-8">
			var templateDownload = Handlebars.compile($('#templateDownload').html());
			var templateUploadFile = Handlebars.compile($('#templateUpload').html());
			var templateErroreUploadFile = Handlebars.compile($('#templateErroreUploadFile').html()); 
			$(document).ready( function(){
				if( $('#dateIncontriSel').length && $('#dateIncontriSel').length > 0 )
				{
				 	$("#dateIncontriSel").change(function(){
						 $("#divSelectData").removeClass("has-error has-danger");
						 if($("button.start").is(":disabled"))
						 {
							 $("button.start").prop('disabled', false);
						 }
				 	});
				}
				 $('#fileupload').fileupload({ 
              		autoUpload:false,
				        url: '<spring:url value="/rest/protected/uploadedDatiFiliali.json" />',
				        dropZone: $('#dropzone'),
				        filesContainer: $('#elencoFile'),
						uploadTemplateId: null,
						downloadTemplateId: null,
				        uploadTemplate: function(o) {
				        	var rows = $();						        	
		            		$.each(o.files, function(index, file) {				                        
		                		var data = {o: o, file: file, error:file.error};
		                		data.dimensione = formatBytes(file.size);
		                		var template = templateUploadFile(data);
		                		var row = $(template);
		                		rows = rows.add(row);
		            	  	});
		            		return rows;
		        		},			        		
		    			downloadTemplate: function(o) {
		    				var rows = $();			    			
							$.each(o.files, function(index, file) {
								
	                			var data = {o: o, file: file, error:file.error};
	                			var template = templateDownload(data);
	                			var row = $(template);
	                			rows = rows.add(row);
	                			$('#elencoErroriUploadFile').html("");
		            	  	});
		            		return rows;
		        		}
				    });
				 $(document).bind('dragover', function (e) {
					    var dropZone = $('#dropzone'),
					        timeout = window.dropZoneTimeout;
					    if (timeout) {
					        clearTimeout(timeout);
					    } else {
					        dropZone.addClass('in');
					    }
					    var hoveredDropZone = $(e.target).closest(dropZone);
					    dropZone.toggleClass('hover', hoveredDropZone.length);
					    window.dropZoneTimeout = setTimeout(function () {
					        window.dropZoneTimeout = null;
					        dropZone.removeClass('in hover');
					    }, 100);
					});				 
				$("#fileupload").on('fileuploaddone', function(e, data){ 			
			
                 $("#eliminaTutti").removeClass("disabled");
				});

				$('#fileupload').on('fileuploadsubmit', function (e, data) { 
					if( $('#dateIncontriSel').length && $('#dateIncontriSel').length > 0 )
					{
						var dataSelezionata = $("#dateIncontriSel").val();
						if( dataSelezionata === "" )
						{
							var uploadErrors = [];
							var errori = [];
							errori.push('<spring:message code="arca.context.web.msgs.home.page.date.incontri.required" />');
							var anError = new Object();
							anError.errori = errori;
                     		uploadErrors.push(anError);
                     		$("#elencoErroriUploadFile").html(templateErroreUploadFile(uploadErrors));
                     		$("#divSelectData").addClass("has-error has-danger");
							return false;
						}
						var datiForm = {"dataSelezionata":dataSelezionata}; 
						data.formData = datiForm;
					}
             		return true;	
              }); 				
				
				
	              $('#fileupload').on('fileuploadadd', function (e, data) {
	            	$("#tmplDownloadDiv").remove();
	            	$("#elencoErroriUploadFile").empty();
	            	$("#infoDropZone").hide();
                 	var uploadErrors = [];
                 	var acceptFileTypes = /\.(xls|xlsx|ods)$/i;
                 	var uploadedDatiFilialis = data.originalFiles;
                 	$.each(uploadedDatiFilialis, function( index, datiFiliale ) {
                      	var anError = new Object();
                     	var errorPresent = false;
                     	var errori = [];
                     	if(datiFiliale['name'].length && !acceptFileTypes.test(datiFiliale['name'])) 
	                    {
		                    	errorPresent = true;
		                    	errori.push('<spring:message code="arca.context.web.msgs.upload.upload.error.extension" />');
                     	}
                     	if(datiFiliale['size'] && (datiFiliale['size'] > ${dimensioneFile})) 
	                    	{
                     		errorPresent = true;
                     		errori.push('<spring:message code="arca.context.web.msgs.upload.upload.error.dimension" arguments="${dimensioneFileFormattata}" />');
                     	} 
                     	if(errorPresent === true)
	                    {
                     		anError.fileName = datiFiliale['name'];
                     		anError.errori = errori;
                     		uploadErrors.push(anError);
		                }
                 	});
                 	if(uploadErrors.length > 0) 
                 	{
                 		$("#elencoErroriUploadFile").html(templateErroreUploadFile(uploadErrors));
                 		return false;
                 	} 
                  	else
                    {
	                        $("#caricaTutti").removeClass("disabled");
	                 }		                        
		        });
         });	
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<!-- /.panel-heading -->
					<div class="panel-body">
						<form id="fileupload" role="form">
							<div class="alert alert-info">
								<i class="fa fa-info-circle"></i>&nbsp;<spring:message	code="arca.context.web.msgs.upload.info" arguments="${msgAggiungi}, ${dimensioneFileFormattata}" />
							</div>
<%-- 							<div class="alert alert-warning">
								<spring:message	code="arca.context.web.msgs.upload.info.warn" />
							</div> --%>
							<c:if test="${not empty dateIncontri}">
								<div class="alert alert-info" id="divSelectData">
									<label for="dateIncontriSel" class="control-label">
										<i class="fa fa-info-circle"></i>&nbsp;<spring:message code="arca.context.web.msgs.home.page.date.incontri"/> *
									</label>
									<select class="form-control" id="dateIncontriSel">
										<option value=""> <spring:message code="arca.context.web.msgs.home.page.seleziona.data"/> </option>
										<c:forEach items="${dateIncontri}" var="di">
											<fmt:formatDate value="${di.dataIncontro}" pattern="dd/MM/yyyy" var="dataFormattata"/>
											<fmt:formatDate value="${di.dataInizioSettimana}" pattern="dd/MM/yyyy" var="dataInizioSettimanaFormattata"/>
											<fmt:formatDate value="${di.dataFineSettimana}" pattern="dd/MM/yyyy" var="dataFineSettimanaFormattata"/>
											<option value="${dataFormattata}" > 
												 ${dataInizioSettimanaFormattata} - ${dataFineSettimanaFormattata} (<spring:message code="arca.context.web.msgs.data.incontro.select" arguments="${dataFormattata}"/>)
											</option>
										</c:forEach>
									</select>
								</div>
							</c:if>
							<div class="row fileupload-buttonbar">
								<div class="col-md-12">
									<span class="btn btn-success fileinput-button"> 
										<i class="glyphicon glyphicon-plus"></i> 
										<span>
											${msgAggiungi}
										</span>
										<input type="file" name="uploadedDatiFiliali" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
									</span>
									<button type="submit" id="caricaTutti"	class="btn btn-primary start disabled">
										<i class="glyphicon glyphicon-upload"></i> 
										<span>
											<spring:message code="arca.context.web.msgs.upload.start" />
										</span>
									</button>
									<button type="reset" id="cancellaTutti"	class="btn btn-warning cancel disabled">
										<i class="glyphicon glyphicon-ban-circle"></i> 
										<span>
											<spring:message code="arca.context.web.msgs.upload.cancel" />
										</span>
									</button>
									<button type="button" class="btn btn-danger delete disabled" id="eliminaTutti">
										<i class="glyphicon glyphicon-trash"></i> 
										<span>
											<spring:message code="arca.context.web.msgs.upload.delete" />
										</span>
									</button>
									<!-- The global file processing state -->
									<span class="fileupload-process"></span>
								</div>
								<!-- The global progress state -->
								<div class="col-lg-5 fileupload-progress fade">
									<!-- The global progress bar -->
									<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
										<div class="progress-bar progress-bar-success" style="width: 0%;"></div>
									</div>
									<!-- The extended global progress state -->
									<div class="progress-extended">&nbsp;</div>
								</div>
							</div>
							<div id="elencoFile" role="presentation" class="table table-striped files dropZoneInfo_">
								<div id="dropzone" class="fade well"><spring:message code="arca.context.web.msgs.upload.drop.zone.info"/></div>
							</div>
							<div id="elencoErroriUploadFile"></div>
						</form>
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>