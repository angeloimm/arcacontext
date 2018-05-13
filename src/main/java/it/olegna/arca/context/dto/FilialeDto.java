package it.olegna.arca.context.dto;

import java.io.Serializable;
import java.util.List;

public class FilialeDto implements Serializable
{

	private static final long serialVersionUID = -3846226846964324382L;
	private String nomeFiliale;
	private List<DatiFilialeDto> datiFiliale;
	
	public List<DatiFilialeDto> getDatiFiliale()
	{
		return datiFiliale;
	}
	public void setDatiFiliale(List<DatiFilialeDto> datiFiliale)
	{
		this.datiFiliale = datiFiliale;
	}
	public String getNomeFiliale()
	{
		return nomeFiliale;
	}
	public void setNomeFiliale(String nomeFiliale)
	{
		this.nomeFiliale = nomeFiliale;
	}
	@Override
	public String toString()
	{
		return "FilialeDto [nomeFiliale=" + nomeFiliale + ", datiFiliale=" + datiFiliale + "]";
	}
	
}