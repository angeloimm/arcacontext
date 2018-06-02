package it.olegna.arca.context.dto;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import it.olegna.arca.context.models.User;

public class UtenteDto implements Serializable
{
	private static final long serialVersionUID = -7594546425749282097L;
	private String nome;
	private String cognome;
	private String username;
	private String password;
	private List<String> ruoli;
	private String mail;
	
	public String getUsername()
	{
		return username;
	}
	public void setUsername(String username)
	{
		this.username = username;
	}
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
	public String getPassword()
	{
		return password;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}
	public List<String> getRuoli()
	{
		return ruoli;
	}
	public void setRuoli(List<String> ruoli)
	{
		this.ruoli = ruoli;
	}
	public String getMail()
	{
		return mail;
	}
	public void setMail(String mail)
	{
		this.mail = mail;
	}
	@Override
	public String toString()
	{
		return "UtenteDto [nome=" + nome + ", cognome=" + cognome + ", username=" + username + ", ruoli=" + ruoli + ", mail=" + mail + "]";
	}
	public User toUser(String creatoDa)
	{
		User result = new User();
		result.setCognome(this.getCognome());
		result.setCreatoDa(creatoDa);
		result.setDataCreazione(new Date());
		result.setEmail(this.getMail());
		result.setPassword(this.getPassword());
		result.setUsername(this.getUsername());
		result.setNome(this.getNome());

		return result;
	}
}
