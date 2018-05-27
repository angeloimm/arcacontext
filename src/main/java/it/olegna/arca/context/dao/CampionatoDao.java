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
	public int attivaCampionato()
	{
		Date today = new Date();
		String hql = "UPDATE "+Campionato.class.getName()+" SET campionatoAttivo = :campionatoAttivo where dataInizio >= :dataInizio and dataFine <= :dataFine";
		Query q = getSession().createQuery(hql);
		q.setParameter("campionatoAttivo", Boolean.TRUE);
		q.setParameter("dataInizio", today);
		q.setParameter("dataFine", today);
		int result = q.executeUpdate();
		return result;
	}
}