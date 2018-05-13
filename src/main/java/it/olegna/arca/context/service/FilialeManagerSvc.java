package it.olegna.arca.context.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.Filiale;

public interface FilialeManagerSvc
{
	void salvaAggiornaFiliale(Filiale filiale) throws ArcaContextDbException;
	List<FilialeDto> ricercaFiliali(DetachedCriteria dc) throws ArcaContextDbException;
}
