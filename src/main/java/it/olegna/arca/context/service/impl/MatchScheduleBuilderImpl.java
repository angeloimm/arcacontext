package it.olegna.arca.context.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.olegna.arca.context.dao.GenericDao;
import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.CampionatoFiliale;
import it.olegna.arca.context.service.MatchScheduleBuilder;
import it.olegna.arca.context.web.dto.CampionatoFilialiDto;

@Service
public class MatchScheduleBuilderImpl implements MatchScheduleBuilder
{
	private static final Logger logger = LoggerFactory.getLogger(MatchScheduleBuilderImpl.class.getName());
	@Autowired
	private GenericDao<CampionatoFiliale> genericDao;
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void creaCalendarioMatch(List<CampionatoFilialiDto> campionatoFiliali) throws ArcaContextDbException
	{
		try
		{
			for (CampionatoFilialiDto campionatoFilialiDto : campionatoFiliali)
			{
				if( logger.isDebugEnabled() )
				{
					logger.debug("CREAZIONE CALENDARIO MATCH PER CAMPIONATO CON ID [{}] E DATA INIZIO [{}]", campionatoFilialiDto.getIdCampionato(), campionatoFilialiDto.getDataInizioCampionato());
				}
			}
		}
		catch (Exception e)
		{
			String msg = "Errore nel recupero della prossima data torneo; "+e.getMessage();
			if( logger.isErrorEnabled() )
			{
				logger.error(msg, e);
			}
			throw new ArcaContextDbException(msg, e);
		}

	}
	private void createSchedule( List<FilialeDto> filiali, String idCampionato, Date dataInizio )
	{
		if (filiali.size() % 2 != 0)
		{
			FilialeDto fake = new FilialeDto();
			fake.setId("Bye");
			fake.setNomeFiliale("Bye");
			filiali.add(fake); // Se dispari aggiungo una filiale fittizia
		}
		int numTeams = filiali.size();
		int numDays = (numTeams - 1); // Numero di giorni necessari a completare tutti i match
		int halfSize = numTeams / 2;

		List<FilialeDto> teams = new ArrayList<FilialeDto>();

		teams.addAll(filiali); // Aggiungo alla lista i vari team e rimuovo il primo
		teams.remove(0);

		int teamsSize = teams.size();
		DateTime dataInizioMatch = new DateTime(dataInizio.getTime());
		for (int day = 0; day < numDays; day++)
		{
			System.out.println("Day "+(day + 1)+"");

			int teamIdx = day % teamsSize;

			System.out.println(teams.get(teamIdx)+"  vs "+filiali.get(0));

			for (int idx = 1; idx < halfSize; idx++)
			{               
				int firstTeam = (day + idx) % teamsSize;
				int secondTeam = (day  + teamsSize - idx) % teamsSize;
				System.out.println(teams.get(firstTeam)+"  vs   "+teams.get(secondTeam));
			}
		}
	}
	@PostConstruct
	public void initialize()
	{
		genericDao.setPersistentClass(CampionatoFiliale.class);
	}
}