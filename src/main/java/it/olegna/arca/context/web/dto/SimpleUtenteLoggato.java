package it.olegna.arca.context.web.dto;

import java.io.Serializable;

public class SimpleUtenteLoggato implements Serializable
{

	private static final long serialVersionUID = 3873285472307339098L;
	private String nome;
	private String cognome;
	public String getNome()
	{
		return nome;
	}
	public void setNome(String nome)
	{
		this.nome = nome;
	}
	public String getCognome()
	{
		return cognome;
	}
	public void setCognome(String cognome)
	{
		this.cognome = cognome;
	}
}