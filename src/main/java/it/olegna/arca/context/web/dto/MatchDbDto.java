package it.olegna.arca.context.web.dto;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class MatchDbDto implements Serializable
{

	private static final long serialVersionUID = -8846318545306595743L;
	private String idFiliale;
	private String nomeFiliale;
	private Map<Long, DatiMatchFilialeDto> dati;
	
	public MatchDbDto()
	{
		super();
		this.dati = new HashMap<>();
	}
	public String getIdFiliale()
	{
		return idFiliale;
	}
	public void setIdFiliale(String idFiliale)
	{
		this.idFiliale = idFiliale;
	}
	public String getNomeFiliale()
	{
		return nomeFiliale;
	}
	public void setNomeFiliale(String nomeFiliale)
	{
		this.nomeFiliale = nomeFiliale;
	}
	public Map<Long, DatiMatchFilialeDto> getDati()
	{
		return dati;
	}
	public void setDati(Map<Long, DatiMatchFilialeDto> dati)
	{
		this.dati = dati;
	}
	@Override
	public String toString()
	{
		return "MatchDbDto [idFiliale=" + idFiliale + ", nomeFiliale=" + nomeFiliale + ", dati=" + dati + "]";
	}
}