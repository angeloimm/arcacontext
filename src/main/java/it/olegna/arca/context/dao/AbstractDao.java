package it.olegna.arca.context.dao;
import java.io.Serializable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

public abstract class AbstractDao<PK extends Serializable, T>
{
	protected abstract Class<T> getPersistentClass(); 
	public AbstractDao()
	{
		//this.persistentClass = (Class<T>) ((ParameterizedType) this.getClass().getGenericSuperclass()).getActualTypeArguments()[1];
	}
	public List<T> findAll()
	{
		CriteriaBuilder cb = createCriteriaBuilder();
		CriteriaQuery<T> rootQery = cb.createQuery(getPersistentClass());
		Root<T> rootEntry = rootQery.from(getPersistentClass());
		CriteriaQuery<T> all = rootQery.select(rootEntry);
		TypedQuery<T> allQuery = getSession().createQuery(all);
		return allQuery.getResultList();
	}
	public int eseguiHqlStatement( String hql, Map<String, Object> hqlParams )
	{
		if( !StringUtils.hasText(hql) )
		{
			throw new IllegalArgumentException("Impossibile eseguire lo statement HQL; query nulla o vuota <"+hql+">");
		}
		Query q = getSession().createQuery(hql);
		if( hqlParams != null && !hqlParams.isEmpty() )
		{
			Iterator<String> keys = hqlParams.keySet().iterator();
			while (keys.hasNext())
			{
				String chiave = (String) keys.next();
				q.setParameter(chiave, hqlParams.get(chiave));
			}
		}
		int result = q.executeUpdate();
		return result;
	}
	public Long count()
	{
		CriteriaBuilder qb = createCriteriaBuilder();
		CriteriaQuery<Long> cq = qb.createQuery(Long.class);
		cq.select(qb.count(cq.from(getPersistentClass())));
		return getSession().createQuery(cq).getSingleResult();
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
		return (T) getSession().get(getPersistentClass(), key);
	}
	/**
	 * Il load non effettua la query su DB
	 * @param key -la primary key
	 * @return -l'oggetto proxato da DB
	 */
	public T loadByKey(PK key)
	{
		return (T) getSession().load(getPersistentClass(), key);
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
	public void persist(List<T> entities)
	{
		Session sessione = getSession();
		int i = 0;
		for (T t : entities)
		{
			sessione.persist(t);
			i++;
			if( i%25 == 0 )
			{
				sessione.flush();
				sessione.clear();
			}
		}
	}
}