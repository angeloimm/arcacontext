package it.olegna.arca.context.web.dto;

import java.io.Serializable;
import java.util.Date;

public class DatiMatchFilialeDto implements Serializable
{

	private static final long serialVersionUID = 3055725266903795771L;
	private Date dataDati;
	private double re;
	private double auto;
	private double totale;
	public Date getDataDati()
	{
		return dataDati;
	}
	public void setDataDati(Date dataDati)
	{
		this.dataDati = dataDati;
	}
	public double getRe()
	{
		return re;
	}
	public void setRe(double re)
	{
		this.re = re;
	}
	public double getAuto()
	{
		return auto;
	}
	public void setAuto(double auto)
	{
		this.auto = auto;
	}
	public double getTotale()
	{
		return totale;
	}
	public void setTotale(double totale)
	{
		this.totale = totale;
	}
	@Override
	public String toString()
	{
		return "DatiMatchFilialeDto [dataDati=" + dataDati + ", re=" + re + ", auto=" + auto + ", totale=" + totale + "]";
	}
}