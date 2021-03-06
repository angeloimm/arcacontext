package it.olegna.arca.context.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.springframework.stereotype.Repository;

import it.olegna.arca.context.dto.DatiFilialeDto;
import it.olegna.arca.context.models.DatiFiliale;
import it.olegna.arca.context.transformers.DataCreazioneCampiontoTransformer;
@Repository 
public class DatiFilialeDao<T> extends AbstractDao<String, DatiFiliale>
{
	@Override
	protected Class<DatiFiliale> getPersistentClass()
	{
		return DatiFiliale.class;
	}
	public boolean datiEsistentiByDate(Date data)
	{
		DetachedCriteria dc = DetachedCriteria.forClass(DatiFiliale.class);
		dc.add(Property.forName("dataDati").eq(data));
		boolean datiEsistenti = count(dc).longValue() > 0;
		return datiEsistenti;
	}
	@SuppressWarnings("unchecked")
	public List<Long> dataCreazioneCampionato()
	{
		DetachedCriteria dc = DetachedCriteria.forClass(DatiFiliale.class);
		ProjectionList pl = Projections.projectionList();
		pl.add(Projections.distinct(Projections.property("dataDati")));
		dc.setProjection(pl);
		dc.addOrder(Order.asc("dataDati"));
		dc.setResultTransformer(new DataCreazioneCampiontoTransformer());
		Session sessione = getSession();
		Criteria crit = dc.getExecutableCriteria(sessione);
		return crit.list();
	}
	public int deleteByDate(Date data)
	{
		String hql = "DELETE it.olegna.arca.context.models.DatiFiliale WHERE dataDati= :dataDati";
		Query query = getSession().createQuery(hql);
		query.setParameter("dataDati", data);
		return query.executeUpdate();
	}
	@SuppressWarnings("unchecked")
	public List<DatiFilialeDto> findDtoDetacheCriteria( DetachedCriteria dc, int offset, int maxRecordNum )
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
	@SuppressWarnings("unchecked")
	public List<T> findGenericDetacheCriteria( DetachedCriteria dc, int offset, int maxRecordNum )
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
}