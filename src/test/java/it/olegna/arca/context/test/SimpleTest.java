package it.olegna.arca.context.test;

import java.io.Console;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.math3.analysis.function.Divide;
import org.apache.commons.math3.util.Precision;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;

import it.olegna.arca.context.dto.FilialeUnitaDto;
import it.olegna.arca.context.dto.FilialiConfigurationDto;
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
	@Test
	public void testAlgoritmoMatch()
	{
		List<String> teams = new ArrayList<>();
		teams.add("COMISO AG.1                                   ");               
		teams.add("AGENZIA DI COMISO                             ");
		teams.add("MINEO                                         ");
		teams.add("FILIALE DI MELILLI                            ");
		teams.add("RIPOSTO                                       ");
		teams.add("AGENZIA NR.1 DI AUGUSTA                       ");
		teams.add("ISPICA                                        ");
		teams.add("FILIALE DI NICOLOSI                           ");
		teams.add("CALTAGIRONE                                   ");
		teams.add("FILIALE DI SCORDIA                            ");
		teams.add("GRAMMICHELE                                   ");
		teams.add("SANTA CROCE CAMERINA                          ");
		teams.add("GIARRATANA                                    ");
		teams.add("MISTERBIANCO                                  ");
		teams.add("VITTORIA AG.1                                 ");
		teams.add("SCICLI - AGENZIA UNO                          ");
		teams.add("ROSOLINI                                      ");
		teams.add("SIRACUSA AG 1                                 ");
		teams.add("LICODIA EUBEA                                 ");
		teams.add("ADRANO                                        ");
		teams.add("VITTORIA AG.2                                 ");
		teams.add("AGENZIA DI SCICLI                             ");
		teams.add("AGENZIA DI CASSIBILE                          ");
		teams.add("ACATE                                         ");
		teams.add("CAPO D'ORLANDO                                ");
		teams.add("AGENZIA DI FRIGINTINI                         ");
		teams.add("DIPENDENZA DI MILANO                          ");
		teams.add("AGENZIA DI CARLENTINI                         ");
		teams.add("BRONTE                                        ");
		teams.add("FILIALE DI MAZZARRONE                         ");
		teams.add("CATANIA AG.3                                  ");
		teams.add("SANTA VENERINA                                ");
		teams.add("SANT'AGATA LI BATTIATI                        ");
		teams.add("AGENZIA DI DONNALUCATA                        ");
		teams.add("AGENZIA DI ZAFFERANA ETNEA                    ");
		teams.add("MARINA DI RAGUSA                              ");
		teams.add("CHIARAMONTE G.                                ");
		teams.add("AGENZIA NR.2 DI AUGUSTA                       ");
		teams.add("CATANIA AG.1                                  ");
		teams.add("AGENZIA DI PEDALINO                           ");
		teams.add("GIAMPILIERI                                   ");
		teams.add("CATANIA AG.2                                  ");
		teams.add("AGENZIA DI S.PIETRO CLARENZA                  ");
		teams.add("ENNA                                          ");
		teams.add("AG.SACRO CUORE                                ");
		teams.add("MONTEROSSO ALMO                               ");
		teams.add("LIPARI                                        ");
		teams.add("ITALA                                         ");
		teams.add("ISPICA AGENZIA 1                              ");
		teams.add("ACIREALE                                      ");
		teams.add("BELPASSO                                      ");
		teams.add("AGENZIA_DI_PIAZZA_ARMERINA                    ");
		teams.add("PALAZZOLO ACREIDE                             ");
		teams.add("VITTORIA                                      ");
		teams.add("AGENZIA DI LENTINI                            ");
		teams.add("FRANCOFONTE                                   ");
		teams.add("AGENZIA DI MODICA ALTA                        ");
		teams.add("AGENZIA DI MASCALUCIA                         ");
		teams.add("SIRACUSA AG.2                                 ");
		teams.add("FIUMEDINISI                                   ");
		teams.add("SEDE DI RAGUSA                                ");
		teams.add("CATANIA                                       ");
		teams.add("AGENZIA DI AVOLA                              ");
		teams.add("AGENZIA DI VIAGRANDE                          ");
		teams.add("AGENZIA DI SCOGLITTI                          ");
		teams.add("PACHINO                                       ");
		teams.add("AGENZIA DI PATERNO'                           ");
		teams.add("FILIALE DI MODICA - AG. 3                     ");
		teams.add("AGENZIA DI MILAZZO                            ");
		teams.add("AGENZIA DI PRIOLO GARGALLO                    ");
		teams.add("PIEDIMONTE ETNEO                              ");
		teams.add("MILITELLO IN VAL DI CATANIA                   ");
		teams.add("AGENZIA DI TAORMINA                           ");
		teams.add("RAGUSA AG.1                                   ");
		teams.add("AGENZIA DI MODICA                             ");
		teams.add("SORTINO                                       ");
		teams.add("MESSINA                                       ");
		teams.add("MESSINA AG.4                                  ");
		teams.add("MIRABELLA IMBACCARI                           ");
		teams.add("AGENZIA DI SIRACUSA                           ");
		teams.add("AGENZIA DI TREMESTIERI                        ");
		teams.add("RAGUSA IBLA                                   ");
		teams.add("SUCCURSALE DI AUGUSTA                         ");
		teams.add("RAMACCA                                       ");
		teams.add("RAGUSA AGENZIA 3                              ");
		teams.add("POZZALLO                                      ");
		teams.add("FLORIDIA                                      ");
		teams.add("RAGUSA AGENZIA 2                              ");
		teams.add("RAGUSA AGENZIA 4                              ");
		teams.add("MESSINA AG.1                                  ");
		ListMatches(teams);
	}
	static void ListMatches(List<String> ListTeam)
	{
	    if (ListTeam.size() % 2 != 0)
	    {
	        ListTeam.add("Bye"); // If odd number of teams add a dummy
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
	        System.out.println("Day "+(day + 1)+"");

	        int teamIdx = day % teamsSize;

	        System.out.println(teams.get(teamIdx)+"  vs "+ListTeam.get(0));

	        for (int idx = 1; idx < halfSize; idx++)
	        {               
	            int firstTeam = (day + idx) % teamsSize;
	            int secondTeam = (day  + teamsSize - idx) % teamsSize;
	            System.out.println(teams.get(firstTeam)+"  vs   "+teams.get(secondTeam));
	        }
	    }
	}
}
