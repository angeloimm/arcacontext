package it.olegna.arca.context.dao;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;

public abstract class AbstractDao<PK extends Serializable, T>
{
	private final Class<T> persistentClass;

	@SuppressWarnings("unchecked")
	public AbstractDao()
	{
		this.persistentClass = (Class<T>) ((ParameterizedType) this.getClass().getGenericSuperclass()).getActualTypeArguments()[1];
	}

	@Autowired
	private SessionFactory sessionFactory;

	protected Session getSession()
	{
		return sessionFactory.getCurrentSession();
	}
	@SuppressWarnings("unchecked")
	public List<T> findByDetacheCriteria( DetachedCriteria dc, int offset, int maxRecordNum )
	{
		Session sessione = getSession();
		Criteria crit = dc.getExecutableCriteria(sessione);
		if( offset > -1 && maxRecordNum > -1 )
		{
			crit.setFirstResult(offset);
			crit.setMaxResults(maxRecordNum);
		}
		return crit.list();
	}
	public Number count(DetachedCriteria dc)
	{
		dc.setProjection(Projections.rowCount());
		return (Number)dc.getExecutableCriteria(getSession()).uniqueResult();
	}
	/**
	 * Il get effettua la query su DB
	 * @param key -la primary key
	 * @return -l'oggetto recuperato da DB
	 */
	public T getByKey(PK key)
	{
		return (T) getSession().get(persistentClass, key);
	}
	/**
	 * Il load non effettua la query su DB
	 * @param key -la primary key
	 * @return -l'oggetto proxato da DB
	 */
	public T loadByKey(PK key)
	{
		return (T) getSession().load(persistentClass, key);
	}
	public void persist(T entity)
	{
		getSession().persist(entity);
	}
	public void persistFlush(T entity)
	{
		getSession().persist(entity);
		getSession().flush();
	}
	public void saveOrUpdate(T entity)
	{
		getSession().saveOrUpdate(entity);
	}
	public void update(T entity)
	{
		getSession().update(entity);
	}

	public void delete(T entity)
	{
		getSession().delete(entity);
	}
	@SuppressWarnings("unchecked")
	public List<T> findByCriteria(DetachedCriteria dc)
	{
		Criteria crit = dc.getExecutableCriteria(getSession());
		return crit.list();
	}
	protected CriteriaBuilder createCriteriaBuilder()
	{
		return getSession().getCriteriaBuilder();
	}
}