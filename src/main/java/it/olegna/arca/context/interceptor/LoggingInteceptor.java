package it.olegna.arca.context.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;

import it.olegna.arca.context.web.dto.UserPrincipal;

public class LoggingInteceptor implements HandlerInterceptor
{
	private static final Logger logger = LoggerFactory.getLogger(LoggingInteceptor.class.getName());
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception
	{
		try
		{
			String remoteIp = request.getRemoteAddr();
			String remoteHost = request.getRemoteHost();
			String username = "anonimo";
			if( SecurityContextHolder.getContext() != null && SecurityContextHolder.getContext().getAuthentication() != null )
			{
				
				UserPrincipal user = (UserPrincipal)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				username = user.getUsername();
			}
			if( logger.isInfoEnabled() )
			{
				logger.info("IP RICHIESTA {} HOST RICHIESTA {} USERNAME UTENTE {} URL RICHIESTA {}", remoteIp, remoteHost, username, request.getRequestURI());
			}
		}
		catch (Exception e)
		{
			if( logger.isWarnEnabled() )
			{
				logger.warn("Errore nel loggare l'operazione utente; {}", e.getMessage()); 
			}
		}
	}
}