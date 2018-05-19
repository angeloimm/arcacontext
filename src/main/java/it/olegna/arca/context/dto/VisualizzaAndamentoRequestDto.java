package it.olegna.arca.context.dto;

import java.io.Serializable;
import java.util.List;

public class VisualizzaAndamentoRequestDto implements Serializable
{
	private List<String> idFiliali;

	public List<String> getIdFiliali()
	{
		return idFiliali;
	}

	public void setIdFiliali(List<String> idFiliali)
	{
		this.idFiliali = idFiliali;
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idFiliali == null) ? 0 : idFiliali.hashCode());
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
		VisualizzaAndamentoRequestDto other = (VisualizzaAndamentoRequestDto) obj;
		if (idFiliali == null)
		{
			if (other.idFiliali != null)
				return false;
		}
		else if (!idFiliali.equals(other.idFiliali))
			return false;
		return true;
	}

	@Override
	public String toString()
	{
		return "VisualizzaAndamentoRequestDto [idFiliali=" + idFiliali + "]";
	}
}