package it.olegna.arca.context.models;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.ManyToOne;

@Embeddable
public class CampionatoFilialeId implements Serializable
{

	private static final long serialVersionUID = 7666790361552134935L;
	private Filiale filiale;
	private Campionato campionato;
	@ManyToOne
	public Filiale getFiliale()
	{
		return filiale;
	}
	public void setFiliale(Filiale filiale)
	{
		this.filiale = filiale;
	}
	@ManyToOne
	public Campionato getCampionato()
	{
		return campionato;
	}
	public void setCampionato(Campionato campionato)
	{
		this.campionato = campionato;
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((campionato == null) ? 0 : campionato.hashCode());
		result = prime * result + ((filiale == null) ? 0 : filiale.hashCode());
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
		CampionatoFilialeId other = (CampionatoFilialeId) obj;
		if (campionato == null)
		{
			if (other.campionato != null)
				return false;
		}
		else if (!campionato.equals(other.campionato))
			return false;
		if (filiale == null)
		{
			if (other.filiale != null)
				return false;
		}
		else if (!filiale.equals(other.filiale))
			return false;
		return true;
	}
}