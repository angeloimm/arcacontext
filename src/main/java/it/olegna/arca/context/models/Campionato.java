package it.olegna.arca.context.models;

import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
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
	private double importoProduzioneMinima;
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
	
}