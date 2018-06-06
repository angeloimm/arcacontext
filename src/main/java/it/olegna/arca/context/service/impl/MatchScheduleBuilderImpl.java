package it.olegna.arca.context.service.impl;


import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.olegna.arca.context.dao.GenericDao;
import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.models.Incontro;
import it.olegna.arca.context.service.MatchScheduleBuilder;
import it.olegna.arca.context.web.dto.CampionatoFilialiDto;

@Service
public class MatchScheduleBuilderImpl implements MatchScheduleBuilder
{
	private static final Logger logger = LoggerFactory.getLogger(MatchScheduleBuilderImpl.class.getName());
	@Autowired
	private GenericDao<Incontro> genericDao;
	private static final String FAKE_FILIALE_NAME = "Bye";
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void creaCalendarioMatch(List<CampionatoFilialiDto> campionatoFiliali, String creatoDa) throws ArcaContextDbException
	{
		try
		{
			List<Incontro> incontri = new ArrayList<Incontro>();
			DateTime start = null;
			for (CampionatoFilialiDto cfd : campionatoFiliali)
			{
				if( logger.isDebugEnabled() )
				{
					logger.debug("CREAZIONE CALENDARIO MATCH PER CAMPIONATO CON ID [{}] E DATA INIZIO [{}]", cfd.getIdCampionato(), cfd.getDataInizioCampionato());
				}
				if( start == null )
				{
					start = (new DateTime(cfd.getDataInizioCampionato().getTime())).withTimeAtStartOfDay();
				}
				List<Incontro> matches = this.createSchedule(cfd.getFilialiCampionato(), cfd.getIdCampionato(), cfd.getDataInizioCampionato(), creatoDa);
				if( matches != null )
				{
					incontri.addAll(matches);
				}
			}
			if( incontri != null && !incontri.isEmpty() )
			{
				genericDao.persist(incontri);
				//Aggiorno il campionato con la data di chiusura
				List<Long> dateIncontri = new ArrayList<>();
				List<String> idCampionati = new ArrayList<>();

				for (Incontro i : incontri)
				{
					Long dataIncontro = i.getDataIncontro().getTime();
					String idCamp = i.getCampionato().getId();
					if( !dateIncontri.contains(dataIncontro) )
					{
						dateIncontri.add(dataIncontro);
					}
					if( !idCampionati.contains(idCamp) )
					{
						idCampionati.add(idCamp);
					}
				}
				Long ultimoIncontro = Collections.max(dateIncontri);
				Date dataFineCampionato = new Date(ultimoIncontro);
				DateTime fine = (new DateTime(dataFineCampionato.getTime())).withTimeAtStartOfDay();
				DateTime data = new DateTime();
				boolean datiInCampionatoAttivo = new Interval(start, fine).contains(data);
				String hqlAggiornaCampionato = "UPDATE "+Campionato.class.getName()+" SET dataFine = :dataFineCampionato, campionatoAttivo = :campAtt WHERE id in (:idCampionati)";
				Map<String, Object> hqlParams = new HashMap<>();
				hqlParams.put("dataFineCampionato", dataFineCampionato);
				hqlParams.put("campAtt", datiInCampionatoAttivo);
				hqlParams.put("idCampionati", idCampionati);
				genericDao.eseguiHqlStatement(hqlAggiornaCampionato, hqlParams);	
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
	private List<Incontro> createSchedule( List<FilialeDto> filiali, String idCampionato, Date dataInizio, String creatoDa )
	{
		if (filiali.size() % 2 != 0)
		{
			FilialeDto fake = new FilialeDto();
			fake.setId(FAKE_FILIALE_NAME);
			fake.setNomeFiliale(FAKE_FILIALE_NAME);
			filiali.add(fake); // Se dispari aggiungo una filiale fittizia
		}
		List<Incontro> incontri = new ArrayList<Incontro>();
		int numTeams = filiali.size();
		int numDays = (numTeams - 1); // Numero di giorni necessari a completare tutti i match
		int halfSize = numTeams / 2;

		List<FilialeDto> teams = new ArrayList<FilialeDto>();

		teams.addAll(filiali); // Aggiungo alla lista i vari team e rimuovo il primo
		teams.remove(0);

		int teamsSize = teams.size();
		DateTime dataInizioMatch = (new DateTime(dataInizio.getTime())).withTimeAtStartOfDay();
		Campionato c = new Campionato();
		c.setId(idCampionato);
		for (int day = 0; day < numDays; day++)
		{
			DateTime dataMatch = dataInizioMatch.plusDays(7*day);
			int teamIdx = day % teamsSize;
			FilialeDto filialeCasaDto = teams.get(teamIdx);
			FilialeDto filialeFuoriCasaDto = filiali.get(0);
			if( !filialeCasaDto.getNomeFiliale().equals(FAKE_FILIALE_NAME) && !filialeFuoriCasaDto.getNomeFiliale().equals(FAKE_FILIALE_NAME) && !sameFiliale(filialeCasaDto, filialeFuoriCasaDto) )
			{
				Incontro match = new Incontro();
				match.setCreatoDa(creatoDa);
				match.setDataCreazione(new Date());
				match.setCampionato(c);
				match.setDataIncontro(new Date(dataMatch.getMillis()));
				//Filiale che gioca in casa
				Filiale filialeCasa = new Filiale();
				filialeCasa.setId(filialeCasaDto.getId());
				match.setFilialeCasa(filialeCasa);
				//Filiale che gioca fuori casa
				Filiale filialeFuoriCasa = new Filiale();
				filialeFuoriCasa.setId(filialeFuoriCasaDto.getId());
				match.setFilialeFuoriCasa(filialeFuoriCasa);
				if( !incontri.contains(match) )
				{
					incontri.add(match);
				}
			}
			for (int idx = 1; idx < halfSize; idx++)
			{               
				int firstTeam = (day + idx) % teamsSize;
				int secondTeam = (day  + teamsSize - idx) % teamsSize;
				FilialeDto filialeCasaDto2 = teams.get(firstTeam);
				FilialeDto filialeFuoriCasaDto2 = filiali.get(secondTeam);
				if( !filialeCasaDto2.getNomeFiliale().equals(FAKE_FILIALE_NAME) && !filialeFuoriCasaDto2.getNomeFiliale().equals(FAKE_FILIALE_NAME) && !sameFiliale(filialeCasaDto2, filialeFuoriCasaDto2) )
				{
					Incontro match2 = new Incontro();
					Filiale filialeCasa2 = new Filiale();
					filialeCasa2.setId(filialeCasaDto2.getId());
					match2.setFilialeCasa(filialeCasa2);
					//Filiale che gioca fuori casa
					Filiale filialeFuoriCasa2 = new Filiale();
					filialeFuoriCasa2.setId(filialeFuoriCasaDto2.getId());
					match2.setFilialeFuoriCasa(filialeFuoriCasa2);
					match2.setCreatoDa(creatoDa);
					match2.setDataCreazione(new Date());
					match2.setDataIncontro(new Date(dataMatch.getMillis()));
					match2.setCampionato(c);
					if( !incontri.contains(match2) )
					{
						incontri.add(match2);
					}
				}
			}	
		}
		return incontri;
	}
	@PostConstruct
	public void initialize()
	{
		genericDao.setPersistentClass(Incontro.class);
	}
	private boolean sameFiliale( FilialeDto casa, FilialeDto fuoriCasa )
	{
		return casa.equals(fuoriCasa);
	}
}