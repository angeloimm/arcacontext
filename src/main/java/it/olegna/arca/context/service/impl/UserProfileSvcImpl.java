package it.olegna.arca.context.service.impl;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.olegna.arca.context.dao.UserProfileDao;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.UserProfile;
import it.olegna.arca.context.service.IUserProfileSvc;

@Service("userProfileService")
public class UserProfileSvcImpl implements IUserProfileSvc {
	private static final Logger logger = LoggerFactory.getLogger(UserProfileSvcImpl.class.getName());
	@Autowired
	private UserProfileDao<UserProfile> dao;
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public UserProfile findById(String id) throws ArcaContextDbException
	{
		try
		{
			return dao.getByKey(id);
		}
		catch (Exception e)
		{
			String msg = "Errore nel recupero profilo utente con ID "+id+"; "+e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public UserProfile findByType(String type) throws ArcaContextDbException
	{
		try
		{
			return dao.findByType(type);
		}
		catch (Exception e)
		{
			String msg = "Errore nel recupero profilo utente con type "+type+"; "+e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public List<UserProfile> findAll() throws ArcaContextDbException
	{
		try
		{
			return dao.findAll();
		}
		catch (Exception e)
		{
			String msg = "Errore nel recupero profili utente; "+e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false)
	public void saveUserProfile(UserProfile userProfile) throws ArcaContextDbException
	{
		try
		{
			dao.persist(userProfile);
		}
		catch (Exception e)
		{
			String msg = "Errore nel salvataggio del profilo utente; "+e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}

	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public Long count() throws ArcaContextDbException
	{
		try
		{
			return dao.count();
		}
		catch (Exception e)
		{
			String msg = "Errore nel conteggio del profilo utente; "+e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}
}