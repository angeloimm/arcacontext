package it.olegna.arca.context.service.impl;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.transform.Transformers;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import it.olegna.arca.context.dao.DatiFilialeDao;
import it.olegna.arca.context.dao.FilialeDao;
import it.olegna.arca.context.dto.DataTableResponse;
import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.DatiFiliale;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.service.FilialeManagerSvc;
import it.olegna.arca.context.util.TimeUtil;
@Service
public class FilialeMangerSvcImpl implements FilialeManagerSvc
{
	private static final Logger logger = LoggerFactory.getLogger(FilialeMangerSvcImpl.class.getName());
	@Autowired
	private FilialeDao filialeDao;
	@Autowired
	private DatiFilialeDao<DatiFiliale> datiFilialeDao;
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void salvaAggiornaFiliale(Filiale filiale) throws ArcaContextDbException
	{
		try
		{
			filialeDao.saveOrUpdate(filiale);
		}
		catch (Exception e)
		{
			String message = "Errore nel salvataggio della filiale ["+filiale+"]";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public List<FilialeDto> ricercaFiliali(DetachedCriteria dc) throws ArcaContextDbException
	{
		try
		{
			return filialeDao.findByDtoDetacheCriteria(dc, -1, -1);
		}
		catch (Exception e)
		{
			String message = "Errore nel recupero delle filiali";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public Filiale ricercaFilialeByName(String name) throws ArcaContextDbException
	{
		if(!StringUtils.hasText(name))
		{
			throw new IllegalArgumentException("Passato nome filiale nullo o vuoto");
		}
		try
		{
			return getByName(name);
		}
		catch (Exception e)
		{
			String message = "Errore nel recupero delle filiali";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}
	private Filiale getByName(String name)
	{
		DetachedCriteria dc = DetachedCriteria.forClass(Filiale.class);
		dc.add(Property.forName("nomeFiliale").eq(name.trim()).ignoreCase());
		List<Filiale> filiali = filialeDao.findByCriteria(dc);
		if( filiali == null || filiali.isEmpty() )
		{
			return null;
		}
		if( filiali.size() > 1 )
		{
			throw new IllegalStateException("Impossibile proseguire. Trovate "+filiali.size()+" con nome "+name+"");
		}
		return filiali.get(0);
	}
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void salvaAggiornaFilialeAndDati(List<Filiale> filiali, Date dataDati) throws ArcaContextDbException
	{
		try
		{
			//Controllo se esistono dati per quella data. Se cosi' li cancello
			if( datiFilialeDao.datiEsistentiByDate(dataDati) )
			{
				
				int datiCancellati = datiFilialeDao.deleteByDate(dataDati);
				if( logger.isWarnEnabled() )
				{
					logger.warn("PER LA DATA {} ERANO GIA' PRESENTI DEI DATI. CANCELLATI {} DATI", TimeUtil.formatDateTime(new DateTime(dataDati.getTime()), "dd/MM/yyyy"), datiCancellati);
				}
			}

			for (Filiale filiale : filiali)
			{
				Filiale f = getByName(filiale.getNomeFiliale()); 
				if( f != null )
				{
					Set<DatiFiliale> datiFiliale = filiale.getDatiFiliale();
					for (DatiFiliale df : datiFiliale)
					{
						df.setFiliale(f);
						datiFilialeDao.persist(df);
					}
				}
				else
				{
					Set<DatiFiliale> datiFiliale = filiale.getDatiFiliale();
					filiale.setDatiFiliale(new HashSet<DatiFiliale>(0));
					filialeDao.persist(filiale);
					for (DatiFiliale df : datiFiliale)
					{
						df.setFiliale(filiale);
						datiFilialeDao.persist(df);
					}
				}
			}
		}
		catch (Exception e)
		{
			String message = "Errore nel salvataggio delle filiali";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}

	}
	
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true) 
	public DataTableResponse<FilialeDto> ricercaElencoFiliali(String filtroRicerca, int start, int end) throws ArcaContextDbException
	{
		
		ProjectionList pl = Projections.projectionList();
		pl.add(Projections.property("nomeFiliale"), "nomeFiliale");
		pl.add(Projections.property("id"),"id");
		DetachedCriteria dcCoun = DetachedCriteria.forClass(Filiale.class);
		if( StringUtils.hasText(filtroRicerca) )
		{
			dcCoun.add(Property.forName("nomeFiliale").like(filtroRicerca, MatchMode.START).ignoreCase());
		}
		long oggettiTotali = (filialeDao.count(dcCoun)).longValue();
		DetachedCriteria dc = DetachedCriteria.forClass(Filiale.class);
		dc.setProjection(pl);
		dc.addOrder(Order.desc("nomeFiliale"));
		dc.setResultTransformer(Transformers.aliasToBean(FilialeDto.class));
		if( StringUtils.hasText(filtroRicerca) )
		{
			dc.add(Property.forName("nomeFiliale").like(filtroRicerca, MatchMode.START).ignoreCase());
		}
		List<FilialeDto> filiali = filialeDao.findByDtoDetacheCriteria(dc, start, end);
		if( filiali == null || filiali.isEmpty() )
		{
			return null;
		}
		DataTableResponse<FilialeDto> result = new DataTableResponse<FilialeDto>();
		result.setPayload(filiali);
		result.setEsitoOperazione(HttpStatus.OK.value());
		result.setDescrizioneOperazione("Recupero filiali OK");
		result.setRecordsTotal(oggettiTotali);
		return result;
	}	

}
