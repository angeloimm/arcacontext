package it.olegna.arca.context.web.dto;

import java.io.Serializable;
import java.util.Comparator;
import java.util.List;

public class ClassificaCampionatoDto implements Serializable
{
	private static final long serialVersionUID = 2577973303544268829L;
	private String tipoCampionato;
	private List<FilialeClassificaDto> filaliCampionato;
	public String getTipoCampionato()
	{
		return tipoCampionato;
	}
	public void setTipoCampionato(String tipoCampionato)
	{
		this.tipoCampionato = tipoCampionato;
	}
	public List<FilialeClassificaDto> getFilaliCampionato()
	{
		if(this.filaliCampionato == null)
		{
			return filaliCampionato;
		}
		else
		{
			filaliCampionato.sort(new Comparator<FilialeClassificaDto>()
			{

				@Override
				public int compare(FilialeClassificaDto o1, FilialeClassificaDto o2)
				{
					Integer punti1 = o1.getPuntiFiliale();
					Integer punti2 = o2.getPuntiFiliale();
					int ordinePunti = punti2.compareTo(punti1);
					if( ordinePunti != 0 )
					{
						return ordinePunti;
					}
					String nome1 = o1.getNomeFiliale();
					String nome2 = o2.getNomeFiliale();
					return nome1.compareTo(nome2);
				}
			});
			return filaliCampionato;
		}
	}
	public void setFilaliCampionato(List<FilialeClassificaDto> filaliCampionato)
	{
		this.filaliCampionato = filaliCampionato;
	}
	@Override
	public String toString()
	{
		return "ClassificaCampionatoDto [tipoCampionato=" + tipoCampionato + ", filaliCampionato=" + filaliCampionato + "]";
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((filaliCampionato == null) ? 0 : filaliCampionato.hashCode());
		result = prime * result + ((tipoCampionato == null) ? 0 : tipoCampionato.hashCode());
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
		ClassificaCampionatoDto other = (ClassificaCampionatoDto) obj;
		if (filaliCampionato == null)
		{
			if (other.filaliCampionato != null)
				return false;
		}
		else if (!filaliCampionato.equals(other.filaliCampionato))
			return false;
		if (tipoCampionato == null)
		{
			if (other.tipoCampionato != null)
				return false;
		}
		else if (!tipoCampionato.equals(other.tipoCampionato))
			return false;
		return true;
	}
}