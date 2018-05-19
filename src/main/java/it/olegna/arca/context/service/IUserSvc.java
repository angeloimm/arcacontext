package it.olegna.arca.context.service;
import java.util.List;

import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.User;

public interface IUserSvc
{
	User findUserById(String id) throws ArcaContextDbException;
	User findUserByUsername(String username) throws ArcaContextDbException;
	void saveUser(User user, List<String> ruoli) throws ArcaContextDbException;
	void updateUser(User user) throws ArcaContextDbException;
	boolean isUsernameUnique( String id, String username ) throws ArcaContextDbException;
	Long countUsers() throws ArcaContextDbException;
}