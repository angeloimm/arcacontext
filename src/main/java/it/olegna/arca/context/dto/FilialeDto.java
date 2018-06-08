package it.olegna.arca.context.dto;

import java.io.Serializable;
import java.util.List;

public class FilialeDto implements Serializable
{

	private static final long serialVersionUID = -3846226846964324382L;
	private String nomeFiliale;
	private String id;
	private double importoSettimanaleFiliale;
	private List<DatiFilialeDto> datiFiliale;
	
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
	public List<DatiFilialeDto> getDatiFiliale()
	{
		return datiFiliale;
	}
	public void setDatiFiliale(List<DatiFilialeDto> datiFiliale)
	{
		this.datiFiliale = datiFiliale;
	}
	public String getNomeFiliale()
	{
		return nomeFiliale;
	}
	public void setNomeFiliale(String nomeFiliale)
	{
		this.nomeFiliale = nomeFiliale;
	}
	public double getImportoSettimanaleFiliale()
	{
		return importoSettimanaleFiliale;
	}
	public void setImportoSettimanaleFiliale(double importoSettimanaleFiliale)
	{
		this.importoSettimanaleFiliale = importoSettimanaleFiliale;
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((datiFiliale == null) ? 0 : datiFiliale.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		long temp;
		temp = Double.doubleToLongBits(importoSettimanaleFiliale);
		result = prime * result + (int) (temp ^ (temp >>> 32));
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
		FilialeDto other = (FilialeDto) obj;
		if (datiFiliale == null)
		{
			if (other.datiFiliale != null)
				return false;
		}
		else if (!datiFiliale.equals(other.datiFiliale))
			return false;
		if (id == null)
		{
			if (other.id != null)
				return false;
		}
		else if (!id.equals(other.id))
			return false;
		if (Double.doubleToLongBits(importoSettimanaleFiliale) != Double.doubleToLongBits(other.importoSettimanaleFiliale))
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
	@Override
	public String toString()
	{
		return "FilialeDto [nomeFiliale=" + nomeFiliale + ", id=" + id + ", importoSettimanaleFiliale=" + importoSettimanaleFiliale + ", datiFiliale=" + datiFiliale + "]";
	}
}