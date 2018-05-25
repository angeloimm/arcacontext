package it.olegna.arca.context.web.dto;

import java.io.Serializable;

public class CampionatoDto implements Serializable
{

	private static final long serialVersionUID = -8601429379626168623L;
	private String idCampionato;
	private boolean campionatoAttivo;
	private long dataInizioCampionato;
	private long dataFineCampionato;
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
	public long getDataInizioCampionato()
	{
		return dataInizioCampionato;
	}
	public void setDataInizioCampionato(long dataInizioCampionato)
	{
		this.dataInizioCampionato = dataInizioCampionato;
	}
	public long getDataFineCampionato()
	{
		return dataFineCampionato;
	}
	public void setDataFineCampionato(long dataFineCampionato)
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