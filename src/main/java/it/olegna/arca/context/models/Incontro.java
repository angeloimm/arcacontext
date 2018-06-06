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
@Table	(	name = "INCONTRO", 
			indexes = { @Index(name = "DATA_INCONTRO_IDX", columnList = "DATA_INCONTRO") }/*,
			uniqueConstraints= {@UniqueConstraint(columnNames= {"ID_CAMPIONATO","ID_FILIALE_CASA","ID_FILIALE_FUORI_CASA"})}*/
		)
public class Incontro extends AbstractModel
{

	private static final long serialVersionUID = -1498014526262912272L;
	private Filiale filialeCasa;
	private Filiale filialeFuoriCasa;
	private Campionato campionato;
	private Date dataIncontro;
	@ManyToOne(fetch=FetchType.LAZY, targetEntity=Campionato.class)
	@JoinColumn(name="ID_CAMPIONATO", nullable=false)
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
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((campionato == null) ? 0 : campionato.hashCode());
		result = prime * result + ((dataIncontro == null) ? 0 : dataIncontro.hashCode());
		result = prime * result + ((filialeCasa == null) ? 0 : filialeCasa.hashCode());
		result = prime * result + ((filialeFuoriCasa == null) ? 0 : filialeFuoriCasa.hashCode());
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
		Incontro other = (Incontro) obj;
		if (campionato == null)
		{
			if (other.campionato != null)
				return false;
		}
		else if (!campionato.equals(other.campionato))
			return false;
		if (dataIncontro == null)
		{
			if (other.dataIncontro != null)
				return false;
		}
		else if (!dataIncontro.equals(other.dataIncontro))
			return false;
		if (filialeCasa == null)
		{
			if (other.filialeCasa != null)
				return false;
		}
		else if (!filialeCasa.equals(other.filialeCasa))
			return false;
		if (filialeFuoriCasa == null)
		{
			if (other.filialeFuoriCasa != null)
				return false;
		}
		else if (!filialeFuoriCasa.equals(other.filialeFuoriCasa))
			return false;
		return true;
	}
	
}