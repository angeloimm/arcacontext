package it.olegna.arca.context.dto;

import java.io.Serializable;
import java.util.Date;

public class FilialeDto implements Serializable
{

	private static final long serialVersionUID = -3846226846964324382L;
	private String nomeFiliale;
	private double re;
	private double auto;
	private double totaleReAuto;
	private Date dataDati;
	public String getNomeFiliale()
	{
		return nomeFiliale;
	}
	public void setNomeFiliale(String nomeFiliale)
	{
		this.nomeFiliale = nomeFiliale;
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
	public double getTotaleReAuto()
	{
		return totaleReAuto;
	}
	public void setTotaleReAuto(double totaleReAuto)
	{
		this.totaleReAuto = totaleReAuto;
	}
	public Date getDataDati()
	{
		return dataDati;
	}
	public void setDataDati(Date dataDati)
	{
		this.dataDati = dataDati;
	}
	@Override
	public String toString()
	{
		return "FilialeDto [nomeFiliale=" + nomeFiliale + ", re=" + re + ", auto=" + auto + ", totaleReAuto=" + totaleReAuto + ", dataDati=" + dataDati + "]";
	}
}