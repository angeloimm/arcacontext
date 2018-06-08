package it.olegna.arca.context.transformers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.transform.ResultTransformer;

import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.CampionatoFiliale;
import it.olegna.arca.context.models.CampionatoFilialeId;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.web.dto.ClassificaCampionatoDto;
import it.olegna.arca.context.web.dto.FilialeClassificaDto;

public class ClassificaCampionatoDtoTransformer implements ResultTransformer
{
	private Map<String, ClassificaCampionatoDto> results;
	private static final long serialVersionUID = 5684143284564107449L;

	public ClassificaCampionatoDtoTransformer()
	{
		super();
		results = new HashMap<String, ClassificaCampionatoDto>();
	}

	@Override
	public Object transformTuple(Object[] tuple, String[] aliases)
	{
		if( tuple == null || tuple.length < 2 )
		{
			return null;
		}
		ClassificaCampionatoDto result = null;
		CampionatoFilialeId cf = (CampionatoFilialeId)tuple[0];
		Campionato camp = cf.getCampionato();
		Filiale f = cf.getFiliale();
		int puntiFiliale = (Integer)tuple[1];
		if( this.results.containsKey(camp.getId()) )
		{
			result = results.get(camp.getId());
		}
		else
		{
			result = new ClassificaCampionatoDto();
		}
		result.setTipoCampionato(camp.getCategoriaCampionato());
		List<FilialeClassificaDto> filiali = result.getFilaliCampionato();
		if( filiali == null )
		{
			filiali = new ArrayList<>();
		}
		FilialeClassificaDto fcd = new FilialeClassificaDto();
		fcd.setNomeFiliale(f.getNomeFiliale());
		fcd.setPuntiFiliale(puntiFiliale);
		filiali.add(fcd);
		result.setFilaliCampionato(filiali);
		results.put(camp.getId(), result);
		return null;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List transformList(List collection)
	{
		return new ArrayList<ClassificaCampionatoDto>(this.results.values());
	}

}
