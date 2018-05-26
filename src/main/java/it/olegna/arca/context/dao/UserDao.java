package it.olegna.arca.context.dao;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Hibernate;
import org.springframework.stereotype.Repository;

import it.olegna.arca.context.models.User;
@Repository 
public class UserDao<T> extends AbstractDao<String, User>
{
	@Override
	protected Class<User> getPersistentClass()
	{
		return User.class;
	}
	public User findByUsername(String username)
	{
		CriteriaBuilder cb = createCriteriaBuilder();
		CriteriaQuery<User> userQuery = cb.createQuery(User.class);
		Root<User> root = userQuery.from(User.class);
		userQuery.select(root);
		userQuery.where(cb.equal(root.get("username"), username));
		User user = getSession().createQuery(userQuery).getSingleResult();
		if (user != null)
		{
			Hibernate.initialize(user.getUserProfiles());
		}
		return user;
	}
}