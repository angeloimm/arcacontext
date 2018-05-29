package it.olegna.arca.context.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
@Cache( region = "it.olegna.arca.context.models.Incontro", 
		usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name = "INCONTRO", indexes = { @Index(name = "DATA_INCONTRO_IDX", 
											columnList = "DATA_INCONTRO") })
public class Incontro extends AbstractModel
{

	private static final long serialVersionUID = -1498014526262912272L;
	private Filiale filialeCasa;
	private Filiale filialeFuoriCasa;
	private Campionato campionato;
	private Date dataIncontro;
	@ManyToOne(fetch=FetchType.LAZY, targetEntity=Campionato.class)
	public Campionato getCampionato()
	{
		return campionato;
	}
	public void setCampionato(Campionato campionato)
	{
		this.campionato = campionato;
	}
	@Column(name="DATA_INCONTRO", nullable=false)
	@Temporal(TemporalType.DATE)
	public Date getDataIncontro()
	{
		return dataIncontro;
	}
	public void setDataIncontro(Date dataIncontro)
	{
		this.dataIncontro = dataIncontro;
	}
	@ManyToOne(fetch=FetchType.LAZY, targetEntity=Filiale.class)
	@JoinColumn(name="ID_FILIALE_CASA", nullable=false)
	public Filiale getFilialeCasa()
	{
		return filialeCasa;
	}
	public void setFilialeCasa(Filiale filialeCasa)
	{
		this.filialeCasa = filialeCasa;
	}
	@ManyToOne(fetch=FetchType.LAZY, targetEntity=Filiale.class)
	@JoinColumn(name="ID_FILIALE_FUORI_CASA", nullable=false)
	public Filiale getFilialeFuoriCasa()
	{
		return filialeFuoriCasa;
	}
	public void setFilialeFuoriCasa(Filiale filialeFuoriCasa)
	{
		this.filialeFuoriCasa = filialeFuoriCasa;
	}
}