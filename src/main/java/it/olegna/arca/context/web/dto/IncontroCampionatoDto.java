package it.olegna.arca.context.web.dto;

import java.io.Serializable;
import java.util.List;

public class IncontroCampionatoDto implements Serializable
{

	private static final long serialVersionUID = 6612497371271783997L;
	private String tipologiaCampionato;
	private List<IncontroDto> incontriCampionato;
	public String getTipologiaCampionato()
	{
		return tipologiaCampionato;
	}
	public void setTipologiaCampionato(String tipologiaCampionato)
	{
		this.tipologiaCampionato = tipologiaCampionato;
	}
	public List<IncontroDto> getIncontriCampionato()
	{
		return incontriCampionato;
	}
	public void setIncontriCampionato(List<IncontroDto> incontriCampionato)
	{
		this.incontriCampionato = incontriCampionato;
	}
	@Override
	public String toString()
	{
		return "IncontroCampionatoDto [tipologiaCampionato=" + tipologiaCampionato + ", incontriCampionato=" + incontriCampionato + "]";
	}
	
}
