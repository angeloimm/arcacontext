package it.olegna.arca.context.util;

import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.transform.ResultTransformer;

import it.olegna.arca.context.dto.MorrisDataDto;
@SuppressWarnings(value= {"rawtypes", "unused"})
public class MorrisDataTransformer implements ResultTransformer
{
	private MorrisDataDto result;
	
	private static final long serialVersionUID = 1432798090168522911L;

	public MorrisDataTransformer()
	{
		super();
		result = new MorrisDataDto();
	}

	@Override
	public List transformList(List morrisData)
	{
		return Collections.singletonList(result);
	}

	@Override
	public Object transformTuple(Object[] valoriResultSet, String[] nomiColonneResultSet)
	{

		Double re = -1d;
		Double auto = -1d;
		Double totaleReAuto = -1d;
		String nomeFiliale = null;
		Date dataDati = null;
		Long dataDatiLong = 0l;
		if( valoriResultSet[0] != null )
		{
			re = (Double)valoriResultSet[0];
		}
		if( valoriResultSet[1] != null )
		{
			auto = (Double)valoriResultSet[1];
		}
		if( valoriResultSet[2] != null )
		{
			totaleReAuto = (Double)valoriResultSet[2];
		}		
		if( valoriResultSet[3] != null )
		{
			nomeFiliale = (String)valoriResultSet[3];
		}
		if( valoriResultSet[4] != null )
		{
			dataDati = (Date)valoriResultSet[4];
			dataDatiLong = dataDati.getTime();
		}
		List<String> etichette = result.getEtichette();
		List<String> yAxesKeys = result.getYaxesKeys();
		List<Map<String, Object>>data = result.getData();
		if( !etichette.contains(String.valueOf(dataDatiLong)) )
		{
			etichette.add(String.valueOf(dataDatiLong));
		}
		if( !yAxesKeys.contains(nomeFiliale) )
		{
			yAxesKeys.add(nomeFiliale);
		}
		Map<Long, Map<String, Object>> dataContainer = result.getDataContainer();
		Map<String, Object> dati = null;
		if( dataContainer.containsKey(dataDatiLong) )
		{
			dati = dataContainer.get(dataDatiLong);
		}
		else
		{
			dati = new HashMap<>();
		}
		if( !dati.containsKey("dataDati") )
		{
			dati.put("dataDati", dataDatiLong);
		}
		dati.put(nomeFiliale, totaleReAuto);
		dataContainer.put(dataDatiLong, dati);
		return null;
	}
}