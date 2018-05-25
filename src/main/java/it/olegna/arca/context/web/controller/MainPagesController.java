package it.olegna.arca.context.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import it.olegna.arca.context.service.DatiFilialeSvc;
import it.olegna.arca.context.web.dto.UserPrincipal;

@Controller
@RequestMapping("/pages")
public class MainPagesController {
	private static final Logger logger = LoggerFactory.getLogger(MainPagesController.class.getName());
	@Autowired
	private HttpServletRequest req;
	@Autowired
	private DatiFilialeSvc datiFilialeSvc;
	@Autowired
	private HttpSession sessione;
	@Value("${arca.context.max.file.dimension}")
	private long dimensioneFile;
	@Value("${arca.context.produzione.minima}")
	private long produzioneMinima;
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_SUPER_ADMIN')")
	@RequestMapping(method = { RequestMethod.GET }, value="/protected/adminHome")
	public String homePage(Model model)
	{
		try
		{
			if( SecurityContextHolder.getContext() != null && SecurityContextHolder.getContext().getAuthentication() != null )
			{
				
				UserPrincipal user = (UserPrincipal)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				model.addAttribute("utenteLoggato", user);
			}
			model.addAttribute("dimensioneFile", dimensioneFile);
			model.addAttribute("dimensioneFileFormattata", FileUtils.byteCountToDisplaySize(dimensioneFile));
			long durataSessioneSecondi = sessione.getMaxInactiveInterval(); 
			model.addAttribute("durataSessione", durataSessioneSecondi);
			return "views/homePage";
		}
		catch (Exception e) 
		{
			logger.error("Errore nel rendering della Home Page",e);
			return "views/genericError";
		}
	}
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = { RequestMethod.GET }, value="/protected/elencoFiliali")
	public String elencoFiliali(Model model)
	{
		try
		{
			if( SecurityContextHolder.getContext() != null && SecurityContextHolder.getContext().getAuthentication() != null )
			{
				
				UserPrincipal user = (UserPrincipal)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				model.addAttribute("utenteLoggato", user);
			}
			model.addAttribute("dimensioneFileFormattata", FileUtils.byteCountToDisplaySize(dimensioneFile));
			long durataSessioneSecondi = sessione.getMaxInactiveInterval(); 
			model.addAttribute("durataSessione", durataSessioneSecondi);
			long datiFiliale = this.datiFilialeSvc.contaDatiFiliale();
			boolean creazioneCampionato = datiFiliale > 0;
			model.addAttribute("creazioneCampionato", creazioneCampionato);
			model.addAttribute("produzioneMinima", produzioneMinima);
			model.addAttribute("numeroFilialiCampionato", 22);
			return "views/elencoFiliali";
		}
		catch (Exception e) 
		{
			logger.error("Errore nel rendering della Home Page",e);
			return "views/genericError";
		}
	}	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = { RequestMethod.GET }, value="/protected/registriProtocollo")
	public String registriProtocollo(Model model)
	{
		try
		{
			if( SecurityContextHolder.getContext() != null && SecurityContextHolder.getContext().getAuthentication() != null )
			{
				
				UserPrincipal user = (UserPrincipal)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				model.addAttribute("utenteLoggato", user);
			}
			model.addAttribute("dimensioneFile", dimensioneFile);
			model.addAttribute("dimensioneFileFormattata", FileUtils.byteCountToDisplaySize(dimensioneFile));
			long durataSessioneSecondi = sessione.getMaxInactiveInterval(); 
			model.addAttribute("durataSessione", durataSessioneSecondi);
			return "views/registriProtocollo";
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