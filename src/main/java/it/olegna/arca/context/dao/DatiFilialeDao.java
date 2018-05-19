package it.olegna.arca.context.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import it.olegna.arca.context.dto.DatiFilialeDto;
import it.olegna.arca.context.models.DatiFiliale;
@Repository 
public class DatiFilialeDao<T> extends AbstractDao<String, DatiFiliale>
{
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