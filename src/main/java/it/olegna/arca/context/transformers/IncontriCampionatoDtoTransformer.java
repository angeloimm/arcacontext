package it.olegna.arca.context.transformers;

import static it.olegna.arca.context.util.TimeUtil.formatDateTime;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;

import org.hibernate.transform.ResultTransformer;
import org.joda.time.DateTime;

import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.web.dto.IncontroCampionatoDto;
import it.olegna.arca.context.web.dto.IncontroDto;

public class IncontriCampionatoDtoTransformer implements ResultTransformer
{

	private static final long serialVersionUID = -8670841633374877496L;
	private Map<String, IncontroCampionatoDto> results = new HashMap<String, IncontroCampionatoDto>();
	@Override
	public Object transformTuple(Object[] tuple, String[] aliases)
	{

		Campionato c = (Campionato)tuple[0];
		Filiale filialeCasa = (Filiale)tuple[1];
		Filiale filialeFuoriCasa = (Filiale)tuple[2];
		Date dataIncontro = (Date)tuple[3];
		String tipoCampionato = c.getCategoriaCampionato();
		IncontroCampionatoDto incontroCampionato = null;
		if( results.containsKey(tipoCampionato) )
		{
			incontroCampionato = results.get(tipoCampionato);
		}
		else
		{
			incontroCampionato = new IncontroCampionatoDto();
			incontroCampionato.setTipologiaCampionato(tipoCampionato);
		}
		Long timeMillis = dataIncontro.getTime();
		SortedMap<Long, List<IncontroDto>> incontriByDate = incontroCampionato.getIncontiByData();
		List<IncontroDto> incontri = null;
		if( incontriByDate.containsKey(timeMillis) )
		{
			incontri = incontriByDate.get(timeMillis);
		}
		else
		{
			incontri = new ArrayList<IncontroDto>();
		}
		IncontroDto incontro = new IncontroDto();
		incontro.setDataIncontro(formatDateTime((new DateTime(timeMillis)), "dd/MM/yyyy"));
		FilialeDto filialeCasaDto = new FilialeDto();
		filialeCasaDto.setId(filialeCasa.getId());
		filialeCasaDto.setNomeFiliale(filialeCasa.getNomeFiliale());
		incontro.setFilialeCasa(filialeCasaDto);
		FilialeDto filialeFuoriCasaDto = new FilialeDto();
		filialeFuoriCasaDto.setId(filialeFuoriCasa.getId());
		filialeFuoriCasaDto.setNomeFiliale(filialeFuoriCasa.getNomeFiliale());
		incontro.setFilialeFuoriCasa(filialeFuoriCasaDto);
		incontri.add(incontro);
		incontriByDate.put(timeMillis, incontri);
		incontroCampionato.setIncontiByData(incontriByDate);
		results.put(tipoCampionato, incontroCampionato);
		return null;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List transformList(List collection)
	{
		return new ArrayList<IncontroCampionatoDto>(results.values());
	}

}
