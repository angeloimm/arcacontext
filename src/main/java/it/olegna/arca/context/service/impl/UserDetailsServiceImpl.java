package it.olegna.arca.context.service.impl;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.User;
import it.olegna.arca.context.models.UserProfile;
import it.olegna.arca.context.service.IUserSvc;
import it.olegna.arca.context.web.dto.UserPrincipal;

@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService
{
	private static final Logger logger = LoggerFactory.getLogger(UserDetailsServiceImpl.class.getName());
	@Autowired
	@Qualifier("userService")
	private IUserSvc userSvc;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException
	{
		if( logger.isDebugEnabled() )
		{
			logger.debug("Recupero utente con username "+username);
		}
		User user = null;
		try
		{
			user = userSvc.findUserByUsername(username);
		}
		catch (ArcaContextDbException e)
		{
			logger.error("Errore nel recupero dell'utente con username "+username, e);
		}
		if( user == null )
		{
			throw new UsernameNotFoundException("Nessun utente trovato con username "+username);
		}
		UserPrincipal result = new UserPrincipal(user.getUsername(), user.getPassword(), true, true, true, true, getGrantedAuthorities(user));
		result.setCognome(user.getCognome());
		result.setNome(user.getNome());
		result.setEmail(user.getEmail());
		result.setId(user.getId());
		return result;
	}
	private List<GrantedAuthority> getGrantedAuthorities(User user)
	{
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		for(UserProfile userProfile : user.getUserProfiles()){
			
			authorities.add(new SimpleGrantedAuthority("ROLE_"+userProfile.getType()));
		}
		if( logger.isDebugEnabled() )
		{
		
			logger.info("authorities associate all'utente: {}", authorities);
		}
		return authorities;
	}
}