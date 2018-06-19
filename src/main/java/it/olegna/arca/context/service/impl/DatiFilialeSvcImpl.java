package it.olegna.arca.context.service.impl;

import java.util.Collections;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.transform.Transformers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.olegna.arca.context.dao.DatiFilialeDao;
import it.olegna.arca.context.dto.DataTableResponse;
import it.olegna.arca.context.dto.DatiFilialeDto;
import it.olegna.arca.context.dto.MorrisDataDto;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.DatiFiliale;
import it.olegna.arca.context.service.DatiFilialeSvc;
@Service
public class DatiFilialeSvcImpl implements DatiFilialeSvc
{
	private static final Logger logger = LoggerFactory.getLogger(DatiFilialeSvcImpl.class.getName());
	@Autowired
	private DatiFilialeDao<DatiFiliale> datiFilialeDao;
	@Autowired
	private DatiFilialeDao<MorrisDataDto> datiFilialeMorrisDataDao;	
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public List<DatiFilialeDto> ricercaDatiFiliali(DetachedCriteria dc) throws ArcaContextDbException
	{
		try
		{
			return datiFilialeDao.findDtoDetacheCriteria(dc, -1, -1);
		}
		catch (Exception e)
		{
			String message = "Errore nel recupero dati filiale";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public List<MorrisDataDto> ricercaMorrisDatiFiliali(DetachedCriteria dc) throws ArcaContextDbException
	{
		try
		{
			return datiFilialeMorrisDataDao.findGenericDetacheCriteria(dc, -1, -1);
		}
		catch (Exception e)
		{
			String message = "Errore nel recupero dati filiale";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true) 
	public DataTableResponse<DatiFilialeDto> ricercaDatiFilialiDto(String idFiliale, int start, int end) throws ArcaContextDbException
	{
		DetachedCriteria dc = DetachedCriteria.forClass(DatiFiliale.class);
		dc.createAlias("filiale", "filiale");
		dc.add(Property.forName("filiale.id").eq(idFiliale));
		ProjectionList pl = Projections.projectionList();
		pl.add(Projections.property("re"), "re");
		pl.add(Projections.property("auto"), "auto");
		pl.add(Projections.property("totale"), "totaleReAuto");
		pl.add(Projections.property("filiale.nomeFiliale"), "nomeFiliale");
		pl.add(Projections.property("dataDati"), "dataDati");
		dc.setProjection(pl);
		dc.setResultTransformer(Transformers.aliasToBean(DatiFilialeDto.class));
		dc.addOrder(Order.desc("dataDati"));
		DetachedCriteria dcCoun = DetachedCriteria.forClass(DatiFiliale.class);
		dcCoun.createAlias("filiale", "filiale");
		dcCoun.add(Property.forName("filiale.id").eq(idFiliale));
		List<DatiFilialeDto> datiFiliale = null;
		long oggettiTotali = (datiFilialeDao.count(dcCoun)).longValue();
		if( oggettiTotali == 0 )
		{
			datiFiliale = Collections.emptyList();
		}
		else
		{
			datiFiliale = datiFilialeDao.findDtoDetacheCriteria(dc, start, end);
		}
		DataTableResponse<DatiFilialeDto> result = new DataTableResponse<>();
		result.setPayload(datiFiliale);
		result.setEsitoOperazione(HttpStatus.OK.value());
		result.setDescrizioneOperazione("Recupero dati filiali OK");
		result.setRecordsTotal(oggettiTotali);
		result.setRecordsFiltered(oggettiTotali);
		result.setNumeroOggettiRestituiti(datiFiliale.size());
		result.setNumeroOggettiTotali(oggettiTotali);
		return result;
	}
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public Long contaDatiFiliale() throws ArcaContextDbException
	{
		try
		{
			return datiFilialeMorrisDataDao.count();
		}
		catch (Exception e)
		{
			String message = "Errore nel conteggio dati filiale";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public List<Long> datePossibiliCreazioneCampionato() throws ArcaContextDbException
	{
		try
		{
			return this.datiFilialeDao.dataCreazioneCampionato();
		}
		catch (Exception e)
		{
			String message = "Errore nel conteggio dati filiale";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}	
}
