package it.olegna.arca.context.dto;

import java.io.Serializable;
import java.util.List;

public class FilialiConfigurationDto implements Serializable
{

	private static final long serialVersionUID = -7839376364115487188L;
	private List<String> filialiDaEscludere;
	private List<FilialeUnitaDto> filialiUnite;
	public List<String> getFilialiDaEscludere()
	{
		return filialiDaEscludere;
	}
	public void setFilialiDaEscludere(List<String> filialiDaEscludere)
	{
		this.filialiDaEscludere = filialiDaEscludere;
	}
	public List<FilialeUnitaDto> getFilialiUnite()
	{
		return filialiUnite;
	}
	public void setFilialiUnite(List<FilialeUnitaDto> filialiUnite)
	{
		this.filialiUnite = filialiUnite;
	}
	@Override
	public String toString()
	{
		return "ConfigurationDto [filialiDaEscludere=" + filialiDaEscludere + ", filialiUnite=" + filialiUnite + "]";
	}
}