package it.olegna.arca.context.service.impl;

import static it.olegna.arca.context.util.TimeUtil.formatDateTime;

import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
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
import it.olegna.arca.context.models.CampionatoFiliale;
import it.olegna.arca.context.models.Incontro;
import it.olegna.arca.context.service.GenericSvc;
import it.olegna.arca.context.transformers.ClassificaCampionatoDtoTransformer;
import it.olegna.arca.context.transformers.IncontriCampionatoDtoTransformer;
import it.olegna.arca.context.web.dto.ClassificaCampionatoDto;
import it.olegna.arca.context.web.dto.IncontroCampionatoDto;

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
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public List<ClassificaCampionatoDto> getClassificheCampionatoAttivo() throws ArcaContextDbException
	{
		List<ClassificaCampionatoDto> results = null;
		try
		{
			DetachedCriteria subQuery = DetachedCriteria.forClass(Campionato.class);
			subQuery.add(Property.forName("campionatoAttivo").eq(Boolean.TRUE));
			subQuery.setProjection(Projections.property("id"));
			DetachedCriteria dc = DetachedCriteria.forClass(CampionatoFiliale.class);
			dc.createAlias("pk.campionato", "campionato");
			dc.add(Property.forName("pk.campionato").in(subQuery));
			dc.addOrder(Order.asc("campionato.categoriaCampionato"));
			ProjectionList pl = Projections.projectionList();
			pl.add(Projections.property("pk"),"pk");
			pl.add(Projections.property("puntiFiliale"),"puntiFiliale");
			dc.setProjection(pl);
			dc.setResultTransformer(new ClassificaCampionatoDtoTransformer());
			results = (List<ClassificaCampionatoDto>) this.recuperoDataDao.findByCriteria(dc);
			results.sort(new Comparator<ClassificaCampionatoDto>()
			{

				@Override
				public int compare(ClassificaCampionatoDto o1, ClassificaCampionatoDto o2)
				{
					String tipoCampionato1 = o1.getTipoCampionato();
					String tipoCampionato2 = o2.getTipoCampionato();
					return tipoCampionato1.compareTo(tipoCampionato2);
				}
			});
			return results;
		}
		catch (Exception e)
		{
			String msg = "Errore nel recupero della classifiche; "+e.getMessage();
			if( logger.isErrorEnabled() )
			{
				logger.error(msg, e);
			}
			throw new ArcaContextDbException(msg, e);
		}
	}
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true) 
	public List<IncontroCampionatoDto> getIncontri() throws ArcaContextDbException
	{
		List<IncontroCampionatoDto> results = null;
		try
		{
			DetachedCriteria mainQuery = DetachedCriteria.forClass(Incontro.class);
			mainQuery.createAlias("campionato", "campionato");
			mainQuery.addOrder(Order.asc("dataIncontro"));
			mainQuery.add(Property.forName("campionato.campionatoAttivo").eq(Boolean.TRUE));
			ProjectionList pl = Projections.projectionList();
			pl.add(Projections.property("campionato"), "campionato");
			pl.add(Projections.property("filialeCasa"), "filialeCasa");
			pl.add(Projections.property("filialeFuoriCasa"), "filialeFuoriCasa");
			pl.add(Projections.property("dataIncontro"),"dataIncontro");
			mainQuery.setProjection(pl);
			mainQuery.setResultTransformer(new IncontriCampionatoDtoTransformer());
			results = (List<IncontroCampionatoDto>) this.recuperoDataDao.findByCriteria(mainQuery);
			results.sort(new Comparator<IncontroCampionatoDto>()
			{

				@Override
				public int compare(IncontroCampionatoDto o1, IncontroCampionatoDto o2)
				{
					String tipoCampionato1 = o1.getTipologiaCampionato();
					String tipoCampionato2 = o2.getTipologiaCampionato();
					return tipoCampionato1.compareTo(tipoCampionato2);
				}
			});
			return results;
		}
		catch (Exception e)
		{
			String msg = "Errore nel recupero della classifiche; "+e.getMessage();
			if( logger.isErrorEnabled() )
			{
				logger.error(msg, e);
			}
			throw new ArcaContextDbException(msg, e);
		}
	}
}
