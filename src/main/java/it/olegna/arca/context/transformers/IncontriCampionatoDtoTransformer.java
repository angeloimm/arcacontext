package it.olegna.arca.context.transformers;

import static it.olegna.arca.context.util.TimeUtil.DATA_FINE_KEY;
import static it.olegna.arca.context.util.TimeUtil.DATA_INIZIO_KEY;
import static it.olegna.arca.context.util.TimeUtil.formatDateTime;
import static it.olegna.arca.context.util.TimeUtil.toDateTime;
import static it.olegna.arca.context.util.TimeUtil.recuperaSettimanaIncontro;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;

import org.hibernate.transform.ResultTransformer;
import org.joda.time.DateTime;

import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.DatiFiliale;
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
		Map<String, Long> settimanaIncontro = recuperaSettimanaIncontro( formatDateTime((new DateTime(timeMillis)), "dd/MM/yyyy") );
		incontro.setInizioSettimana(settimanaIncontro.get(DATA_INIZIO_KEY));
		incontro.setFineSettimana(settimanaIncontro.get(DATA_FINE_KEY));
		incontro.setDataIncontro(formatDateTime(toDateTime(timeMillis), "dd/MM/yyyy"));
		FilialeDto filialeCasaDto = new FilialeDto();
		filialeCasaDto.setImportoSettimanaleFiliale(recuperaImporto(dataIncontro, filialeCasa));
		filialeCasaDto.setId(filialeCasa.getId());
		filialeCasaDto.setNomeFiliale(filialeCasa.getNomeFiliale());
		incontro.setFilialeCasa(filialeCasaDto);
		FilialeDto filialeFuoriCasaDto = new FilialeDto();
		filialeFuoriCasaDto.setId(filialeFuoriCasa.getId());
		filialeFuoriCasaDto.setNomeFiliale(filialeFuoriCasa.getNomeFiliale());
		filialeFuoriCasaDto.setImportoSettimanaleFiliale(recuperaImporto(dataIncontro, filialeFuoriCasa));
		incontro.setFilialeFuoriCasa(filialeFuoriCasaDto);
		incontri.add(incontro);
		incontriByDate.put(timeMillis, incontri);
		incontroCampionato.setIncontiByData(incontriByDate);
		results.put(tipoCampionato, incontroCampionato);
		return null;
	}
	private double recuperaImporto( Date data, Filiale f )
	{
		Set<DatiFiliale> df = f.getDatiFiliale();
		for (DatiFiliale datiFiliale : df)
		{
			if( datiFiliale.getDataDati().equals(data) )
			{
				return datiFiliale.getTotale();
			}
		}
		return 0.0d;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List transformList(List collection)
	{
		return new ArrayList<IncontroCampionatoDto>(results.values());
	}

}
