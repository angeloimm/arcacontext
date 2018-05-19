package it.olegna.arca.context.models;
import java.io.Serializable;

public enum UserProfileType implements Serializable
{
	USER("USER"), ADMIN("ADMIN"), SUPER_ADMIN("SUPER_ADMIN");
	String userProfileType;

	private UserProfileType(String userProfileType)
	{
		this.userProfileType = userProfileType;
	}

	public String getUserProfileType()
	{
		return userProfileType;
	}
}