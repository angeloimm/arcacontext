package it.olegna.arca.context.models;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Index;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicUpdate;

@DynamicUpdate
@Cache( region = "it.olegna.arca.context.models.Filiale", 
		usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name = "FILIALE", indexes = { @Index(name = "NOME_FILIALE_IDX", 
											columnList = "NOME_FILIALE") })
public class Filiale extends AbstractModel
{

	private static final long serialVersionUID = 5888875786395363908L;
	private String nomeFiliale;
	private Set<DatiFiliale> datiFiliale;
	private Set<CampionatoFiliale> campionati = new HashSet<CampionatoFiliale>(0);
	private Set<Incontro> incontriCasa = new HashSet<Incontro>(0);
	private Set<Incontro> incontriFuoriCasa = new HashSet<Incontro>(0);
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "pk.filiale")
	public Set<CampionatoFiliale> getCampionati()
	{
		return campionati;
	}
	public void setCampionati(Set<CampionatoFiliale> campionati)
	{
		this.campionati = campionati;
	}
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "filialeCasa", targetEntity=Incontro.class)
	public Set<Incontro> getIncontriCasa()
	{
		return incontriCasa;
	}
	public void setIncontriCasa(Set<Incontro> incontriCasa)
	{
		this.incontriCasa = incontriCasa;
	}
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "filialeFuoriCasa", targetEntity=Incontro.class)
	public Set<Incontro> getIncontriFuoriCasa()
	{
		return incontriFuoriCasa;
	}
	public void setIncontriFuoriCasa(Set<Incontro> incontriFuoriCasa)
	{
		this.incontriFuoriCasa = incontriFuoriCasa;
	}
	@Column(name="NOME_FILIALE", nullable=false)
	public String getNomeFiliale()
	{
		return nomeFiliale;
	}
	public void setNomeFiliale(String nomeFiliale)
	{
		this.nomeFiliale = nomeFiliale;
	}
	@OneToMany(mappedBy="filiale", orphanRemoval=true, targetEntity=DatiFiliale.class)
	public Set<DatiFiliale> getDatiFiliale()
	{
		return datiFiliale;
	}
	public void setDatiFiliale(Set<DatiFiliale> datiFiliale)
	{
		this.datiFiliale = datiFiliale;
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((campionati == null) ? 0 : campionati.hashCode());
		result = prime * result + ((datiFiliale == null) ? 0 : datiFiliale.hashCode());
		result = prime * result + ((incontriCasa == null) ? 0 : incontriCasa.hashCode());
		result = prime * result + ((incontriFuoriCasa == null) ? 0 : incontriFuoriCasa.hashCode());
		result = prime * result + ((nomeFiliale == null) ? 0 : nomeFiliale.hashCode());
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
		Filiale other = (Filiale) obj;
		if (campionati == null)
		{
			if (other.campionati != null)
				return false;
		}
		else if (!campionati.equals(other.campionati))
			return false;
		if (datiFiliale == null)
		{
			if (other.datiFiliale != null)
				return false;
		}
		else if (!datiFiliale.equals(other.datiFiliale))
			return false;
		if (incontriCasa == null)
		{
			if (other.incontriCasa != null)
				return false;
		}
		else if (!incontriCasa.equals(other.incontriCasa))
			return false;
		if (incontriFuoriCasa == null)
		{
			if (other.incontriFuoriCasa != null)
				return false;
		}
		else if (!incontriFuoriCasa.equals(other.incontriFuoriCasa))
			return false;
		if (nomeFiliale == null)
		{
			if (other.nomeFiliale != null)
				return false;
		}
		else if (!nomeFiliale.equals(other.nomeFiliale))
			return false;
		return true;
	}
	@Override
	public String toString()
	{
		return "Filiale [nomeFiliale=" + nomeFiliale + ", datiFiliale=" + datiFiliale + ", campionati=" + campionati + ", incontriCasa=" + incontriCasa + ", incontriFuoriCasa=" + incontriFuoriCasa + "]";
	}
}