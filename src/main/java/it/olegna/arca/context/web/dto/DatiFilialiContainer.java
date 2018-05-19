package it.olegna.arca.context.web.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import it.olegna.arca.context.models.Filiale;

public class DatiFilialiContainer implements Serializable
{

	private static final long serialVersionUID = 1306677484834634648L;
	private Date dataRiferimento;
	private List<Filiale> datiFiliale;
	public Date getDataRiferimento()
	{
		return dataRiferimento;
	}
	public void setDataRiferimento(Date dataRiferimento)
	{
		this.dataRiferimento = dataRiferimento;
	}
	public List<Filiale> getDatiFiliale()
	{
		return datiFiliale;
	}
	public void setDatiFiliale(List<Filiale> datiFiliale)
	{
		this.datiFiliale = datiFiliale;
	}
}