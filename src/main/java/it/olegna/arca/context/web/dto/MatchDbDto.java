package it.olegna.arca.context.web.dto;

import java.io.Serializable;
import java.util.SortedMap;
import java.util.TreeMap;

public class MatchDbDto implements Serializable
{

	private static final long serialVersionUID = -8846318545306595743L;
	private String idFiliale;
	private String nomeFiliale;
	private SortedMap<Long, DatiMatchFilialeDto> dati;
	
	public MatchDbDto()
	{
		super();
		this.dati = new TreeMap<>();
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
	public SortedMap<Long, DatiMatchFilialeDto> getDati()
	{
		return dati;
	}
	public void setDati(SortedMap<Long, DatiMatchFilialeDto> dati)
	{
		this.dati = dati;
	}
	@Override
	public String toString()
	{
		return "MatchDbDto [idFiliale=" + idFiliale + ", nomeFiliale=" + nomeFiliale + ", dati=" + dati + "]";
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dati == null) ? 0 : dati.hashCode());
		result = prime * result + ((idFiliale == null) ? 0 : idFiliale.hashCode());
		result = prime * result + ((nomeFiliale == null) ? 0 : nomeFiliale.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj)
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MatchDbDto other = (MatchDbDto) obj;
		if (dati == null)
		{
			if (other.dati != null)
				return false;
		}
		else if (!dati.equals(other.dati))
			return false;
		if (idFiliale == null)
		{
			if (other.idFiliale != null)
				return false;
		}
		else if (!idFiliale.equals(other.idFiliale))
			return false;
		if (nomeFiliale == null)
		{
			if (other.nomeFiliale != null)
				return false;
		}
		else if (!nomeFiliale.equals(other.nomeFiliale))
			return false;
		return true;
	}
}