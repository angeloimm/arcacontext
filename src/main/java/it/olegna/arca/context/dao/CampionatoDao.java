package it.olegna.arca.context.dao;

import org.springframework.stereotype.Repository;

import it.olegna.arca.context.models.Campionato;
@Repository 
public class CampionatoDao<T> extends AbstractDao<String, Campionato>
{

	@Override
	protected Class<Campionato> getPersistentClass()
	{
		return Campionato.class;
	}

}