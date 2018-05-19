package it.olegna.arca.context.service.impl;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import it.olegna.arca.context.dao.UserDao;
import it.olegna.arca.context.dao.UserProfileDao;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.User;
import it.olegna.arca.context.models.UserProfile;
import it.olegna.arca.context.service.IUserSvc;

@Service("userService")
public class UserSvcImpl implements IUserSvc {
	private static final Logger logger = LoggerFactory.getLogger(UserSvcImpl.class.getName());
	@Autowired 
	private UserDao<User> dao;
	@Autowired
	private UserProfileDao<UserProfile> userProfileDao;
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public User findUserById(String id) throws ArcaContextDbException
	{
		try
		{
			return dao.getByKey(id);
		}
		catch (Exception e)
		{
			String msg = "Errore nella ricerca dell'utente con ID " + id + "; " + e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public User findUserByUsername(String username) throws ArcaContextDbException
	{
		try
		{
			return dao.findByUsername(username);
		}
		catch (Exception e)
		{
			String msg = "Errore nella ricerca dell'utente con username " + username + "; " + e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false)
	public void saveUser(User user, List<String> ruoli) throws ArcaContextDbException
	{
		try
		{
			String pwd = user.getPassword();
			if( StringUtils.hasText(pwd) )
			{
				user.setPassword(passwordEncoder.encode(pwd));
			}
			user.getUserProfiles().clear();
			for (String ruolo : ruoli)
			{
				UserProfile up = userProfileDao.findByType(ruolo);
				user.getUserProfiles().add(up);
			}
			dao.persist(user);
		}
		catch (Exception e)
		{
			String msg = "Errore nel salvataggio dell'utente con username " + user.getUsername() + "; " + e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}
	/*
	 * Poiché siamo all'interno di una transazione, non è necessario 
	 * richiamare esplicitamente update. Preleviamo il record dal DB e aggiorniamolo
	 * Quando la transazione termina il record sarà aggiornato
	 */
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false)
	public void updateUser(User user) throws ArcaContextDbException
	{
		try
		{
			User entity = dao.getByKey(user.getId());
			if (entity != null)
			{
				entity.setUsername(user.getUsername());
				if (!user.getPassword().equals(entity.getPassword()))
				{
					entity.setPassword(passwordEncoder.encode(user.getPassword()));
				}
				entity.setNome(user.getNome());
				entity.setCognome(user.getCognome());
				entity.setEmail(user.getEmail());
				entity.setUserProfiles(user.getUserProfiles());
			}
		}
		catch (Exception e)
		{
			String msg = "Errore nell'aggiornamento dell'utente con username " + user.getUsername() + "; " + e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}


	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public boolean isUsernameUnique(String id, String username) throws ArcaContextDbException
	{
		try
		{
			User user = dao.findByUsername(username);
			return ( user == null || ((id != null) && (user.getId() == id)));
		}
		catch (Exception e)
		{
			String msg = "Errore nel controllo univocità della username; " + e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public Long countUsers() throws ArcaContextDbException
	{
		try
		{
			DetachedCriteria dc = DetachedCriteria.forClass(User.class);
			dc.setProjection(Projections.rowCount());
			return dao.count(dc).longValue();
		}
		catch (Exception e)
		{
			String msg = "Errore nel conteggio degli utenti; " + e.getMessage();
			logger.error(msg, e);
			throw new ArcaContextDbException(msg, e);
		}
	}
}