package it.olegna.arca.context.test;

import java.io.File;
import java.util.List;

import org.joda.time.DateTime;
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
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.User;
import it.olegna.arca.context.service.CampionatoSvc;
import it.olegna.arca.context.service.DataReader;
import it.olegna.arca.context.service.FilialeManagerSvc;
import it.olegna.arca.context.service.IUserSvc;
import it.olegna.arca.context.web.dto.CreazioneCampionatoDto;
import it.olegna.arca.context.web.dto.DatiFilialiContainer;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={TestDbConfig.class})
@TestPropertySource("configuration.properties")
public class TestCampionati
{
	private static final Logger logger = LoggerFactory.getLogger(TestCampionati.class.getName());
	@Autowired
	private CampionatoSvc<Campionato> campionatoService;
	@Autowired
	private DataReader reader;
	@Autowired
	private FilialeManagerSvc filialeSvc;
	@Test
	public void testCreazioneCampionato()
	{
		DateTime today = (new DateTime()).withTimeAtStartOfDay();
		DateTime inizio = today.plusDays((int)(Math.random()*10));
		DateTime fine = inizio.plusDays((int)(Math.random()*10));
		try
		{
			File path = new File("esempioFile");
			File[] files = path.listFiles();
			for (int i = 0; i < files.length; i++)
			{
				File aFile =files[i];
				if( logger.isDebugEnabled() )
				{
					logger.debug("FILE {}", aFile.getName());
				}
				Resource fileRes = new FileSystemResource(aFile);
				DatiFilialiContainer res = reader.dataReader(fileRes.getInputStream());
				filialeSvc.salvaAggiornaFilialeAndDati(res.getDatiFiliale(), res.getDataRiferimento());
			}
			
			CreazioneCampionatoDto creaCampionatoRequest = new CreazioneCampionatoDto();
			creaCampionatoRequest.setDataFine(fine.getMillis());
			creaCampionatoRequest.setDataInizio(inizio.getMillis());
			creaCampionatoRequest.setNumeroSquadre(22l);
			creaCampionatoRequest.setProduzioneMinima(200);
			campionatoService.creaCampionato(creaCampionatoRequest);
			logger.info("OK");
		}
		catch (Exception e) {
			logger.error("Errore", e);
		}
	}
}
