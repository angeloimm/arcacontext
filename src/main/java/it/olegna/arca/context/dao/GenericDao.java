package it.olegna.arca.context.dao;

import java.io.Serializable;

import org.springframework.stereotype.Repository;
@Repository 
public class GenericDao<T> extends AbstractDao<Serializable, T>
{
	private Class<T> persistentClass;
	@Override
	protected Class<T> getPersistentClass()
	{
		if( persistentClass == null )
		{
			throw new IllegalArgumentException("DOMAIN ENTITY DI HIBERNATE NON SETTATA");
		}
		return persistentClass;
	}
	public void setPersistentClass(Class<T> persistentClass)
	{
		this.persistentClass = persistentClass;
	}
}