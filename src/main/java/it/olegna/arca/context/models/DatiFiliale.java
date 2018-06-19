package it.olegna.arca.context.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicUpdate;
@DynamicUpdate
@Cache( region = "it.olegna.arca.context.models.DatiFiliale", 
		usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name = "DATI_FILIALE", indexes = { @Index(name = "DATA_DATI_IDX", 
											columnList = "DATA_DATI") })
public class DatiFiliale extends AbstractModel
{

	private static final long serialVersionUID = -8863663013694386520L;
	private double re;
	private double auto;
	private double totale;
	private Date dataDati;
	private Filiale filiale;
	private String nomeFile;
	
	@ManyToOne(targetEntity=Filiale.class)
	@JoinColumn(name="id_filiale", nullable=false)
	public Filiale getFiliale()
	{
		return filiale;
	}
	public void setFiliale(Filiale filiale)
	{
		this.filiale = filiale;
	}
	@Column(name="RE_FILIALE", nullable=false)
	public double getRe()
	{
		return re;
	}
	public void setRe(double re)
	{
		this.re = re;
	}
	@Column(name="AUTO_FILIALE", nullable=false)
	public double getAuto()
	{
		return auto;
	}
	public void setAuto(double auto)
	{
		this.auto = auto;
	}
	@Column(name="TOTALE_FILIALE", nullable=false)
	public double getTotale()
	{
		return totale;
	}
	public void setTotale(double totale)
	{
		this.totale = totale;
	}
	@Column(name="DATA_DATI", nullable=false)
	@Temporal(TemporalType.DATE)
	public Date getDataDati()
	{
		return dataDati;
	}
	public void setDataDati(Date dataDati)
	{
		this.dataDati = dataDati;
	}
	@Column(name="NOME_FILE_DATI", nullable=false)
	public String getNomeFile()
	{
		return nomeFile;
	}
	public void setNomeFile(String nomeFile)
	{
		this.nomeFile = nomeFile;
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = super.hashCode();
		long temp;
		temp = Double.doubleToLongBits(auto);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((dataDati == null) ? 0 : dataDati.hashCode());
		result = prime * result + ((nomeFile == null) ? 0 : nomeFile.hashCode());
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
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		DatiFiliale other = (DatiFiliale) obj;
		if (Double.doubleToLongBits(auto) != Double.doubleToLongBits(other.auto))
			return false;
		if (dataDati == null)
		{
			if (other.dataDati != null)
				return false;
		}
		else if (!dataDati.equals(other.dataDati))
			return false;
		if (nomeFile == null)
		{
			if (other.nomeFile != null)
				return false;
		}
		else if (!nomeFile.equals(other.nomeFile))
			return false;
		if (Double.doubleToLongBits(re) != Double.doubleToLongBits(other.re))
			return false;
		if (Double.doubleToLongBits(totale) != Double.doubleToLongBits(other.totale))
			return false;
		return true;
	}
	@Override
	public String toString()
	{
		return "DatiFiliale [re=" + re + ", auto=" + auto + ", totale=" + totale + ", dataDati=" + dataDati + ", nomeFile=" + nomeFile + "]";
	}
}