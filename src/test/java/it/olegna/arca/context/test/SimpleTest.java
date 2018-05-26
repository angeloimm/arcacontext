package it.olegna.arca.context.test;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.math3.analysis.function.Divide;
import org.apache.commons.math3.util.BigReal;
import org.apache.commons.math3.util.Precision;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;

import it.olegna.arca.context.dto.FilialiConfigurationDto;
import it.olegna.arca.context.dto.FilialeUnitaDto;
import it.olegna.arca.context.dto.UtenteDto;

public class SimpleTest
{
	private static final Logger logger = LoggerFactory.getLogger(SimpleTest.class.getName());
	@Test
	public void generaJsonFiliali() throws Exception
	{
		FilialiConfigurationDto cfg = new FilialiConfigurationDto();
		List<String> filialiIgnorabili = new ArrayList<>();
		filialiIgnorabili.add("SCICLI AG. 2");
		filialiIgnorabili.add("RADDUSA");
		filialiIgnorabili.add("POZZALLO AGENZIA N.1");
		cfg.setFilialiDaEscludere(filialiIgnorabili);
		List<FilialeUnitaDto> unite = new ArrayList<>();
		FilialeUnitaDto uno = new FilialeUnitaDto();
		uno.setNomeFilialePrincipale("RAGUSA AG.1");
		uno.setNomeFilialeSecondaria("RAGUSA AG.5");
		uno.setNomeFilialeUnita(uno.getNomeFilialePrincipale());
		unite.add(uno);
		
		FilialeUnitaDto due = new FilialeUnitaDto();
		due.setNomeFilialePrincipale("GRAMMICHELE");
		due.setNomeFilialeSecondaria("FILIALE DI VIZZINI");
		due.setNomeFilialeUnita(due.getNomeFilialePrincipale());
		unite.add(due);
		
		
		FilialeUnitaDto tre = new FilialeUnitaDto();
		tre.setNomeFilialePrincipale("CALTAGIRONE");
		tre.setNomeFilialeSecondaria("SAN MICHELE DI GANZARIA");
		tre.setNomeFilialeUnita(tre.getNomeFilialePrincipale());
		unite.add(tre);
		
		FilialeUnitaDto quattro = new FilialeUnitaDto();
		quattro.setNomeFilialePrincipale("CATANIA");
		quattro.setNomeFilialeSecondaria("CATANIA AG. 4");
		quattro.setNomeFilialeUnita(quattro.getNomeFilialePrincipale());
		unite.add(quattro);
		cfg.setFilialiUnite(unite);
		ObjectMapper om = new ObjectMapper();
		String json = om.writeValueAsString(cfg);
		logger.info(json);
	}
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
	@Test
	public void divisione() throws Exception
	{
//		BigReal fil = new BigReal(87);
//		fil.setRoundingMode(RoundingMode.HALF_UP);
//		long numeroCampionati = fil.divide(new BigReal(22)).bigDecimalValue().longValue();
//		logger.info(""+numeroCampionati);
		long numeroFiliali = 87l;
		long numeroSquadre = 22l;
		Divide div = new Divide();
		double result = div.value(new Double(numeroFiliali), new Double(numeroSquadre));
		Double finalResult = Precision.round(result, 0, BigDecimal.ROUND_UP);
		logger.info("RESULT {}, ARROTONDATO {}", result, finalResult.longValue());
	}
}
