package it.olegna.arca.context.service.impl;

import static it.olegna.arca.context.util.TimeUtil.formatDateTime;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;

import org.apache.commons.math3.util.Precision;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.transform.Transformers;
import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import it.olegna.arca.context.dao.CampionatoFilialeDao;
import it.olegna.arca.context.dao.DatiFilialeDao;
import it.olegna.arca.context.dao.FilialeDao;
import it.olegna.arca.context.dao.GenericDao;
import it.olegna.arca.context.dto.DataTableResponse;
import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.DatiFiliale;
import it.olegna.arca.context.models.Filiale;
import it.olegna.arca.context.models.Incontro;
import it.olegna.arca.context.service.FilialeManagerSvc;
import it.olegna.arca.context.transformers.MatchDbResultTransformers;
import it.olegna.arca.context.util.TimeUtil;
import it.olegna.arca.context.web.dto.CampionatoDbDto;
import it.olegna.arca.context.web.dto.DatiMatchFilialeDto;
import it.olegna.arca.context.web.dto.MatchDbDto;
@Service
public class FilialeMangerSvcImpl implements FilialeManagerSvc
{
	private static final Logger logger = LoggerFactory.getLogger(FilialeMangerSvcImpl.class.getName());
	@Autowired
	private FilialeDao filialeDao;
	@Autowired
	private DatiFilialeDao<DatiFiliale> datiFilialeDao;
	@Autowired
	private CampionatoFilialeDao campionatoFilialeDao;
	@Autowired
	private GenericDao<Campionato> campionatoDao;
	@Autowired
	private GenericDao<CampionatoDbDto> campionatoDtoDao;
	@Autowired
	private GenericDao<MatchDbDto> mathcDao;
	@Autowired
	private GenericDao<Incontro> incontriDao;
	@Autowired
	private GenericDao<Date> dateIncontriDao;
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void salvaAggiornaFiliale(Filiale filiale) throws ArcaContextDbException
	{
		try
		{
			filialeDao.saveOrUpdate(filiale);
		}
		catch (Exception e)
		{
			String message = "Errore nel salvataggio della filiale ["+filiale+"]";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}

	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public List<FilialeDto> ricercaFiliali(DetachedCriteria dc) throws ArcaContextDbException
	{
		try
		{
			return filialeDao.findByDtoDetacheCriteria(dc, -1, -1);
		}
		catch (Exception e)
		{
			String message = "Errore nel recupero delle filiali";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true)
	public Filiale ricercaFilialeByName(String name) throws ArcaContextDbException
	{
		if(!StringUtils.hasText(name))
		{
			throw new IllegalArgumentException("Passato nome filiale nullo o vuoto");
		}
		try
		{
			return getByName(name);
		}
		catch (Exception e)
		{
			String message = "Errore nel recupero delle filiali";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}
	private Filiale getByName(String name)
	{
		DetachedCriteria dc = DetachedCriteria.forClass(Filiale.class);
		dc.add(Property.forName("nomeFiliale").eq(name.trim()).ignoreCase());
		List<Filiale> filiali = filialeDao.findByCriteria(dc);
		if( filiali == null || filiali.isEmpty() )
		{
			return null;
		}
		if( filiali.size() > 1 )
		{
			throw new IllegalStateException("Impossibile proseguire. Trovate "+filiali.size()+" con nome "+name+"");
		}
		return filiali.get(0);
	}
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void salvaAggiornaFilialeAndDati(List<Filiale> filiali, Date dataDati, String nomeFile) throws ArcaContextDbException
	{
		try
		{
			//Controllo se esistono dati per quella data. Se cosi' li cancello
			if( datiFilialeDao.datiEsistentiByDate(dataDati) )
			{
				
				int datiCancellati = datiFilialeDao.deleteByDate(dataDati);
				if( logger.isWarnEnabled() )
				{
					logger.warn("PER LA DATA {} ERANO GIA' PRESENTI DEI DATI. CANCELLATI {} DATI", TimeUtil.formatDateTime(new DateTime(dataDati.getTime()), "dd/MM/yyyy"), datiCancellati);
				}
			}

			for (Filiale filiale : filiali)
			{
				Filiale f = getByName(filiale.getNomeFiliale()); 
				if( f != null )
				{
					Set<DatiFiliale> datiFiliale = filiale.getDatiFiliale();
					for (DatiFiliale df : datiFiliale)
					{
						df.setFiliale(f);
						df.setNomeFile(nomeFile);
						datiFilialeDao.persist(df);
					}
				}
				else
				{
					Set<DatiFiliale> datiFiliale = filiale.getDatiFiliale();
					filiale.setDatiFiliale(new HashSet<DatiFiliale>(0));
					filialeDao.persist(filiale);
					for (DatiFiliale df : datiFiliale)
					{
						df.setFiliale(filiale);
						df.setNomeFile(nomeFile);
						datiFilialeDao.persist(df);
					}
				}
			}
			calcolaPunteggiCampionati(dataDati);
		}
		catch (Exception e)
		{
			String message = "Errore nel salvataggio delle filiali";
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}

	}
	private void calcolaPunteggiCampionati(Date dataDati) throws ArcaContextDbException
	{
		try
		{
			//Prelevo id e le date di inizio e fine campionato attivo
			DetachedCriteria dc = DetachedCriteria.forClass(Campionato.class);
			dc.add(Property.forName("campionatoAttivo").eq(Boolean.TRUE));
			ProjectionList pl = Projections.projectionList();
			pl.add(Projections.property("id"),"idCampionato");
			pl.add(Projections.property("dataInizio"),"dataInizioCampionato");
			pl.add(Projections.property("dataFine"),"dataFineCampionato");
			pl.add(Projections.property("importoProduzioneMinima"),"produzioneMinimaCampionato");
			dc.setProjection(pl);
			dc.setResultTransformer(Transformers.aliasToBean(CampionatoDbDto.class));
			List<CampionatoDbDto> campionati = this.campionatoDtoDao.findByCriteria(dc);
			if( campionati == null || campionati.isEmpty() )
			{
				if( logger.isInfoEnabled() )
				{
					logger.info("Nessun campionato attivo presente");
				}
			}
			else
			{
				CampionatoDbDto campionato = campionati.get(0);
				DateTime start = (new DateTime(campionato.getDataInizioCampionato())).withTimeAtStartOfDay();
				DateTime fine = (new DateTime(campionato.getDataFineCampionato())).withTimeAtStartOfDay();
				DateTime data = new DateTime(dataDati.getTime());
				boolean datiInCampionatoAttivo = new Interval(start, fine).contains(data);
				if( logger.isInfoEnabled() )
				{
					logger.info("DATA DATI {}, DATA INIZIO CAMPIONATO {}, DATA FINE CAMPIONATO {}. DATI COMPRESI IN CAMPIONATO ATTIVO {}", formatDateTime(data, "dd/MM/yyyy"), formatDateTime(start , "dd/MM/yyyy"), formatDateTime(fine , "dd/MM/yyyy"), datiInCampionatoAttivo);
				}
				//Recupero gli incontri per la data di riferimento per del file caricato
				List<Incontro> incontri = getIncontriByDate(dataDati);
				//Non dovrebbe mai accadere che sia nullo ma gestiamolo
				if( incontri == null || incontri.isEmpty() )
				{
					if( logger.isWarnEnabled() )
					{
						logger.warn("Nessun incontro schedulato per il giorno {}", formatDateTime(data, "dd/MM/yyyy"));
					}
				}
				else
				{
					DetachedCriteria subQuery = DetachedCriteria.forClass(DatiFiliale.class);
					subQuery.setProjection(Projections.distinct(Projections.property("dataDati")));
					subQuery.addOrder(Order.desc("dataDati"));
					List<Date> date = this.dateIncontriDao.findByDetacheCriteria(subQuery, 0, 2);
					if( date != null && !date.isEmpty() )
					{
						DetachedCriteria dcDatFil = DetachedCriteria.forClass(DatiFiliale.class);
						dcDatFil.createAlias("filiale", "filiale");
						dcDatFil.add(Property.forName("dataDati").in(date));
						ProjectionList plDatFil = Projections.projectionList();
						plDatFil.add(Projections.property("filiale.id"),"idFiliale");
						plDatFil.add(Projections.property("filiale.nomeFiliale"),"nomeFiliale");
						plDatFil.add(Projections.property("re"),"re");
						plDatFil.add(Projections.property("auto"),"auto");
						plDatFil.add(Projections.property("totale"),"totale");
						plDatFil.add(Projections.property("dataDati"),"dataDati");
						dcDatFil.setProjection(plDatFil);
						MatchDbResultTransformers mdrt = new MatchDbResultTransformers();
						dcDatFil.setResultTransformer(mdrt);
						this.mathcDao.findByCriteria(dcDatFil);
						Map<String, MatchDbDto> results = mdrt.getResults();
						for (Incontro incontro : incontri)
						{
							String idIncontro = incontro.getId();
							String idFilialeCasa = incontro.getFilialeCasa().getId();
							String idFilialeFuoriCasa = incontro.getFilialeFuoriCasa().getId();
							Campionato c = incontro.getCampionato();
							MatchDbDto matchDbDtoFilialeCasa = results.get(idFilialeCasa);
							List<DatiMatchFilialeDto> datiFilialiCasa = new ArrayList<>(matchDbDtoFilialeCasa.getDati().values());
							DatiMatchFilialeDto  dmfCasaPrecedente = datiFilialiCasa.get(0);
							DatiMatchFilialeDto  dmfCasaCorrente = datiFilialiCasa.get(1);
							double differenzaTotaleCasa = this.calcolaProduzioneSettimanale(dmfCasaCorrente.getTotale(), dmfCasaPrecedente.getTotale(), idFilialeCasa);
							MatchDbDto matchDbDtoFilialeFuoriCasa = results.get(idFilialeFuoriCasa);
							List<DatiMatchFilialeDto> datiFilialiFuoriCasa = new ArrayList<>(matchDbDtoFilialeFuoriCasa.getDati().values());
							DatiMatchFilialeDto  dmfFuoriCasaPrecedente = datiFilialiFuoriCasa.get(0);
							DatiMatchFilialeDto  dmfFuoriCasaCorrente = datiFilialiFuoriCasa.get(1);
							double differenzaTotaleFuoriCasa = this.calcolaProduzioneSettimanale(dmfFuoriCasaCorrente.getTotale(), dmfFuoriCasaPrecedente.getTotale(), idFilialeFuoriCasa);
							double importoMinimoProduzione = c.getImportoProduzioneMinima();
							if( differenzaTotaleCasa > differenzaTotaleFuoriCasa )
							{
								if( logger.isInfoEnabled() )
								{
									logger.info("INCONTRO CON ID {} VITTORIA IN CASA DELLA FILIALE CON ID {}. ANDAMENTO SETTIMANALE CASA {} ANDAMENTO SETTIMANALE FUORI CASA {} ", idIncontro, idFilialeCasa, differenzaTotaleCasa, differenzaTotaleFuoriCasa);
								}
								//Aggiorno i punti della filiale di casa che è vincente
								Filiale winner = new Filiale();
								winner.setId(idFilialeCasa);
								campionatoFilialeDao.aggiornaPuntiFiliale( c, winner, 3 );
								if( differenzaTotaleFuoriCasa >= importoMinimoProduzione )
								{
									if( logger.isInfoEnabled() )
									{
										logger.info("IMPORTO PRODUZIONE MINIMA {} IMPORTO PRODUZIONE FILIALE PERDENTE {}", importoMinimoProduzione, differenzaTotaleFuoriCasa);
									}
									//Aggiorno i punti della filiale fuori casa che è perdente
									Filiale loser = new Filiale();
									loser.setId(idFilialeFuoriCasa);
									campionatoFilialeDao.aggiornaPuntiFiliale( c, loser, 1 );
								}
								else
								{
									if( logger.isInfoEnabled() )
									{
										logger.info("FILIALE PERDENTE PRODUZIONE MINORE DELLA PRODUZIONE MINIMA. NESSUN PUNTO AGGIUNTO");
									}
								}
								
								
							}
							else if( differenzaTotaleCasa < differenzaTotaleFuoriCasa )
							{
								if( logger.isInfoEnabled() )
								{
									logger.info("INCONTRO CON ID {} VITTORIA FUORI CASA DELLA FILIALE CON ID {}. ANDAMENTO SETTIMANALE CASA {} ANDAMENTO SETTIMANALE FUORI CASA {} ", idIncontro, idFilialeFuoriCasa, differenzaTotaleCasa, differenzaTotaleFuoriCasa);
								}
								//Aggiorno i punti della filiale fuori casa che è vincente
								Filiale winner = new Filiale();
								winner.setId(idFilialeFuoriCasa);
								campionatoFilialeDao.aggiornaPuntiFiliale( c, winner, 3 );
								if( differenzaTotaleCasa >= importoMinimoProduzione )
								{
									if( logger.isInfoEnabled() )
									{
										logger.info("IMPORTO PRODUZIONE MINIMA {} IMPORTO PRODUZIONE FILIALE PERDENTE {}", importoMinimoProduzione, differenzaTotaleFuoriCasa);
									}
									//Aggiorno i punti della filiale fuori casa che è perdente
									Filiale loser = new Filiale();
									loser.setId(idFilialeCasa);
									campionatoFilialeDao.aggiornaPuntiFiliale( c, loser, 1 );
								}
								else
								{
									if( logger.isInfoEnabled() )
									{
										logger.info("FILIALE PERDENTE PRODUZIONE MINORE DELLA PRODUZIONE MINIMA. NESSUN PUNTO AGGIUNTO");
									}
								}
							}
							else
							{
								if( logger.isInfoEnabled() )
								{
									logger.info("INCONTRO CON ID {} PAREGGIO. ANDAMENTO SETTIMANALE CASA {} ANDAMENTO SETTIMANALE FUORI CASA {} ", idIncontro, differenzaTotaleCasa, differenzaTotaleFuoriCasa);
								}
								//Aggiorno i punti di tutte e due le filiali
								Filiale filialeCasa = new Filiale();
								filialeCasa.setId(idFilialeCasa);
								campionatoFilialeDao.aggiornaPuntiFiliale( c, filialeCasa, 1 );
								Filiale filialeFuoriCasa = new Filiale();
								filialeFuoriCasa.setId(idFilialeFuoriCasa);
								campionatoFilialeDao.aggiornaPuntiFiliale( c, filialeFuoriCasa, 1 );								
							}
						}
					}
					else
					{
						if( logger.isWarnEnabled() )
						{
							logger.warn("Nessuna data filiale trovata");
						}
					}
				}
			}
		}
		catch (Exception e)
		{
			String message = "Errore nel calcolo degli incontri per la data "+formatDateTime(new DateTime(dataDati.getTime()), "dd/MM/yyyy");
			logger.error(message, e);
			throw new ArcaContextDbException(message, e);
		}
	}
	private double calcolaProduzioneSettimanale( double produzioneTotaleSettCorrente, double produzioneTotaleSettPrecedente, String idFiliale )
	{
		double result = Precision.round((produzioneTotaleSettCorrente - produzioneTotaleSettPrecedente), 2);
		if( logger.isDebugEnabled() )
		{
			logger.debug("ID FILIALE [{}] PRODUZIONE TOTALE CORRENTE [{}] PRODUZIONE TOTALE SCORSA [{}] PRODUZIONE SETTIMANALE [{}]",idFiliale, produzioneTotaleSettCorrente, produzioneTotaleSettPrecedente, result);
		}
		return result;
	}
	private List<Incontro> getIncontriByDate(Date dataIncontro) throws Exception
	{
		DetachedCriteria dc = DetachedCriteria.forClass(Incontro.class);
		dc.add(Property.forName("dataIncontro").eq(dataIncontro));
		return incontriDao.findByCriteria(dc);
	}
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = true) 
	public DataTableResponse<FilialeDto> ricercaElencoFiliali(String filtroRicerca, int start, int end) throws ArcaContextDbException
	{
		
		ProjectionList pl = Projections.projectionList();
		pl.add(Projections.property("nomeFiliale"), "nomeFiliale");
		pl.add(Projections.property("id"),"id");
		DetachedCriteria dcCoun = DetachedCriteria.forClass(Filiale.class);
		if( StringUtils.hasText(filtroRicerca) )
		{
			dcCoun.add(Property.forName("nomeFiliale").like(filtroRicerca, MatchMode.START).ignoreCase());
		}
		long oggettiTotali = (filialeDao.count(dcCoun)).longValue();
		DetachedCriteria dc = DetachedCriteria.forClass(Filiale.class);
		dc.setProjection(pl);
		dc.addOrder(Order.desc("nomeFiliale"));
		dc.setResultTransformer(Transformers.aliasToBean(FilialeDto.class));
		if( StringUtils.hasText(filtroRicerca) )
		{
			dc.add(Property.forName("nomeFiliale").like(filtroRicerca, MatchMode.START).ignoreCase());
		}
		List<FilialeDto> filiali = filialeDao.findByDtoDetacheCriteria(dc, start, end);
		if( filiali == null || filiali.isEmpty() )
		{
			return null;
		}
		DataTableResponse<FilialeDto> result = new DataTableResponse<FilialeDto>();
		result.setPayload(filiali);
		result.setEsitoOperazione(HttpStatus.OK.value());
		result.setDescrizioneOperazione("Recupero filiali OK");
		result.setRecordsTotal(oggettiTotali);
		return result;
	}	
	@PostConstruct
	public void initialize()
	{
		this.campionatoDao.setPersistentClass(Campionato.class);
		this.campionatoDtoDao.setPersistentClass(CampionatoDbDto.class);
		mathcDao.setPersistentClass(MatchDbDto.class);
		incontriDao.setPersistentClass(Incontro.class);
		dateIncontriDao.setPersistentClass(Date.class);
	}
}
