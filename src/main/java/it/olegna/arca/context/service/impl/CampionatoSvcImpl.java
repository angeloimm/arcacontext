package it.olegna.arca.context.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.collections4.ListUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.olegna.arca.context.dao.CampionatoDao;
import it.olegna.arca.context.dao.FilialeDao;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.CampionatoFiliale;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.service.CampionatoSvc;
import it.olegna.arca.context.web.dto.CreazioneCampionatoDto;
import it.olegna.arca.context.web.dto.UserPrincipal;
@Service
public class CampionatoSvcImpl implements CampionatoSvc<Campionato>
{
	private static final Logger logger = LoggerFactory.getLogger(CampionatoSvcImpl.class.getName());
	@Autowired
	private CampionatoDao<Campionato> genericDao;
	@Autowired
	private FilialeDao filialeDao;
	private char[] tipologieCampionato;
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true) 
	public List<Campionato> findByDc(DetachedCriteria dc, int start, int end) throws ArcaContextDbException
	{
		try
		{
			return genericDao.findByDetacheCriteria(dc, start, end);
		}
		catch (Exception e)
		{
			String message = "Errore nella ricerca generica; "+e.getMessage();
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true) 
	public Long countByDc(DetachedCriteria dc) throws ArcaContextDbException
	{
		try
		{
			return genericDao.count(dc).longValue();
		}
		catch (Exception e)
		{
			String message = "Errore nel conteggio generico; "+e.getMessage();
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void salvaEntity(Campionato entity) throws ArcaContextDbException
	{
		try
		{
			genericDao.persist(entity);
		}
		catch (Exception e)
		{
			String message = "Errore nel salvataggio generico dell'entità [{"+entity+"}]; "+e.getMessage();
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
		
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void salvaEntities(List<Campionato> entities) throws ArcaContextDbException
	{
		try
		{
			genericDao.persist(entities);
		}
		catch (Exception e)
		{
			String message = "Errore nel salvataggio generico del campionato [{"+entities+"}]; "+e.getMessage();
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void creaCampionato(CreazioneCampionatoDto dto) throws ArcaContextDbException
	{
		try
		{
			long numeroSquadre = dto.getNumeroSquadre();
			DetachedCriteria dc = DetachedCriteria.forClass(Filiale.class);
			dc.createAlias("datiFiliale", "dt");
			dc.addOrder(Order.desc("dt.totale"));
			List<Filiale> filiali = filialeDao.findByCriteria(dc);
			List<List<Filiale>> subLists = ListUtils.partition(filiali, (int)numeroSquadre);
			DateTime today = (new DateTime()).withTimeAtStartOfDay();
			DateTime start = (new DateTime(dto.getDataInizio())).withTimeAtStartOfDay();
			DateTime fine = (new DateTime(dto.getDataFine())).withTimeAtStartOfDay();
			boolean campionatoAttivo = new Interval(start, fine).contains(today);
			UserPrincipal user = (UserPrincipal)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			int i = 0;
			for (List<Filiale> list : subLists)
			{
				Campionato c = new Campionato();
				c.setCampionatoAttivo(campionatoAttivo);
				c.setCategoriaCampionato(String.valueOf(tipologieCampionato[i]));
				c.setCreatoDa(user.getUsername());
				c.setDataCreazione(new Date());
				c.setDataInizio(new Date(dto.getDataInizio()));
				c.setDataFine(new Date(dto.getDataFine()));
				c.setImportoProduzioneMinima(dto.getProduzioneMinima());
				CampionatoFiliale cf = new CampionatoFiliale();
				cf.setCreatoDa(user.getUsername());
				cf.setDataCreazione(new Date());
				cf.setCampionato(c);
				cf.addFiliali(list);
				c.getCampionati().add(cf);
				genericDao.persist(c);
				i++;
			}
		}
		catch (Exception e)
		{
			String message = "Errore nel salvataggio generico del dto [{"+dto+"}]; "+e.getMessage();
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}
	@PostConstruct
	public void initialize()
	{
		this.tipologieCampionato = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
	}
}