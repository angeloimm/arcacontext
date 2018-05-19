package it.olegna.arca.context.test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;

import it.olegna.arca.context.dto.UtenteDto;

public class SimpleTest
{
	private static final Logger logger = LoggerFactory.getLogger(SimpleTest.class.getName());
	@Test
	public void generaJson() throws Exception
	{
		List<UtenteDto> utenti = new ArrayList<>();
		UtenteDto main = new UtenteDto();
		main.setCognome("Di Palma");
		main.setNome("Salvatore");
		main.setPassword("s.dipalma");
		main.setUsername("s.dipalma");
		main.setMail("Salvatore.DiPalma@arcavita.it");
		List<String> ruoli = new ArrayList<>(2);
		ruoli.add("ADMIN");
		ruoli.add("SUPER_ADMIN");
		ruoli.add("USER");
		main.setRuoli(ruoli);
		utenti.add(main);
		ObjectMapper om = new ObjectMapper();
		String json = om.writeValueAsString(utenti);
		logger.info(json);
	}
}
