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
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		long temp;
		temp = Double.doubleToLongBits(auto);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((dataDati == null) ? 0 : dataDati.hashCode());
		temp = Double.doubleToLongBits(re);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		temp = Double.doubleToLongBits(totale);
		result = prime * result + (int) (temp ^ (temp >>> 32));
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
		DatiMatchFilialeDto other = (DatiMatchFilialeDto) obj;
		if (Double.doubleToLongBits(auto) != Double.doubleToLongBits(other.auto))
			return false;
		if (dataDati == null)
		{
			if (other.dataDati != null)
				return false;
		}
		else if (!dataDati.equals(other.dataDati))
			return false;
		if (Double.doubleToLongBits(re) != Double.doubleToLongBits(other.re))
			return false;
		if (Double.doubleToLongBits(totale) != Double.doubleToLongBits(other.totale))
			return false;
		return true;
	}
}