package it.olegna.arca.context.listeners;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import it.olegna.arca.context.configuration.events.CaricamentoDatiEvent;
import it.olegna.arca.context.configuration.events.CreazioneCampionatoEvent;
import it.olegna.arca.context.dto.UtenteDto;
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.User;
import it.olegna.arca.context.models.UserProfile;
import it.olegna.arca.context.models.UserProfileType;
import it.olegna.arca.context.service.CampionatoSvc;
import it.olegna.arca.context.service.ClassicaCampionatoSvc;
import it.olegna.arca.context.service.IUserProfileSvc;
import it.olegna.arca.context.service.IUserSvc;
import it.olegna.arca.context.service.MatchScheduleBuilder;

@Component
public class SpringEvtsListener
{
	private static final Logger logger = LoggerFactory.getLogger(SpringEvtsListener.class.getName());
	@Autowired
	private IUserProfileSvc usrProf;
	@Autowired
	private IUserSvc usrSvc;
	@Autowired
	private CampionatoSvc<Campionato> campSvc;
	@Autowired
	private ClassicaCampionatoSvc classificaCampio;
	@Autowired
	@Qualifier("objectMapper")
	private ObjectMapper om;
	@Autowired
	private MatchScheduleBuilder scheduleManager;
	@EventListener
	public void handleContextRefresh(ContextRefreshedEvent event) throws Exception 
	{
		try
		{
			campSvc.attivaCampionato();
			Long ruoliUtente = usrProf.count();
			if( ruoliUtente == null || ruoliUtente == 0 )
			{
				logger.warn("Nessun ruolo utente esistente. Creo quelli di default");
				UserProfile up = new UserProfile();
				up.setCreatoDa("sistema");
				up.setDataCreazione(new Date());
				up.setType(UserProfileType.ADMIN.getUserProfileType());
				usrProf.saveUserProfile(up);
				up = new UserProfile();
				up.setCreatoDa("sistema");
				up.setDataCreazione(new Date());
				up.setType(UserProfileType.SUPER_ADMIN.getUserProfileType());
				usrProf.saveUserProfile(up);
				up = new UserProfile();
				up.setCreatoDa("sistema");
				up.setDataCreazione(new Date());
				up.setType(UserProfileType.USER.getUserProfileType());
				usrProf.saveUserProfile(up);
			}
			else
			{
				if( logger.isInfoEnabled() )
				{
					logger.info("TROVATI {} RUOLI", ruoliUtente);
				}
			}
			Long users = usrSvc.countUsers();
			if( users == null || users == 0 )
			{
				if( logger.isWarnEnabled() )
				{
					logger.warn("NESSUN UTENTE TROVATO. CREO QUELLI DI DEFAULT");
				}
				Resource fileRes = new ClassPathResource("utenti.json");
				ObjectMapper om = new ObjectMapper();
				List<UtenteDto> utenti = om.readValue(fileRes.getInputStream(), new TypeReference<List<UtenteDto>>()
				{
				});
				for (UtenteDto utenteDto : utenti)
				{
					User utente = utenteDto.toUser("sistema");
					usrSvc.saveUser(utente, utenteDto.getRuoli());
				}
			}
			else
			{
				if( logger.isInfoEnabled() )
				{
					logger.info("TROVATI {} UTENTI", users);
				}
			}
		}
		catch (Exception e)
		{
			logger.error("Errore nello startup del contesto", e);
			throw e;
		}
	}
	@EventListener(classes= {CreazioneCampionatoEvent.class})
	public void creazioneCampionatoEvtListener( CreazioneCampionatoEvent cce )
	{
		if( logger.isDebugEnabled() )
		{
			logger.debug("Ricevuto evento di tipo {}; data inizio campionato {}", cce.getClass(), cce.getDataInizioCampionato()); 
		}
		try
		{

			this.scheduleManager.creaCalendarioMatch(cce.getCampionatoFiliali(), cce.getCreatoDa());
		}
		catch (Throwable t) {
			logger.error("Errore nella gestione della creazione calendario", t);
			throw new IllegalStateException(t);
		}
	}
	@EventListener(classes= {CaricamentoDatiEvent.class})
	public void caricamentoDatiEvtListener( CaricamentoDatiEvent cde )
	{
		if( logger.isDebugEnabled() )
		{
			logger.debug("Ricevuto evento di tipo {}; data riferimento {}", cde.getClass(), cde.getDataDati()); 
		}
		try
		{
		
			classificaCampio.calcolaPunteggiCampionati(cde.getDataDati());
		}
		catch (Throwable t) {
			logger.error("Errore nel calcolo dei punti per le classifiche", t);
			throw new IllegalStateException(t);
		}
	}
}
