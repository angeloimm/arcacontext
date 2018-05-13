package it.olegna.arca.context.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.models.Filiale;
@Repository 
public class FilialeDao extends AbstractDao<String, Filiale>
{
	@SuppressWarnings("unchecked")
	public List<FilialeDto> findByDtoDetacheCriteria( DetachedCriteria dc, int offset, int maxRecordNum )
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