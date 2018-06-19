package it.olegna.arca.context.web.dto;

import java.io.Serializable;

public class CreazioneCampionatoDto implements Serializable
{

	private static final long serialVersionUID = 5259450020236884766L;
	private long dataInizio;
	private long dataFine;
	private long dataCalcoloCreazioneCampionato;
	private double produzioneMinima;
	private long numeroSquadre;
	public long getDataInizio()
	{
		return dataInizio;
	}
	public void setDataInizio(long dataInizio)
	{
		this.dataInizio = dataInizio;
	}
	public long getDataFine()
	{
		return dataFine;
	}
	public void setDataFine(long dataFine)
	{
		this.dataFine = dataFine;
	}
	public double getProduzioneMinima()
	{
		return produzioneMinima;
	}
	public void setProduzioneMinima(double produzioneMinima)
	{
		this.produzioneMinima = produzioneMinima;
	}
	public long getNumeroSquadre()
	{
		return numeroSquadre;
	}
	public void setNumeroSquadre(long numeroSquadre)
	{
		this.numeroSquadre = numeroSquadre;
	}
	public long getDataCalcoloCreazioneCampionato()
	{
		return dataCalcoloCreazioneCampionato;
	}
	public void setDataCalcoloCreazioneCampionato(long dataCalcoloCreazioneCampionato)
	{
		this.dataCalcoloCreazioneCampionato = dataCalcoloCreazioneCampionato;
	}
	@Override
	public String toString()
	{
		return "CreazioneCampionatoDto [dataInizio=" + dataInizio + ", dataFine=" + dataFine + ", dataCalcoloCreazioneCampionato=" + dataCalcoloCreazioneCampionato + ", produzioneMinima=" + produzioneMinima + ", numeroSquadre=" + numeroSquadre + "]";
	}
}