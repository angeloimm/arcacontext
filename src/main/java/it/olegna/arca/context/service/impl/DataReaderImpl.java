package it.olegna.arca.context.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.olegna.arca.context.exception.ArcaContextDataReaderException;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.service.DataReader;
import it.olegna.arca.context.service.FilialeManagerSvc;
@Service
public class DataReaderImpl implements DataReader
{
	private static final Logger logger = LoggerFactory.getLogger(DataReaderImpl.class.getName());
	@Autowired
	private FilialeManagerSvc svc;
	@Override
	public List<Filiale> dataReader(InputStream is) throws ArcaContextDataReaderException
	{
		Workbook workbook = null;
		try
		{
			Map<String, Filiale> elencoFiliali = new HashMap<String, Filiale>();
			workbook = new XSSFWorkbook(is);
			Sheet sheetRe = workbook.getSheetAt(1);
			Sheet sheetAuto = workbook.getSheetAt(3);
			return null;
		}
		catch (Exception e)
		{
			String message = "Errore nella lettura dei dati RE";
			logger.error(message, e);
			throw new ArcaContextDataReaderException(message, e);
		}
		finally 
		{
			if(workbook != null)
			{
				try
				{
					workbook.close();
				}
				catch (IOException e)
				{
					logger.warn("Errore nella chiusura del workbook; {}", e.getMessage()); 
				}
			}
		}
	}
}
