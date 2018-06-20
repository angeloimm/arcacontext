package it.olegna.arca.context.web.dto;

import java.io.Serializable;

import it.olegna.arca.context.dto.FilialeDto;

public class IncontroDto implements Serializable
{

	private static final long serialVersionUID = 6612497371271783997L;
	private FilialeDto filialeCasa;
	private FilialeDto filialeFuoriCasa;
	private String dataIncontro;
	private Long inizioSettimana;
	private Long fineSettimana;
	private double risultatoCasa;
	private double risultatoFuoriCasa;
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
	public Long getInizioSettimana()
	{
		return inizioSettimana;
	}
	public void setInizioSettimana(Long inizioSettimana)
	{
		this.inizioSettimana = inizioSettimana;
	}
	public Long getFineSettimana()
	{
		return fineSettimana;
	}
	public void setFineSettimana(Long fineSettimana)
	{
		this.fineSettimana = fineSettimana;
	}
	public double getRisultatoCasa()
	{
		return risultatoCasa;
	}
	public void setRisultatoCasa(double risultatoCasa)
	{
		this.risultatoCasa = risultatoCasa;
	}
	public double getRisultatoFuoriCasa()
	{
		return risultatoFuoriCasa;
	}
	public void setRisultatoFuoriCasa(double risultatoFuoriCasa)
	{
		this.risultatoFuoriCasa = risultatoFuoriCasa;
	}
	@Override
	public String toString()
	{
		return "IncontroDto [filialeCasa=" + filialeCasa + ", filialeFuoriCasa=" + filialeFuoriCasa + ", dataIncontro=" + dataIncontro + ", inizioSettimana=" + inizioSettimana + ", fineSettimana=" + fineSettimana + ", risultatoCasa=" + risultatoCasa + ", risultatoFuoriCasa=" + risultatoFuoriCasa + "]";
	}
}