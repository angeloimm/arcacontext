package it.olegna.arca.context.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import it.olegna.arca.context.exception.ArcaContextDataReaderException;
import it.olegna.arca.context.models.DatiFiliale;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.service.DataReader;
import it.olegna.arca.context.service.FilialeManagerSvc;
import it.olegna.arca.context.util.TimeUtil;
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
		String nomeUtente = "sistema";
		if( SecurityContextHolder.getContext() != null && SecurityContextHolder.getContext().getAuthentication() != null )
		{
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			nomeUtente = auth.getName();
		}
		try
		{
			Map<String, Filiale> elencoFiliali = new HashMap<String, Filiale>();
			workbook = new XSSFWorkbook(is);
			Sheet sheetRe = workbook.getSheetAt(1);
			//			Iterator<Row> rows = sheetRe.iterator();
			//			while (rows.hasNext())
			//			{
			//				Row row = rows.next();
			////				logger.debug("INDICE RIGA {}", row.getRowNum());
			//				Iterator<Cell> celle = row.cellIterator();
			//				while (celle.hasNext())
			//				{
			//					Cell cell = celle.next();
			//					logger.debug("INDICE CELLA {} INDICE RIGA {}", cell.getColumnIndex(), cell.getRowIndex());
			//					CellType tipo= cell.getCellTypeEnum();
			//					switch (tipo)
			//					{
			//					case STRING:
			//						logger.info("TIPO CELLA STRINGA VALORE {}", cell.getStringCellValue());
			//						break;
			//					case NUMERIC:
			//						logger.info("TIPO CELLA NUMERIC VALORE {}", cell.getNumericCellValue());
			//						break;
			//					default:
			//						break;
			//					}
			//				}
			//			}
			String rigaDataDati = sheetRe.getRow(3).getCell(0).getStringCellValue();
			String dataData = (rigaDataDati.split(":")[1]).trim();
			Date dataDati = TimeUtil.toDateTime(dataData, "dd/MM/yyyy").toDate();
			int inizio = 9;
			int fine = 106;
			for( int i = inizio; i < 103; i++ )
			{
				Row aRow = sheetRe.getRow(i);
				Cell nomeFilialeCell = aRow.getCell(1);
				Cell reFilialeCell = aRow.getCell(6);
				String nomeFiliale = nomeFilialeCell.getStringCellValue();
				double reFiliale = reFilialeCell.getNumericCellValue();
				Filiale filiale = new Filiale();
				filiale.setCreatoDa(nomeUtente);
				filiale.setDataCreazione(new Date());
				filiale.setNomeFiliale(nomeFiliale);
				DatiFiliale df = new DatiFiliale();
				df.setCreatoDa(nomeUtente);
				df.setDataCreazione(new Date());
				df.setDataDati(dataDati);
				df.setRe(reFiliale);
				Set<DatiFiliale> datiFiliale = new HashSet<DatiFiliale>(1);
				datiFiliale.add(df);
				filiale.setDatiFiliale(datiFiliale);
				elencoFiliali.put(nomeFiliale.trim().toUpperCase(), filiale);
			}
			if( logger.isDebugEnabled() )
			{
				logger.debug("DIMENSIONE MAP {}", elencoFiliali.size());
			}
			Sheet sheetAuto = workbook.getSheetAt(3);
			for( int i = inizio; i < fine; i++ )
			{
				Row aRow = sheetAuto.getRow(i);
				Cell nomeFilialeCell = aRow.getCell(1);
				Cell autoFilialeCell = aRow.getCell(6);
				String nomeFiliale = nomeFilialeCell.getStringCellValue();
				if( elencoFiliali.containsKey(nomeFiliale.toUpperCase().trim()) )
				{
					if( logger.isDebugEnabled() )
					{
						logger.debug("NOME FILIALE {}", nomeFiliale);
					}
					double autoFiliale = autoFilialeCell.getNumericCellValue();
					Filiale filiale = elencoFiliali.get(nomeFiliale.trim().toUpperCase());
					DatiFiliale df = filiale.getDatiFiliale().stream().findFirst().get();
					df.setAuto(autoFiliale);
					Set<DatiFiliale> datiFiliale = new HashSet<DatiFiliale>(1);
					datiFiliale.add(df);
					filiale.setDatiFiliale(datiFiliale);
					elencoFiliali.put(nomeFiliale.trim().toUpperCase(), filiale);
				}
				else
				{
					logger.warn("NOME FILIALE {} NON CONTENUTO NELLO SHEET RE", nomeFiliale);
				}
			}
			return new ArrayList<Filiale>(elencoFiliali.values());
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
