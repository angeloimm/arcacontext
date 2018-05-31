package it.olegna.arca.context.web.dto;

import java.io.Serializable;
import java.util.List;
import java.util.SortedMap;
import java.util.concurrent.ConcurrentSkipListMap;

public class IncontroCampionatoDto implements Serializable
{

	private static final long serialVersionUID = 6612497371271783997L;
	private String tipologiaCampionato;
	private SortedMap<Long, List<IncontroDto>> incontiByData;
	
	public IncontroCampionatoDto()
	{
		super();
		incontiByData = new ConcurrentSkipListMap<Long, List<IncontroDto>>();
	}

	public String getTipologiaCampionato()
	{
		return tipologiaCampionato;
	}

	public void setTipologiaCampionato(String tipologiaCampionato)
	{
		this.tipologiaCampionato = tipologiaCampionato;
	}

	public SortedMap<Long, List<IncontroDto>> getIncontiByData()
	{
		return incontiByData;
	}

	public void setIncontiByData(SortedMap<Long, List<IncontroDto>> incontiByData)
	{
		this.incontiByData = incontiByData;
	}

	@Override
	public String toString()
	{
		return "IncontroCampionatoDto [tipologiaCampionato=" + tipologiaCampionato + ", incontiByData=" + incontiByData + "]";
	}

}
