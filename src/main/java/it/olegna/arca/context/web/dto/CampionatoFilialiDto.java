package it.olegna.arca.context.web.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import it.olegna.arca.context.dto.FilialeDto;

public class CampionatoFilialiDto implements Serializable
{

	private static final long serialVersionUID = -5476436123191819446L;
	private String idCampionato;
	private Date dataInizioCampionato;
	private List<FilialeDto> filialiCampionato;
	public String getIdCampionato()
	{
		return idCampionato;
	}
	public void setIdCampionato(String idCampionato)
	{
		this.idCampionato = idCampionato;
	}
	public List<FilialeDto> getFilialiCampionato()
	{
		return filialiCampionato;
	}
	public void setFilialiCampionato(List<FilialeDto> filialiCampionato)
	{
		this.filialiCampionato = filialiCampionato;
	}
	public Date getDataInizioCampionato()
	{
		return dataInizioCampionato;
	}
	public void setDataInizioCampionato(Date dataInizioCampionato)
	{
		this.dataInizioCampionato = dataInizioCampionato;
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dataInizioCampionato == null) ? 0 : dataInizioCampionato.hashCode());
		result = prime * result + ((filialiCampionato == null) ? 0 : filialiCampionato.hashCode());
		result = prime * result + ((idCampionato == null) ? 0 : idCampionato.hashCode());
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
		CampionatoFilialiDto other = (CampionatoFilialiDto) obj;
		if (dataInizioCampionato == null)
		{
			if (other.dataInizioCampionato != null)
				return false;
		}
		else if (!dataInizioCampionato.equals(other.dataInizioCampionato))
			return false;
		if (filialiCampionato == null)
		{
			if (other.filialiCampionato != null)
				return false;
		}
		else if (!filialiCampionato.equals(other.filialiCampionato))
			return false;
		if (idCampionato == null)
		{
			if (other.idCampionato != null)
				return false;
		}
		else if (!idCampionato.equals(other.idCampionato))
			return false;
		return true;
	}
	@Override
	public String toString()
	{
		return "CampionatoFilialiDto [idCampionato=" + idCampionato + ", dataInizioCampionato=" + dataInizioCampionato + ", filialiCampionato=" + filialiCampionato + "]";
	}
}