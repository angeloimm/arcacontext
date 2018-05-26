package it.olegna.arca.context.transformers;

import java.util.List;

import org.hibernate.transform.ResultTransformer;

import it.olegna.arca.context.models.Filiale;
@SuppressWarnings(value= {"rawtypes"})
public class CreazioneCampionatiFilialeTransformer implements ResultTransformer
{
	
	private static final long serialVersionUID = 1432798090168522911L;

	public CreazioneCampionatiFilialeTransformer()
	{
		super();
	}

	@Override
	public List transformList(List filiali)
	{
		return filiali;
	}

	@Override
	public Object transformTuple(Object[] valoriResultSet, String[] nomiColonneResultSet)
	{
		Filiale f = new Filiale();
		//Non dovrebbe mai capitare che a questo punto una filiale abbia o ID o nome nulli
		f.setId((String)valoriResultSet[0]);
		f.setNomeFiliale((String)valoriResultSet[1]);
		return f;
	}
}