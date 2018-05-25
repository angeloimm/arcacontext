package it.olegna.arca.context.models;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Index;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicUpdate;

@DynamicUpdate
@Cache( region = "it.olegna.arca.context.models.Campionato", 
		usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name = "CAMPIONATO", indexes = { @Index(name = "DATA_INIZIO_IDX", 
											columnList = "DATA_INIZIO"),
										@Index(name = "DATA_FINE_IDX", 
										columnList = "DATA_FINE")})
public class Campionato extends AbstractModel
{

	private static final long serialVersionUID = 5888875786395363908L;
	private Date dataInizio;
	private Date dataFine;
	private String categoriaCampionato;
	private boolean campionatoAttivo = false;
	private double importoProduzioneMinima = 0.0d;
	private Set<CampionatoFiliale> campionati = new HashSet<CampionatoFiliale>();
	@Column(name="CAMPIONATO_ATTIVO", nullable=false)
	public boolean isCampionatoAttivo()
	{
		return campionatoAttivo;
	}
	public void setCampionatoAttivo(boolean campionatoAttivo)
	{
		this.campionatoAttivo = campionatoAttivo;
	}
	@Column(name="CATEGORIA_CAMPIONATO", nullable=false)
	public String getCategoriaCampionato()
	{
		return categoriaCampionato;
	}
	public void setCategoriaCampionato(String categoriaCampionato)
	{
		this.categoriaCampionato = categoriaCampionato;
	}
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "pk.campionato", cascade=CascadeType.ALL)
	public Set<CampionatoFiliale> getCampionati()
	{
		return campionati;
	}
	public void setCampionati(Set<CampionatoFiliale> campionati)
	{
		this.campionati = campionati;
	}
	@Column(name="DATA_INIZIO", nullable=false)
	@Temporal(TemporalType.DATE)
	public Date getDataInizio()
	{
		return dataInizio;
	}
	public void setDataInizio(Date dataInizio)
	{
		this.dataInizio = dataInizio;
	}
	@Column(name="DATA_FINE", nullable=false)
	@Temporal(TemporalType.DATE)
	public Date getDataFine()
	{
		return dataFine;
	}
	public void setDataFine(Date dataFine)
	{
		this.dataFine = dataFine;
	}
	@Column(name="IMPORTO_PRODUZIONE_MINIMA", nullable=false)
	public double getImportoProduzioneMinima()
	{
		return importoProduzioneMinima;
	}
	public void setImportoProduzioneMinima(double importoProduzioneMinima)
	{
		this.importoProduzioneMinima = importoProduzioneMinima;
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((dataFine == null) ? 0 : dataFine.hashCode());
		result = prime * result + ((dataInizio == null) ? 0 : dataInizio.hashCode());
		long temp;
		temp = Double.doubleToLongBits(importoProduzioneMinima);
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
		Campionato other = (Campionato) obj;
		if (dataFine == null)
		{
			if (other.dataFine != null)
				return false;
		}
		else if (!dataFine.equals(other.dataFine))
			return false;
		if (dataInizio == null)
		{
			if (other.dataInizio != null)
				return false;
		}
		else if (!dataInizio.equals(other.dataInizio))
			return false;
		if (Double.doubleToLongBits(importoProduzioneMinima) != Double.doubleToLongBits(other.importoProduzioneMinima))
			return false;
		return true;
	}
}