package it.olegna.arca.context.service;
import java.util.List;

import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.UserProfile;

public interface IUserProfileSvc
{
	UserProfile findById(String id) throws ArcaContextDbException;
	UserProfile findByType(String type) throws ArcaContextDbException;
	List<UserProfile> findAll() throws ArcaContextDbException;
	void saveUserProfile(UserProfile userProfile) throws ArcaContextDbException;
	Long count() throws ArcaContextDbException;
}