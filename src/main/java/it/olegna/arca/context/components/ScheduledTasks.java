package it.olegna.arca.context.components;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.service.CampionatoSvc;

@Component
public class ScheduledTasks
{
	private static final Logger logger = LoggerFactory.getLogger(ScheduledTasks.class.getName());
	@Autowired
	private CampionatoSvc<Campionato> campSvc;
	@Scheduled(cron="${arca.context.attivazione.campionati.scheduler}")
	public void avviaCampionato()
	{
		try
		{
			campSvc.attivaCampionato();
		}
		catch (Exception e)
		{
			logger.error("Errore nell'avviare i campionati; [{}]", e.getMessage(), e);
		}
	}
}
