package it.olegna.arca.context.service.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.olegna.arca.context.dao.GenericDao;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.service.GenericSvc;
import static it.olegna.arca.context.util.TimeUtil.formatDateTime;

@Service
public class GenericSvcImpl<T> implements GenericSvc<T>
{
	private static final Logger logger = LoggerFactory.getLogger(GenericSvcImpl.class.getName());
	@Autowired
	private GenericDao<T> recuperoDataDao;
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true) 
	public long getDataProssimoCampionato() throws ArcaContextDbException
	{
		try
		{
			Date now = new Date();
			DetachedCriteria dc = DetachedCriteria.forClass(Campionato.class);
			dc.setProjection(Projections.max("dataFine"));
			dc.add(Property.forName("dataFine").gt(now));
			List<Date> results = (List<Date>) recuperoDataDao.findByCriteria(dc);
			if( results == null || results.isEmpty() )
			{
				if( logger.isInfoEnabled() )
				{
					logger.info("Trovato nessun campionato con data fine maggiore della data odierna [{}]", now);
				}
				return now.getTime();
			}
			else if( results.size() > 1 )
			{
				throw new IllegalStateException("Trovate "+results.size()+" date massime. Impossibile proseguire");
			}
			Date dataFine = results.get(0);
			if( dataFine == null )
			{
				if( logger.isInfoEnabled() )
				{
					logger.info("Trovato nessun campionato con data fine maggiore della data odierna [{}]", now);
				}
				return now.getTime();
			}
			if( logger.isInfoEnabled() )
			{
				String oggi = formatDateTime(new DateTime(now.getTime()), "dd/MM/yyyy");
				String dataFineStr = formatDateTime(new DateTime(dataFine.getTime()), "dd/MM/yyyy");
				logger.info("Trovato campionato con data fine [{}] maggiore della data odierna [{}]",dataFineStr, oggi);
			}
			return dataFine.getTime();
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
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true) 
	public boolean esisteCampionatoAttivo() throws ArcaContextDbException
	{
		try
		{
			
			DetachedCriteria dc = DetachedCriteria.forClass(Campionato.class);
			dc.add(Property.forName("campionatoAttivo").eq(Boolean.TRUE));
			long results = recuperoDataDao.count(dc).longValue();
			if( logger.isInfoEnabled() )
			{
				logger.info("Trovati [{}] campionati attivi", results);
			}
			return results > 0;
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
}
