package it.olegna.arca.context.web.controller;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import it.olegna.arca.context.configuration.events.CaricamentoDatiEvent;
import it.olegna.arca.context.dto.FileUploadResponseDto;
import it.olegna.arca.context.dto.UploadedFileDto;
import it.olegna.arca.context.service.DataReader;
import it.olegna.arca.context.service.FilialeManagerSvc;
import it.olegna.arca.context.web.dto.DatiFilialiContainer;

@RestController
@RequestMapping("/rest")
public class UploadFileController {
	private static final Logger logger = LoggerFactory.getLogger(UploadFileController.class.getName());
	@Autowired
	private DataReader reader;
	@Autowired
	private FilialeManagerSvc filialeSvc;
	@Autowired
	private ApplicationEventPublisher publisher;
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = { RequestMethod.POST }, value = { "/protected/uploadedDatiFiliali" })
	public ResponseEntity<FileUploadResponseDto> uploadRiversamentoManuale(	
																			@RequestParam(required = true, value = "uploadedDatiFiliali") MultipartFile mpf,
																			@RequestParam(required = false, value = "dataSelezionata") String dataSelezionata
																		   )

	{
		List<UploadedFileDto> uploadedFiles = null;
		String fileName = mpf.getOriginalFilename();
		if( logger.isDebugEnabled() )
		{
			logger.debug("Nome file uploadato: "+fileName);
		}
		try {
			DatiFilialiContainer res = reader.dataReader(mpf.getInputStream());
			filialeSvc.salvaAggiornaFilialeAndDati(res.getDatiFiliale(), res.getDataRiferimento());
			//Genero e propago l'evento
			CaricamentoDatiEvent cde = new CaricamentoDatiEvent(this, res.getDataRiferimento());
			publisher.publishEvent(cde);
			UploadedFileDto ufd = new UploadedFileDto();
			ufd.setId(UUID.randomUUID().toString());
			ufd.setName(fileName);
			ufd.setSize(mpf.getSize());
			uploadedFiles = Collections.singletonList(ufd);
		} catch (Exception e) {
			String message = "Errore nell'upload del file "+fileName+"; "+e.getMessage();
			logger.error(message, e);
			uploadedFiles = Collections.singletonList(new UploadedFileDto("", mpf.getOriginalFilename(), mpf.getSize(), "", "", "", "", message));
		}
		// Restituisco sempre un HTTP Status 200 ma con un array di files in cui
		// eventualmente è contenuto il messaggio di errore
		return new ResponseEntity<FileUploadResponseDto>(new FileUploadResponseDto(uploadedFiles), HttpStatus.OK);
	}
}