package it.olegna.arca.context.models;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
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
		return "Filiale [nomeFiliale=" + nomeFiliale + ", getId()=" + getId() + ", getCreatoDa()=" + getCreatoDa() + ", getModificatoDa()=" + getModificatoDa() + ", getDataCreazione()=" + getDataCreazione() + ", getDataModifica()=" + getDataModifica() + "]";
	}
}