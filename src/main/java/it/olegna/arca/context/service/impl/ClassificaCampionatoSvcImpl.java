package it.olegna.arca.context.service.impl;

import static it.olegna.arca.context.util.TimeUtil.formatDateTime;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.commons.math3.analysis.function.Min;
import org.apache.commons.math3.util.Precision;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.transform.Transformers;
import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.olegna.arca.context.dao.GenericDao;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.Campionato;
import it.olegna.arca.context.models.CampionatoFiliale;
import it.olegna.arca.context.models.DatiFiliale;
import it.olegna.arca.context.models.Incontro;
import it.olegna.arca.context.service.ClassicaCampionatoSvc;
import it.olegna.arca.context.transformers.MatchDbResultTransformers;
import it.olegna.arca.context.web.dto.CampionatoDbDto;
import it.olegna.arca.context.web.dto.DatiMatchFilialeDto;
import it.olegna.arca.context.web.dto.MatchDbDto;

@Service
public class ClassificaCampionatoSvcImpl implements ClassicaCampionatoSvc
{
	private static final Logger logger = LoggerFactory.getLogger(ClassificaCampionatoSvcImpl.class.getName());
	@Autowired
	private GenericDao<CampionatoFiliale> campionatoFilialeDao;
	@Autowired
	private GenericDao<Campionato> campionatoDao;
	@Autowired
	private GenericDao<CampionatoDbDto> campionatoDtoDao;
	@Autowired
	private GenericDao<DatiFiliale> datiFilialeDao;
	@Autowired
	private GenericDao<MatchDbDto> mathcDao;
	@Autowired
	private GenericDao<Incontro> incontriDao;	
	@Override
	@Transactional(transactionManager = "hibTx", rollbackFor = ArcaContextDbException.class, readOnly = false) 
	public void calcolaPunteggiCampionati(Date dataDati) throws ArcaContextDbException
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
				DateTime dataPrecedente = data.minusDays(7);
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
					//Recupero i dati della data corrente e di quelli di 7 giorni prima
					List<Date> date = new ArrayList<>();
					date.add(dataDati);
					date.add(new Date(dataPrecedente.getMillis()));
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
					Min minus = new Min();
					for (Incontro incontro : incontri)
					{
						String idIncontro = incontro.getId();
						String idFilialeCasa = incontro.getFilialeCasa().getId();
						String idFilialeFuoriCasa = incontro.getFilialeFuoriCasa().getId();
						MatchDbDto matchDbDtoFilialeCasa = results.get(idFilialeCasa);
						List<DatiMatchFilialeDto> datiFilialiCasa = new ArrayList<>(matchDbDtoFilialeCasa.getDati().values());
						DatiMatchFilialeDto  dmfCasaPrecedente = datiFilialiCasa.get(0);
						DatiMatchFilialeDto  dmfCasaCorrente = datiFilialiCasa.get(1);
						double differenzaTotaleCasa = Precision.round(minus.value(dmfCasaCorrente.getTotale(), dmfCasaPrecedente.getTotale()), 2);
						MatchDbDto matchDbDtoFilialeFuoriCasa = results.get(idFilialeFuoriCasa);
						List<DatiMatchFilialeDto> datiFilialiFuoriCasa = new ArrayList<>(matchDbDtoFilialeFuoriCasa.getDati().values());
						DatiMatchFilialeDto  dmfFuoriCasaPrecedente = datiFilialiFuoriCasa.get(0);
						DatiMatchFilialeDto  dmfFuoriCasaCorrente = datiFilialiFuoriCasa.get(1);
						double differenzaTotaleFuoriCasa = Precision.round(minus.value(dmfFuoriCasaCorrente.getTotale(), dmfFuoriCasaPrecedente.getTotale()), 2);
						if( differenzaTotaleCasa > differenzaTotaleFuoriCasa )
						{
							if( logger.isInfoEnabled() )
							{
								logger.info("INCONTRO CON ID {} VITTORIA IN CASA DELLA FILIALE CON ID {}. ANDAMENTO SETTIMANALE CASA {} ANDAMENTO SETTIMANALE FUORI CASA {} ", idIncontro, idFilialeCasa, differenzaTotaleCasa, differenzaTotaleFuoriCasa);
							}
						}
						else if( differenzaTotaleCasa < differenzaTotaleFuoriCasa )
						{
							if( logger.isInfoEnabled() )
							{
								logger.info("INCONTRO CON ID {} VITTORIA FUORI CASA DELLA FILIALE CON ID {}. ANDAMENTO SETTIMANALE CASA {} ANDAMENTO SETTIMANALE FUORI CASA {} ", idIncontro, idFilialeFuoriCasa, differenzaTotaleCasa, differenzaTotaleFuoriCasa);
							}
						}
						else
						{
							if( logger.isInfoEnabled() )
							{
								logger.info("INCONTRO CON ID {} PAREGGIO. ANDAMENTO SETTIMANALE CASA {} ANDAMENTO SETTIMANALE FUORI CASA {} ", idIncontro, differenzaTotaleCasa, differenzaTotaleFuoriCasa);
							}
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
	private List<Incontro> getIncontriByDate(Date dataIncontro) throws Exception
	{
		DetachedCriteria dc = DetachedCriteria.forClass(Incontro.class);
		dc.add(Property.forName("dataIncontro").eq(dataIncontro));
		return incontriDao.findByCriteria(dc);
	}
	@PostConstruct
	public void initialize()
	{
		this.campionatoDao.setPersistentClass(Campionato.class);
		this.campionatoDtoDao.setPersistentClass(CampionatoDbDto.class);
		this.campionatoFilialeDao.setPersistentClass(CampionatoFiliale.class);
		this.datiFilialeDao.setPersistentClass(DatiFiliale.class);
		mathcDao.setPersistentClass(MatchDbDto.class);
		incontriDao.setPersistentClass(Incontro.class);
	}
}
