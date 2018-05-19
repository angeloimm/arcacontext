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

import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.service.DataReader;
import it.olegna.arca.context.service.FilialeManagerSvc;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={TestDbConfig.class})
@TestPropertySource("configuration.properties")
public class FileReaderDbTests
{
	private static final Logger logger = LoggerFactory.getLogger(FileReaderDbTests.class.getName());
	@Autowired
	private DataReader reader;
	@Autowired
	private FilialeManagerSvc filialeSvc;
	@Test
	public void readFile()
	{
		try
		{
			Resource fileRes = new FileSystemResource(new File("esempioFile/DATI RE.xlsx"));
			List<Filiale> filiali = reader.dataReader(fileRes.getInputStream());
			logger.info("Ottenute {} filiali", filiali.size());
			filialeSvc.salvaAggiornaFilialeAndDati(filiali);
		}
		catch (Exception e)
		{
			logger.error("Errore lettura file", e);
		}
	}
}
