package it.olegna.arca.context.models;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicUpdate;
@DynamicUpdate
@Cache(region = "it.olegna.arca.context.models.User", usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name = "UTENTE", indexes = {		@Index(name = "UTENTE_NOME_IDX", columnList = "NOME"),
										@Index(name = "UTENTE_COGNOME_IDX", columnList = "COGNOME")})
public class User extends AbstractModel {


	private static final long serialVersionUID = -829370719342853965L;
	private String username;
	private String password;
	private String nome;
	private String cognome;
	private String email;
	private Set<UserProfile> userProfiles = new HashSet<UserProfile>();
	
	@Column(name="USERNAME", unique=true, nullable=false)
	public String getUsername()
	{
		return username;
	}
	public void setUsername(String username)
	{
		this.username = username;
	}
	
	@Column(name="PASSWORD", nullable=false)
	public String getPassword()
	{
		return password;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}
	
	@Column(name="NOME", nullable=false)
	public String getNome()
	{
		return nome;
	}
	public void setNome(String nome)
	{
		this.nome = nome;
	}
	
	@Column(name="COGNOME", nullable=false)	
	public String getCognome()
	{
		return cognome;
	}
	public void setCognome(String cognome)
	{
		this.cognome = cognome;
	}
	
	@Column(name="EMAIL", nullable=false)
	public String getEmail()
	{
		return email;
	}
	public void setEmail(String email)
	{
		this.email = email;
	}
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(	name = "APP_USER_USER_PROFILE", 
             	joinColumns = { @JoinColumn(name = "USER_ID") }, 
             	inverseJoinColumns = { @JoinColumn(name = "USER_PROFILE_ID") })
	public Set<UserProfile> getUserProfiles()
	{
		return userProfiles;
	}
	public void setUserProfiles(Set<UserProfile> userProfiles)
	{
		this.userProfiles = userProfiles;
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((cognome == null) ? 0 : cognome.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		result = prime * result + ((username == null) ? 0 : username.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj)
	{
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (cognome == null)
		{
			if (other.cognome != null)
				return false;
		}
		else if (!cognome.equals(other.cognome))
			return false;
		if (email == null)
		{
			if (other.email != null)
				return false;
		}
		else if (!email.equals(other.email))
			return false;
		if (nome == null)
		{
			if (other.nome != null)
				return false;
		}
		else if (!nome.equals(other.nome))
			return false;
		if (password == null)
		{
			if (other.password != null)
				return false;
		}
		else if (!password.equals(other.password))
			return false;
		if (username == null)
		{
			if (other.username != null)
				return false;
		}
		else if (!username.equals(other.username))
			return false;
		return true;
	}
	@Override
	public String toString()
	{
		return "User [username=" + username + ", password=" + password + ", nome=" + nome + ", cognome=" + cognome + ", email=" + email + ", userProfiles=" + userProfiles + "]";
	}

}