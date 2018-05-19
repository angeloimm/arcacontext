package it.olegna.arca.context.service.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.olegna.arca.context.dao.DatiFilialeDao;
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

}
