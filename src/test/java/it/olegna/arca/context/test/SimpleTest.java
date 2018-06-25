package it.olegna.arca.context.test;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.math3.analysis.function.Divide;
import org.apache.commons.math3.util.Precision;
import org.joda.time.DateTime;
import org.joda.time.DateTimeConstants;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;

import it.olegna.arca.context.dto.FilialeUnitaDto;
import it.olegna.arca.context.dto.FilialiConfigurationDto;
import it.olegna.arca.context.dto.UtenteDto;
import it.olegna.arca.context.util.TimeUtil;

public class SimpleTest
{
	private static final Logger logger = LoggerFactory.getLogger(SimpleTest.class.getName());
	@Test
	public void testIncontri()
	{

	}
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
	@Test
	public void testDate()
	{
		try
		{
			String data = "05/06/2018";
			DateTime dt = TimeUtil.toDateTime(data, "dd/MM/yyyy");
			DateTime inizioSettimana = dt.withDayOfWeek(DateTimeConstants.MONDAY);
			DateTime fineSettimana = dt.withDayOfWeek(DateTimeConstants.FRIDAY);
			logger.info("DT {} INIZIO {} FINE {}", data, TimeUtil.formatDateTime(inizioSettimana, "dd/MM/yyyy"), TimeUtil.formatDateTime(fineSettimana, "dd/MM/yyyy"));
		}
		catch (Exception e)
		{
			logger.error("Errore ", e);
		}
	}
	@Test
	public void testAlgoritmoMatch()
	{
		List<String> teams = new ArrayList<>();
		teams.add("AGENZIA DI SIRACUSA                      ".trim());
		teams.add("MISTERBIANCO                     ".trim());
		teams.add("SUCCURSALE DI AUGUSTA            ".trim());
		teams.add("AGENZIA DI PRIOLO GARGALLO       ".trim());
		teams.add("MESSINA                          ".trim());
		teams.add("ROSOLINI                         ".trim());
		teams.add("AGENZIA DI S.PIETRO CLARENZA     ".trim());
		teams.add("CATANIA AG.2                     ".trim());
		teams.add("CATANIA                          ".trim());
		teams.add("PACHINO                          ".trim());
		teams.add("RAGUSA AGENZIA 2                 ".trim());
		teams.add("AG.SACRO CUORE                   ".trim());
		teams.add("AGENZIA NR.1 DI AUGUSTA          ".trim());
		teams.add("AGENZIA DI AVOLA                 ".trim());
		teams.add("FILIALE DI NICOLOSI              ".trim());
		teams.add("AGENZIA DI SCICLI                ".trim());
		teams.add("RAGUSA AG.1                      ".trim());
		teams.add("AGENZIA DI CARLENTINI            ".trim());
		teams.add("ISPICA                           ".trim());
		teams.add("VITTORIA                         ".trim());
		teams.add("LICODIA EUBEA                    ".trim());
		teams.add("COMISO AG.1                                   ".trim());               
		//		teams.add("AGENZIA DI COMISO                             ".trim());
		//		teams.add("MINEO                                         ".trim());
		//		teams.add("FILIALE DI MELILLI                            ".trim());
		//		teams.add("RIPOSTO                                       ".trim());
		//		teams.add("AGENZIA NR.1 DI AUGUSTA                       ".trim());
		//		teams.add("ISPICA                                        ".trim());
		//		teams.add("FILIALE DI NICOLOSI                           ".trim());
		//		teams.add("CALTAGIRONE                                   ".trim());
		//		teams.add("FILIALE DI SCORDIA                            ".trim());
		//		teams.add("GRAMMICHELE                                   ".trim());
		//		teams.add("SANTA CROCE CAMERINA                          ".trim());
		//		teams.add("GIARRATANA                                    ".trim());
		//		teams.add("MISTERBIANCO                                  ".trim());
		//		teams.add("VITTORIA AG.1                                 ".trim());
		//		teams.add("SCICLI - AGENZIA UNO                          ".trim());
		//		teams.add("ROSOLINI                                      ".trim());
		//		teams.add("SIRACUSA AG 1                                 ".trim());
		//		teams.add("LICODIA EUBEA                                 ".trim());
		//		teams.add("ADRANO                                        ".trim());
		//		teams.add("VITTORIA AG.2                                 ".trim());
		//		teams.add("AGENZIA DI SCICLI                             ".trim());
		//		teams.add("AGENZIA DI CASSIBILE                          ".trim());
		//		teams.add("ACATE                                         ".trim());
		//		teams.add("CAPO D'ORLANDO                                ".trim());
		//		teams.add("AGENZIA DI FRIGINTINI                         ".trim());
		//		teams.add("DIPENDENZA DI MILANO                          ".trim());
		//		teams.add("AGENZIA DI CARLENTINI                         ".trim());
		//		teams.add("BRONTE                                        ".trim());
		//		teams.add("FILIALE DI MAZZARRONE                         ".trim());
		//		teams.add("CATANIA AG.3                                  ".trim());
		//		teams.add("SANTA VENERINA                                ".trim());
		//		teams.add("SANT'AGATA LI BATTIATI                        ".trim());
		//		teams.add("AGENZIA DI DONNALUCATA                        ".trim());
		//		teams.add("AGENZIA DI ZAFFERANA ETNEA                    ".trim());
		//		teams.add("MARINA DI RAGUSA                              ".trim());
		//		teams.add("CHIARAMONTE G.                                ".trim());
		//		teams.add("AGENZIA NR.2 DI AUGUSTA                       ".trim());
		//		teams.add("CATANIA AG.1                                  ".trim());
		//		teams.add("AGENZIA DI PEDALINO                           ".trim());
		//		teams.add("GIAMPILIERI                                   ".trim());
		//		teams.add("CATANIA AG.2                                  ".trim());
		//		teams.add("AGENZIA DI S.PIETRO CLARENZA                  ".trim());
		//		teams.add("ENNA                                          ".trim());
		//		teams.add("AG.SACRO CUORE                                ".trim());
		//		teams.add("MONTEROSSO ALMO                               ".trim());
		//		teams.add("LIPARI                                        ".trim());
		//		teams.add("ITALA                                         ".trim());
		//		teams.add("ISPICA AGENZIA 1                              ".trim());
		//		teams.add("ACIREALE                                      ".trim());
		//		teams.add("BELPASSO                                      ".trim());
		//		teams.add("AGENZIA_DI_PIAZZA_ARMERINA                    ".trim());
		//		teams.add("PALAZZOLO ACREIDE                             ".trim());
		//		teams.add("VITTORIA                                      ".trim());
		//		teams.add("AGENZIA DI LENTINI                            ".trim());
		//		teams.add("FRANCOFONTE                                   ".trim());
		//		teams.add("AGENZIA DI MODICA ALTA                        ".trim());
		//		teams.add("AGENZIA DI MASCALUCIA                         ".trim());
		//		teams.add("SIRACUSA AG.2                                 ".trim());
		//		teams.add("FIUMEDINISI                                   ".trim());
		//		teams.add("SEDE DI RAGUSA                                ".trim());
		//		teams.add("CATANIA                                       ".trim());
		//		teams.add("AGENZIA DI AVOLA                              ".trim());
		//		teams.add("AGENZIA DI VIAGRANDE                          ".trim());
		//		teams.add("AGENZIA DI SCOGLITTI                          ".trim());
		//		teams.add("PACHINO                                       ".trim());
		//		teams.add("AGENZIA DI PATERNO'                           ".trim());
		//		teams.add("FILIALE DI MODICA - AG. 3                     ".trim());
		//		teams.add("AGENZIA DI MILAZZO                            ".trim());
		//		teams.add("AGENZIA DI PRIOLO GARGALLO                    ".trim());
		//		teams.add("PIEDIMONTE ETNEO                              ".trim());
		//		teams.add("MILITELLO IN VAL DI CATANIA                   ".trim());
		//		teams.add("AGENZIA DI TAORMINA                           ".trim());
		//		teams.add("RAGUSA AG.1                                   ".trim());
		//		teams.add("AGENZIA DI MODICA                             ".trim());
		//		teams.add("SORTINO                                       ".trim());
		//		teams.add("MESSINA                                       ".trim());
		//		teams.add("MESSINA AG.4                                  ".trim());
		//		teams.add("MIRABELLA IMBACCARI                           ".trim());
		//		teams.add("AGENZIA DI SIRACUSA                           ".trim());
		//		teams.add("AGENZIA DI TREMESTIERI                        ".trim());
		//		teams.add("RAGUSA IBLA                                   ".trim());
		//		teams.add("SUCCURSALE DI AUGUSTA                         ".trim());
		//		teams.add("RAMACCA                                       ".trim());
		//		teams.add("RAGUSA AGENZIA 3                              ".trim());
		//		teams.add("POZZALLO                                      ".trim());
		//		teams.add("FLORIDIA                                      ".trim());
		//		teams.add("RAGUSA AGENZIA 2                              ".trim());
		//		teams.add("RAGUSA AGENZIA 4                              ".trim());
		//		teams.add("MESSINA AG.1                                  ".trim());
		ListMatches(teams);
	}
	static void ListMatches(List<String> ListTeam)
	{
		if (ListTeam.size() % 2 != 0)
		{
			ListTeam.add("bye"); // If odd number of teams add a dummy
		}
		int numTeams = ListTeam.size();
		int numDays = (numTeams - 1); // Days needed to complete tournament
		int halfSize = numTeams / 2;

		List<String> teams = new ArrayList<String>();

		teams.addAll(ListTeam); // Add teams to List and remove the first team
		teams.remove(0);

		int teamsSize = teams.size();

		for (int day = 0; day < numDays; day++)
		{
			int giorno = day+1;
			if( giorno == 1 )
			{

				System.out.println("Day "+giorno+"");
			}
			int teamIdx = day % teamsSize;
			if( giorno == 1 && (!teams.get(teamIdx).equals("bye") && !ListTeam.get(0).equals("bye") ) )
			{
				System.out.println(teams.get(teamIdx)+"  vs "+ListTeam.get(0));
			}
			for (int idx = 1; idx < halfSize; idx++)
			{               
				int firstTeam = (day + idx) % teamsSize;
				int secondTeam = (day  + teamsSize - idx) % teamsSize;
				if( giorno == 1 && (!teams.get(firstTeam).equals("bye") && !teams.get(secondTeam).equals("bye") ) )
				{
					System.out.println(teams.get(firstTeam)+"  vs   "+teams.get(secondTeam));
				}
			}
		}
	}
}
