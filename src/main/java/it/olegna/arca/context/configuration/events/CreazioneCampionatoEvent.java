package it.olegna.arca.context.configuration.events;

import java.util.Date;

import org.springframework.context.ApplicationEvent;

public class CreazioneCampionatoEvent extends ApplicationEvent
{

	private static final long serialVersionUID = 5526660645761591076L;
	private Date dataInizioCampionato;
	public CreazioneCampionatoEvent(Object source, Date dataInizioCampionato)
	{
		super(source);
		this.dataInizioCampionato = dataInizioCampionato;
	}
	public Date getDataInizioCampionato()
	{
		return dataInizioCampionato;
	}
	public void setDataInizioCampionato(Date dataInizioCampionato)
	{
		this.dataInizioCampionato = dataInizioCampionato;
	}
}