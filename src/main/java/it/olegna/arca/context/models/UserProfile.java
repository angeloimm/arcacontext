package it.olegna.arca.context.models;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicUpdate;
@DynamicUpdate
@Cache(region = "it.olegna.arca.context.models.UserProfile", usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name = "RUOLI_UTENTE", indexes = { @Index(name = "CAND_USER_PROF_IDX", columnList = "PROFILO_UTENTE")})

public class UserProfile extends AbstractModel {

	private static final long serialVersionUID = 3446132062637458050L;
	private String type = UserProfileType.USER.getUserProfileType();
	@Column(name = "PROFILO_UTENTE", length = 15, unique = true, nullable = false)
	public String getType()
	{
		return type;
	}

	public void setType(String type)
	{
		this.type = type;
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	@Override
	public String toString()
	{
		return "CommSvrUserProfile [type=" + type + "]";
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
		UserProfile other = (UserProfile) obj;
		if (type == null)
		{
			if (other.type != null)
				return false;
		}
		else if (!type.equals(other.type))
			return false;
		return true;
	}
}