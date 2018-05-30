package it.olegna.arca.context.web.dto;

import java.io.Serializable;

import it.olegna.arca.context.dto.FilialeDto;

public class IncontroDto implements Serializable
{

	private static final long serialVersionUID = 6612497371271783997L;
	private FilialeDto filialeCasa;
	private FilialeDto filialeFuoriCasa;
	public FilialeDto getFilialeCasa()
	{
		return filialeCasa;
	}
	public void setFilialeCasa(FilialeDto filialeCasa)
	{
		this.filialeCasa = filialeCasa;
	}
	public FilialeDto getFilialeFuoriCasa()
	{
		return filialeFuoriCasa;
	}
	public void setFilialeFuoriCasa(FilialeDto filialeFuoriCasa)
	{
		this.filialeFuoriCasa = filialeFuoriCasa;
	}
	@Override
	public String toString()
	{
		return "IncontroDto [filialeCasa=" + filialeCasa + ", filialeFuoriCasa=" + filialeFuoriCasa + "]";
	}
	
}