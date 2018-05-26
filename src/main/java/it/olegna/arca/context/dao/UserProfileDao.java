package it.olegna.arca.context.dao;

import javax.persistence.NoResultException;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import it.olegna.arca.context.models.UserProfile;
@Repository 
public class UserProfileDao<T> extends AbstractDao<String, UserProfile>
{
	@Override
	protected Class<UserProfile> getPersistentClass()
	{
		return UserProfile.class;
	}
	public UserProfile findByType(String type)
	{
		CriteriaBuilder cb = createCriteriaBuilder();
		CriteriaQuery<UserProfile> userProfileQuery = cb.createQuery(UserProfile.class);
		Root<UserProfile> root = userProfileQuery.from(UserProfile.class);
		userProfileQuery.select(root);
		userProfileQuery.where((cb.equal(root.get("type"), type)));
		Query<UserProfile> query = getSession().createQuery(userProfileQuery);
		try
		{
			return query.getSingleResult();
		}
		catch (NoResultException e)
		{
			return null;
		}
	}
}