package it.olegna.arca.context.test;

import java.io.File;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import it.olegna.arca.context.dto.UtenteDto;
import it.olegna.arca.context.models.User;
import it.olegna.arca.context.service.IUserSvc;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={TestDbConfig.class})
@TestPropertySource("configuration.properties")
public class TestUtente
{
	private static final Logger logger = LoggerFactory.getLogger(TestUtente.class.getName());
	@Autowired
	private IUserSvc userSvc;
	@Test
	public void testCreazioneUtente()
	{
		try
		{
			Resource fileRes = new FileSystemResource(new File("esempioFile/utenti.json"));
			ObjectMapper om = new ObjectMapper();
			List<UtenteDto> utenti = om.readValue(fileRes.getInputStream(), new TypeReference<List<UtenteDto>>()
			{
			});
			for (UtenteDto utenteDto : utenti)
			{
				User utente = utenteDto.toUser("sistema");
				userSvc.saveUser(utente, utenteDto.getRuoli());
			}
		}
		catch (Exception e) {
			logger.error("Errore", e);
		}
	}
}
