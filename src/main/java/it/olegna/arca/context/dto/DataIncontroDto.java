package it.olegna.arca.context.dto;

import java.io.Serializable;
import java.util.Date;

public class DataIncontroDto implements Serializable
{

	private static final long serialVersionUID = -771668041692241023L;
	private Date dataIncontro;
	private Date dataInizioSettimana;
	private Date dataFineSettimana;
	public Date getDataIncontro()
	{
		return dataIncontro;
	}
	public void setDataIncontro(Date dataIncontro)
	{
		this.dataIncontro = dataIncontro;
	}
	public Date getDataInizioSettimana()
	{
		return dataInizioSettimana;
	}
	public void setDataInizioSettimana(Date dataInizioSettimana)
	{
		this.dataInizioSettimana = dataInizioSettimana;
	}
	public Date getDataFineSettimana()
	{
		return dataFineSettimana;
	}
	public void setDataFineSettimana(Date dataFineSettimana)
	{
		this.dataFineSettimana = dataFineSettimana;
	}
	@Override
	public String toString()
	{
		return "DataIncontroDto [dataIncontro=" + dataIncontro + ", dataInizioSettimana=" + dataInizioSettimana + ", dataFineSettimana=" + dataFineSettimana + "]";
	}
}