package it.olegna.arca.context.web.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import it.olegna.arca.context.configuration.events.CreazioneCampionatoEvent;
import it.olegna.arca.context.dto.BaseResponse;
import it.olegna.arca.context.dto.DataTableResponse;
import it.olegna.arca.context.dto.DatiFilialeDto;
import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.dto.MorrisDataDto;
import it.olegna.arca.context.dto.VisualizzaAndamentoRequestDto;
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.DatiFiliale;
import it.olegna.arca.context.service.CampionatoSvc;
import it.olegna.arca.context.service.DatiFilialeSvc;
import it.olegna.arca.context.service.FilialeManagerSvc;
import it.olegna.arca.context.service.GenericSvc;
import it.olegna.arca.context.transformers.MorrisDataTransformer;
import it.olegna.arca.context.web.dto.CampionatoFilialiDto;
import it.olegna.arca.context.web.dto.CreazioneCampionatoDto;
import it.olegna.arca.context.web.dto.IncontroCampionatoDto;
import it.olegna.arca.context.web.dto.UserPrincipal;

@RestController
@RequestMapping("/rest")
public class MainRestController {
	private static final Logger logger = LoggerFactory.getLogger(MainRestController.class.getName());
	@Autowired
	private FilialeManagerSvc filialeSvc;
	@Autowired
	private DatiFilialeSvc datiFilialeSvc;
	@Autowired
	private CampionatoSvc<Campionato> campionatoService;
	@Autowired
	private GenericSvc<IncontroCampionatoDto> incontriCampionatiSvc;
	@Autowired
	private HttpServletRequest req;
	@Autowired
	private ApplicationEventPublisher publisher;
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = { RequestMethod.GET}, value = { "/protected/estendiSessione" })
	public ResponseEntity<BaseResponse<String>> estendiSessione()
	{
		BaseResponse<String> result = new BaseResponse<String>();
		String resultMsg = null;
		String message = null;
		HttpStatus status = null;
		try {
			resultMsg = "OK";
			status = HttpStatus.OK;
		} catch (Exception e) {
			message = "Errore nell'estensione della sessione utente";
			logger.error(message, e);
			status = HttpStatus.INTERNAL_SERVER_ERROR;
			resultMsg = "KO";
		}
		result.setDescrizioneOperazione(message);
		result.setEsitoOperazione(status.value());
		result.setNumeroOggettiRestituiti(1);
		result.setNumeroOggettiTotali(1);
		result.setPayload(Collections.singletonList(resultMsg));
		return new ResponseEntity<BaseResponse<String>>(result, status);
	}
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = { RequestMethod.GET}, value = { "/protected/elencoFiliali" })
	public ResponseEntity<DataTableResponse<FilialeDto>> elencoFiliali()
	{
		DataTableResponse<FilialeDto> result = null;
		HttpStatus status = null;
		try
		{
			String filtroRicerca = req.getParameter("search[value]");
			Long draw = new Long(req.getParameter("draw"));
			Integer offset = new Integer(req.getParameter("start"));
			Integer length = new Integer(req.getParameter("length"));
			result = this.filialeSvc.ricercaElencoFiliali(filtroRicerca, offset, length);
			if(result != null)
			{
				result.setNumeroOggettiRestituiti(length);
				result.setRecordsFiltered(result.getRecordsTotal());
				status = HttpStatus.OK;
				result.setDraw(draw);
			}
			else
			{
				result = new DataTableResponse<>();
				result.setDescrizioneOperazione("Nessuna filiale trovata");
				result.setNumeroOggettiRestituiti(0);
				result.setRecordsFiltered(0l);
				status = HttpStatus.OK;
				result.setDraw(draw);
				result.setPayload(Collections.emptyList());
			}
		}
		catch (Exception e)
		{
			status = HttpStatus.INTERNAL_SERVER_ERROR;
			String message = "Errore nella chiamata ajax per l'elenco dei dispositivi attivi; " + e.getMessage();
			logger.error(message, e);
			result.setDescrizioneOperazione(message);
			result.setEsitoOperazione(status.value());
		}
		return new ResponseEntity<DataTableResponse<FilialeDto>>(result, status);

	}
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = { RequestMethod.POST}, value = { "/protected/creazioneCampionato" })
	public ResponseEntity<BaseResponse<String>> creazioneCampionato(@RequestBody CreazioneCampionatoDto creaCampionatoRequest)
	{
		BaseResponse<String> result = new BaseResponse<String>();
		HttpStatus status = null;
		try
		{
			if( logger.isDebugEnabled() )
			{
				logger.debug("CREAZIONE CAMPIONATO PER RICHIESA [{}] ", creaCampionatoRequest);
			}
			List<CampionatoFilialiDto> campionatoFiliali = this.campionatoService.creaCampionato(creaCampionatoRequest);
			result = new BaseResponse<String>();
			status = HttpStatus.OK;
			result.setDescrizioneOperazione("Creazione campionato avvenuta con successo");
			result.setEsitoOperazione(status.value());
			result.setNumeroOggettiRestituiti(1);
			result.setNumeroOggettiTotali(1);
			result.setPayload(Collections.singletonList("OK"));
			//Genero e propago l'evento
			String creatoDa = "anonimo";
			if( SecurityContextHolder.getContext() != null && SecurityContextHolder.getContext().getAuthentication() != null && SecurityContextHolder.getContext().getAuthentication().getPrincipal() != null )
			{
			
				UserPrincipal user = (UserPrincipal)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				creatoDa = user.getUsername();
			}			
			CreazioneCampionatoEvent cce = new CreazioneCampionatoEvent(this, new Date(creaCampionatoRequest.getDataInizio()), campionatoFiliali, creatoDa);
			publisher.publishEvent(cce);
		}
		catch (Exception e)
		{
			status = HttpStatus.INTERNAL_SERVER_ERROR;
			String message = "Errore nella chiamata ajax per la creazione del campionato; " + e.getMessage();
			logger.error(message, e);
			result.setDescrizioneOperazione(message);
			result.setEsitoOperazione(status.value());
		}
		return new ResponseEntity<BaseResponse<String>>(result, status);

	}	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = { RequestMethod.POST}, value = { "/protected/visualizzaAndamenti" })
	public ResponseEntity<BaseResponse<MorrisDataDto>> visualizzaAndamenti(@RequestBody VisualizzaAndamentoRequestDto request)
	{
		BaseResponse<MorrisDataDto> result = new BaseResponse<MorrisDataDto>();
		HttpStatus status = null;
		try
		{

			DetachedCriteria dc = DetachedCriteria.forClass(DatiFiliale.class);
			dc.createAlias("filiale", "filiale");
			dc.add(Property.forName("filiale.id").in(request.getIdFiliali()));
			ProjectionList pl = Projections.projectionList();
			pl.add(Projections.property("re"), "re");
			pl.add(Projections.property("auto"), "auto");
			pl.add(Projections.property("totale"), "totaleReAuto");
			pl.add(Projections.property("filiale.nomeFiliale"), "nomeFiliale");
			pl.add(Projections.property("dataDati"), "dataDati");
			dc.setProjection(pl);
			dc.setResultTransformer(new MorrisDataTransformer());
			List<MorrisDataDto> objs = this.datiFilialeSvc.ricercaMorrisDatiFiliali(dc);
			status = HttpStatus.OK;
			result.setDescrizioneOperazione("Recupero dati filiale OK");
			result.setEsitoOperazione(status.value());
			result.setPayload(objs);
			result.setNumeroOggettiRestituiti(objs.size());
			result.setNumeroOggettiTotali(objs.size());
		}
		catch (Exception e)
		{
			status = HttpStatus.INTERNAL_SERVER_ERROR;
			String message = "Errore nella chiamata ajax per l'elenco dei dispositivi attivi; " + e.getMessage();
			logger.error(message, e);
			result.setDescrizioneOperazione(message);
			result.setEsitoOperazione(status.value());
		}
		return new ResponseEntity<BaseResponse<MorrisDataDto>>(result, status);
	}
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = { RequestMethod.GET}, value = { "/protected/dettagliFiliale" })
	public ResponseEntity<DataTableResponse<DatiFilialeDto>> recuperaDatiFiliale()
	{
		DataTableResponse<DatiFilialeDto> result = null;
		HttpStatus status = null;

		try
		{
			String idFiliale = req.getParameter("idFiliale");
			if( !StringUtils.hasText(idFiliale) )
			{
				throw new IllegalArgumentException("Passato un idFiliale nullo o vuoto");
			}

			Long draw = new Long(req.getParameter("draw"));
			Integer offset = new Integer(req.getParameter("start"));
			Integer length = new Integer(req.getParameter("length"));
			result = this.datiFilialeSvc.ricercaDatiFilialiDto(idFiliale, offset, length);
			result.setDraw(draw);
			status = HttpStatus.OK;
		}
		catch (Exception e)
		{
			result = new DataTableResponse<>();
			status = HttpStatus.INTERNAL_SERVER_ERROR;
			String message = "Errore nella chiamata ajax per l'elenco dei dispositivi attivi; " + e.getMessage();
			logger.error(message, e);
			result.setDescrizioneOperazione(message);
			result.setEsitoOperazione(status.value());
		}
		return new ResponseEntity<DataTableResponse<DatiFilialeDto>>(result, status);
	}
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = { RequestMethod.GET}, value = { "/protected/recuperaIncontri" })
	public ResponseEntity<BaseResponse<IncontroCampionatoDto>> getIncontri()
	{
		BaseResponse<IncontroCampionatoDto> result = new BaseResponse<IncontroCampionatoDto>();
		HttpStatus status = null;
		try
		{

			List<IncontroCampionatoDto> incontri = this.incontriCampionatiSvc.getIncontri();
			if( incontri == null )
			{
				incontri = new ArrayList<IncontroCampionatoDto>(0);
			}
			status = HttpStatus.OK;
			result.setDescrizioneOperazione("Recupero incontri OK");
			result.setEsitoOperazione(status.value());
			result.setNumeroOggettiRestituiti(incontri.size());
			result.setNumeroOggettiTotali(incontri.size());
			result.setPayload(incontri);
		}
		catch (Exception e)
		{
			status = HttpStatus.INTERNAL_SERVER_ERROR;
			String message = "Errore nella chiamata ajax per il recupero incontri; " + e.getMessage();
			logger.error(message, e);
			result.setDescrizioneOperazione(message);
			result.setEsitoOperazione(status.value());
		}
		return new ResponseEntity<BaseResponse<IncontroCampionatoDto>>(result, status);

	}	
}