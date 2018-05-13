package it.olegna.arca.context.service.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.olegna.arca.context.dao.FilialeDao;
import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.service.FilialeManagerSvc;
@Service
public class FilialeMangerSvcImpl implements FilialeManagerSvc
{
	private static final Logger logger = LoggerFactory.getLogger(FilialeMangerSvcImpl.class.getName());
	@Autowired
	private FilialeDao filialeDao;
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

}
