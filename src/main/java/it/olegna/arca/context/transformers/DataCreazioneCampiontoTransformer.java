package it.olegna.arca.context.transformers;

import java.util.Date;
import java.util.List;

import org.hibernate.transform.ResultTransformer;

public class DataCreazioneCampiontoTransformer implements ResultTransformer
{

	private static final long serialVersionUID = 1165714447983100162L;

	@Override
	public Object transformTuple(Object[] tuple, String[] aliases)
	{
		Date dataFiliale = (Date)tuple[0];
		return new Long( dataFiliale.getTime() );
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List transformList(List collection)
	{
		return collection;
	}

}
