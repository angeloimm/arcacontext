package it.olegna.arca.context.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import it.olegna.arca.context.dto.DatiFilialeDto;
import it.olegna.arca.context.dto.MorrisDataDto;
import it.olegna.arca.context.exception.ArcaContextDbException;

public interface DatiFilialeSvc
{
	List<DatiFilialeDto> ricercaDatiFiliali(DetachedCriteria dc) throws ArcaContextDbException;
	List<MorrisDataDto> ricercaMorrisDatiFiliali(DetachedCriteria dc) throws ArcaContextDbException;
}
