package it.olegna.arca.context.web.dto;

import java.io.Serializable;

import it.olegna.arca.context.dto.FilialeDto;

public class IncontroDto implements Serializable
{

	private static final long serialVersionUID = 6612497371271783997L;
	private FilialeDto filialeCasa;
	private FilialeDto filialeFuoriCasa;
	private String dataIncontro;
	public IncontroDto()
	{
		super();
	}
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
	public String getDataIncontro()
	{
		return dataIncontro;
	}
	public void setDataIncontro(String dataIncontro)
	{
		this.dataIncontro = dataIncontro;
	}
	@Override
	public String toString()
	{
		return "IncontroDto [filialeCasa=" + filialeCasa + ", filialeFuoriCasa=" + filialeFuoriCasa + ", dataIncontro=" + dataIncontro + "]";
	}
}