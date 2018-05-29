package it.olegna.arca.context.configuration.events;

import java.util.Date;
import java.util.List;

import org.springframework.context.ApplicationEvent;

import it.olegna.arca.context.web.dto.CampionatoFilialiDto;

public class CreazioneCampionatoEvent extends ApplicationEvent
{

	private static final long serialVersionUID = 5526660645761591076L;
	private Date dataInizioCampionato;
	private List<CampionatoFilialiDto> campionatoFiliali;
	public CreazioneCampionatoEvent(Object source, Date dataInizioCampionato, List<CampionatoFilialiDto> campionatoFiliali)
	{
		super(source);
		this.dataInizioCampionato = dataInizioCampionato;
		this.campionatoFiliali = campionatoFiliali;
	}
	public Date getDataInizioCampionato()
	{
		return dataInizioCampionato;
	}
	public void setDataInizioCampionato(Date dataInizioCampionato)
	{
		this.dataInizioCampionato = dataInizioCampionato;
	}
	public List<CampionatoFilialiDto> getCampionatoFiliali()
	{
		return campionatoFiliali;
	}
	public void setCampionatoFiliali(List<CampionatoFilialiDto> campionatoFiliali)
	{
		this.campionatoFiliali = campionatoFiliali;
	}
}