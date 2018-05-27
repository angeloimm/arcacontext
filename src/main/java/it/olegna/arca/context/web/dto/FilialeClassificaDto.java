package it.olegna.arca.context.web.dto;

import java.io.Serializable;

public class FilialeClassificaDto implements Serializable
{
	private static final long serialVersionUID = -7508255513756980068L;
	private String nomeFiliale;
	private int puntiFiliale;
	public String getNomeFiliale()
	{
		return nomeFiliale;
	}
	public void setNomeFiliale(String nomeFiliale)
	{
		this.nomeFiliale = nomeFiliale;
	}
	public int getPuntiFiliale()
	{
		return puntiFiliale;
	}
	public void setPuntiFiliale(int puntiFiliale)
	{
		this.puntiFiliale = puntiFiliale;
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((nomeFiliale == null) ? 0 : nomeFiliale.hashCode());
		result = prime * result + puntiFiliale;
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
		FilialeClassificaDto other = (FilialeClassificaDto) obj;
		if (nomeFiliale == null)
		{
			if (other.nomeFiliale != null)
				return false;
		}
		else if (!nomeFiliale.equals(other.nomeFiliale))
			return false;
		if (puntiFiliale != other.puntiFiliale)
			return false;
		return true;
	}
	@Override
	public String toString()
	{
		return "FilialeDto [nomeFiliale=" + nomeFiliale + ", puntiFiliale=" + puntiFiliale + "]";
	}
	
}