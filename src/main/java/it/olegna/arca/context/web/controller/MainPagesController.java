package it.olegna.arca.context.web.controller;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/pages")
public class MainPagesController {
	private static final Logger logger = LoggerFactory.getLogger(MainPagesController.class.getName());
	@RequestMapping("/protected/adminHome")
	public String homePage()
	{
		try
		{
			logger.info(SecurityContextHolder.getContext().getAuthentication().getPrincipal().toString());
			return "views/homePage";
		}
		catch (Exception e) 
		{
			logger.error("Errore nel rendering della Home Page",e);
			return "views/genericError";
		}
	}
	@RequestMapping(method = { RequestMethod.GET }, value = {"/accessDenied"})
	public String accessDenied()
	{
		return "views/accessDenied";
	}	
	@RequestMapping(method = { RequestMethod.GET }, value = {"/loginPage"})
	public String loginPage()
	{
		return "views/loginPage";
	}	
	@RequestMapping(method = { RequestMethod.GET }, value = { "/logout" })
	public String logout(HttpServletResponse resp) throws Exception
	{
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null)
		{
			SecurityContextHolder.getContext().setAuthentication(null);
		}
		return "redirect:/pages/loginPage?logout";
	}	
}
