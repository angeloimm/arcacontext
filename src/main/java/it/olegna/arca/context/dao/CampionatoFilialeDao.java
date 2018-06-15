package it.olegna.arca.context.dao;


import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.springframework.stereotype.Repository;

import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.CampionatoFiliale;
import it.olegna.arca.context.models.CampionatoFilialeId;
import it.olegna.arca.context.models.Filiale;
@Repository 
public class CampionatoFilialeDao extends AbstractDao<CampionatoFilialeId, CampionatoFiliale>
{

	@Override
	protected Class<CampionatoFiliale> getPersistentClass()
	{
		return CampionatoFiliale.class;
	}
	public void aggiornaPuntiFiliale( Campionato c, Filiale f, int punti ) throws Exception
	{

		CampionatoFilialeId key = new CampionatoFilialeId();
		key.setCampionato(c);
		key.setFiliale(f);
		DetachedCriteria dc = DetachedCriteria.forClass(CampionatoFiliale.class);
		dc.add(Property.forName("pk").eq(key));
		Session sessione = getSession();
		Criteria crit = dc.getExecutableCriteria(sessione);
		CampionatoFiliale cf = (CampionatoFiliale) crit.list().get(0);
		//CampionatoFiliale cf = getByKey(key);
		int puntiIniziali = cf.getPuntiFiliale();
		int puntiFinali = puntiIniziali+punti;
		cf.setPuntiFiliale(puntiFinali);
		update(cf);
	}
}