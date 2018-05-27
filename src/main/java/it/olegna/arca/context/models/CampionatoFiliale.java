package it.olegna.arca.context.models;

import javax.persistence.AssociationOverride;
import javax.persistence.AssociationOverrides;
import javax.persistence.Column;
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
	private int puntiFiliale;
	
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
	@Column(name="PUNTI_FILIALE", nullable=false)
	public int getPuntiFiliale()
	{
		return puntiFiliale;
	}

	public void setPuntiFiliale(int puntiFiliale)
	{
		this.puntiFiliale = puntiFiliale;
	}
}