package it.olegna.arca.context.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.annotation.PostConstruct;

import org.apache.commons.math3.analysis.function.Add;
import org.apache.commons.math3.util.Precision;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import it.olegna.arca.context.dto.FilialeUnitaDto;
import it.olegna.arca.context.dto.FilialiConfigurationDto;
import it.olegna.arca.context.exception.ArcaContextDataReaderException;
import it.olegna.arca.context.models.DatiFiliale;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.service.DataReader;
import it.olegna.arca.context.util.TimeUtil;
import it.olegna.arca.context.web.dto.DatiFilialiContainer;
@Service
public class DataReaderImpl implements DataReader
{
	private static final Logger logger = LoggerFactory.getLogger(DataReaderImpl.class.getName());
	private FilialiConfigurationDto filialiCfg;
	@Autowired
	@Qualifier("objectMapper")
	private ObjectMapper om;
	@Override
	public DatiFilialiContainer dataReader(InputStream is) throws ArcaContextDataReaderException
	{
		DatiFilialiContainer result = new DatiFilialiContainer();
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
			String rigaDataDati = sheetRe.getRow(3).getCell(0).getStringCellValue();
			String dataData = (rigaDataDati.split(":")[1]).trim();
			Date dataDati = TimeUtil.toDateTime(dataData, "dd/MM/yyyy").toDate();
			result.setDataRiferimento(dataDati);
			int inizio = 9;
			int fine = 106;
			List<String> daEscludere = this.filialiCfg.getFilialiDaEscludere();
			for( int i = inizio; i < fine; i++ )
			{
				Row aRow = sheetRe.getRow(i);
				Cell nomeFilialeCell = aRow.getCell(1);
				Cell reFilialeCell = aRow.getCell(6);
				String nomeFiliale = nomeFilialeCell.getStringCellValue();
				if( !daEscludere.contains(nomeFiliale.trim().toUpperCase()) )
				{
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
				else
				{
					if( logger.isWarnEnabled() )
					{
						logger.warn("FILIALE [{}] È DA ESCLUDERE", nomeFiliale.trim().toUpperCase());
					}
				}
			}
			if( logger.isDebugEnabled() )
			{
				logger.debug("DIMENSIONE MAP {}", elencoFiliali.size());
			}
			Sheet sheetAuto = workbook.getSheetAt(3);
			Add add = new Add();
			for( int i = inizio; i < 103; i++ )
			{
				Row aRow = sheetAuto.getRow(i);
				Cell nomeFilialeCell = aRow.getCell(1);
				Cell autoFilialeCell = aRow.getCell(6);
				String nomeFiliale = nomeFilialeCell.getStringCellValue();
				if( !daEscludere.contains(nomeFiliale.trim().toUpperCase()) )
				{
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
						df.setTotale(Precision.round(add.value(df.getRe(), autoFiliale), 3));
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
			}
			if( logger.isDebugEnabled() )
			{
				logger.debug("PRIMA DELLA UNIONE DIMENSIONE [{}]", elencoFiliali.size());
			}
			List<FilialeUnitaDto> filialiUnite = this.filialiCfg.getFilialiUnite();
			for (FilialeUnitaDto filialeUnitaDto : filialiUnite)
			{
				Filiale principale = elencoFiliali.remove(filialeUnitaDto.getNomeFilialePrincipale());
				Filiale secondaria = elencoFiliali.remove(filialeUnitaDto.getNomeFilialeSecondaria());
				Optional<DatiFiliale> datiFilialePrincipale = principale.getDatiFiliale().stream().findFirst();
				Optional<DatiFiliale> datiFilialeSecondaria = secondaria.getDatiFiliale().stream().findFirst();
				if( datiFilialePrincipale.isPresent() )
				{
					DatiFiliale datiPrinc = datiFilialePrincipale.get();
					if( datiFilialeSecondaria.isPresent() )
					{
						DatiFiliale datiSec = datiFilialeSecondaria.get();
						datiPrinc.setAuto(Precision.round(add.value(datiPrinc.getAuto(), datiSec.getAuto()), 3));
						datiPrinc.setRe(Precision.round(add.value(datiPrinc.getRe(), datiSec.getRe()), 3));
						datiPrinc.setTotale(Precision.round(add.value(datiPrinc.getTotale(), datiSec.getTotale()), 3));
					}
					Set<DatiFiliale> dati = principale.getDatiFiliale();
					dati.clear();
					dati.add(datiPrinc);
					principale.setDatiFiliale(dati);
					elencoFiliali.put(principale.getNomeFiliale().trim().toUpperCase(), principale);
				}
				
			}
			if( logger.isDebugEnabled() )
			{
				logger.debug("DOPO L'UNIONE DIMENSIONE [{}]", elencoFiliali.size());
			}
			result.setDatiFiliale(new ArrayList<Filiale>(elencoFiliali.values()));
			return result;
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
	@PostConstruct
	public void initialize()
	{
		if( logger.isInfoEnabled() )
		{
			logger.info("Caricamento JSON per configurazione filiali");
		}
		try
		{
			Resource json = new ClassPathResource("filialiConfig.json");
			this.filialiCfg = om.readValue(json.getInputStream(), FilialiConfigurationDto.class);
		}
		catch (Exception e) 
		{
			logger.error("Errore nella lettura del JSON di configurazione filiali", e);
			throw new IllegalStateException("Errore nella lettura del JSON di configurazione filiali", e);
		}
	}
}