package it.olegna.arca.context.dao;


import java.util.Date;

import javax.persistence.Query;

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
	public int terminaCampionati()
	{
		Date today = new Date();
		String hql = "UPDATE "+Campionato.class.getName()+" SET campionatoAttivo = :campionatoAttivo where dataFine <= :oggi";
		Query q = getSession().createQuery(hql);
		q.setParameter("campionatoAttivo", Boolean.FALSE);
		q.setParameter("oggi", today);
		int result = q.executeUpdate();
		return result;
	}
	public int attivaCampionati()
	{
		Date today = new Date();
		String hql = "UPDATE "+Campionato.class.getName()+" SET campionatoAttivo = :campionatoAttivo where dataInizio <= :oggi and dataFine > :oggi";
		Query q = getSession().createQuery(hql);
		q.setParameter("campionatoAttivo", Boolean.TRUE);
		q.setParameter("oggi", today);
		int result = q.executeUpdate();
		return result;
	}
}