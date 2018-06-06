package it.olegna.arca.context.transformers;

import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;

import org.hibernate.transform.ResultTransformer;

import it.olegna.arca.context.web.dto.DatiMatchFilialeDto;
import it.olegna.arca.context.web.dto.MatchDbDto;
@SuppressWarnings("rawtypes")
public class MatchDbResultTransformers implements ResultTransformer
{

	private static final long serialVersionUID = 3717158207471110318L;
	private Map<String, MatchDbDto> results;
	
	public MatchDbResultTransformers()
	{
		super();
		results = new HashMap<>();
	}

	@Override
	public Object transformTuple(Object[] tuple, String[] aliases)
	{

		String idFiliale = (String)tuple[0];
		String nomeFiliale = (String)tuple[1];
		double reFiliale = 0;
		if( tuple[2] != null )
		{
			reFiliale = (Double)tuple[2];
		}
		double autoFiliale = 0;
		if( tuple[3] != null )
		{
			autoFiliale = (Double)tuple[3];
		}
		double totaleFiliale = 0;
		if( tuple[4] != null )
		{
			totaleFiliale = (Double)tuple[4];
		}
		Date dataDati = (Date)tuple[5];
		Long dataDatiLong = dataDati.getTime();
		MatchDbDto obj = null;
		if( results.containsKey(idFiliale) )
		{
			obj = results.get(idFiliale);
		}
		else
		{
			obj = new MatchDbDto();
			obj.setIdFiliale(idFiliale);
			obj.setNomeFiliale(nomeFiliale);
		}
		SortedMap<Long, DatiMatchFilialeDto> dmfds = obj.getDati();
		DatiMatchFilialeDto dati = null;
		if( dmfds.containsKey(dataDatiLong) )
		{
			dati = dmfds.get(dataDatiLong);
		}
		else
		{
			dati = new DatiMatchFilialeDto();
			dati.setAuto(autoFiliale);
			dati.setDataDati(dataDati);
			dati.setRe(reFiliale);
			dati.setTotale(totaleFiliale);
		}
		dmfds.put(dataDatiLong, dati);
		obj.setDati(dmfds);
		results.put(idFiliale, obj);
		return null;
	}

	
	@Override
	public List transformList(List collection)
	{
		return Collections.emptyList();
	}
	public Map<String, MatchDbDto> getResults()
	{
		return results;
	}
}