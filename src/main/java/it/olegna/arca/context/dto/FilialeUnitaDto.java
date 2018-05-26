package it.olegna.arca.context.dto;

import java.io.Serializable;

public class FilialeUnitaDto implements Serializable
{

	private static final long serialVersionUID = -8924422205059194010L;
	private String nomeFilialePrincipale;
	private String nomeFilialeSecondaria;
	private String nomeFilialeUnita;
	public String getNomeFilialePrincipale()
	{
		return nomeFilialePrincipale;
	}
	public void setNomeFilialePrincipale(String nomeFilialePrincipale)
	{
		this.nomeFilialePrincipale = nomeFilialePrincipale;
	}
	public String getNomeFilialeSecondaria()
	{
		return nomeFilialeSecondaria;
	}
	public void setNomeFilialeSecondaria(String nomeFilialeSecondaria)
	{
		this.nomeFilialeSecondaria = nomeFilialeSecondaria;
	}
	public String getNomeFilialeUnita()
	{
		return nomeFilialeUnita;
	}
	public void setNomeFilialeUnita(String nomeFilialeUnita)
	{
		this.nomeFilialeUnita = nomeFilialeUnita;
	}
	@Override
	public String toString()
	{
		return "FilialeUnitaDto [nomeFilialePrincipale=" + nomeFilialePrincipale + ", nomeFilialeSecondaria=" + nomeFilialeSecondaria + ", nomeFilialeUnita=" + nomeFilialeUnita + "]";
	}
}