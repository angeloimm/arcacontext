package it.olegna.arca.context.models;

import java.util.Iterator;
import java.util.List;

import javax.persistence.AssociationOverride;
import javax.persistence.AssociationOverrides;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicUpdate;

@DynamicUpdate
@Cache( region = "it.olegna.arca.context.models.CampionatoFiliale", 
		usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name = "CAMPIONATO_FILIALE")
@AssociationOverrides({
	@AssociationOverride(name = "pk.filiale", 
		joinColumns = @JoinColumn(name = "ID_FILIALE")),
	@AssociationOverride(name = "pk.campionato", 
		joinColumns = @JoinColumn(name = "ID_CAMPIONATO")) })
public class CampionatoFiliale extends AbstractModel
{

	private static final long serialVersionUID = -3277098625979665346L;
	private CampionatoFilialeId pk = new CampionatoFilialeId();
	@EmbeddedId
	public CampionatoFilialeId getPk()
	{
		return pk;
	}

	public void setPk(CampionatoFilialeId pk)
	{
		this.pk = pk;
	}
	@Transient
	public Filiale getFiliale()
	{
		return getPk().getFiliale();
	}
	public void setFiliale( Filiale f )
	{
		getPk().setFiliale(f);
	}
	@Transient
	public Campionato getCampionato()
	{
		return getPk().getCampionato();
	}
	public void setCampionato( Campionato c )
	{
		getPk().setCampionato(c);
	}
	public void addFiliali( List<Filiale> filiali )
	{
		for (Filiale filiale : filiali)
		{
			setFiliale(filiale);
		}
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((pk == null) ? 0 : pk.hashCode());
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
		CampionatoFiliale other = (CampionatoFiliale) obj;
		if (pk == null)
		{
			if (other.pk != null)
				return false;
		}
		else if (!pk.equals(other.pk))
			return false;
		return true;
	}
}