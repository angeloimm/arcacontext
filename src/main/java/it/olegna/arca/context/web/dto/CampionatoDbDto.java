package it.olegna.arca.context.web.dto;

import java.io.Serializable;
import java.util.Date;

public class CampionatoDbDto implements Serializable
{

	private static final long serialVersionUID = -8601429379626168623L;
	private String idCampionato;
	private boolean campionatoAttivo;
	private Date dataInizioCampionato;
	private Date dataFineCampionato;
	private double produzioneMinimaCampionato;
	public String getIdCampionato()
	{
		return idCampionato;
	}
	public void setIdCampionato(String idCampionato)
	{
		this.idCampionato = idCampionato;
	}
	public boolean isCampionatoAttivo()
	{
		return campionatoAttivo;
	}
	public void setCampionatoAttivo(boolean campionatoAttivo)
	{
		this.campionatoAttivo = campionatoAttivo;
	}
	public Date getDataInizioCampionato()
	{
		return dataInizioCampionato;
	}
	public void setDataInizioCampionato(Date dataInizioCampionato)
	{
		this.dataInizioCampionato = dataInizioCampionato;
	}
	public Date getDataFineCampionato()
	{
		return dataFineCampionato;
	}
	public void setDataFineCampionato(Date dataFineCampionato)
	{
		this.dataFineCampionato = dataFineCampionato;
	}
	public double getProduzioneMinimaCampionato()
	{
		return produzioneMinimaCampionato;
	}
	public void setProduzioneMinimaCampionato(double produzioneMinimaCampionato)
	{
		this.produzioneMinimaCampionato = produzioneMinimaCampionato;
	}
	
}