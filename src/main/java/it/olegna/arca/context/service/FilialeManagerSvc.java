package it.olegna.arca.context.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import it.olegna.arca.context.dto.DataTableResponse;
import it.olegna.arca.context.dto.FilialeDto;
import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.models.Filiale;

public interface FilialeManagerSvc
{
	void salvaAggiornaFiliale(Filiale filiale) throws ArcaContextDbException;
	List<FilialeDto> ricercaFiliali(DetachedCriteria dc) throws ArcaContextDbException;
	DataTableResponse<FilialeDto> ricercaElencoFiliali(int start, int end) throws ArcaContextDbException;
	Filiale ricercaFilialeByName(String name) throws ArcaContextDbException;
	void salvaAggiornaFilialeAndDati( List<Filiale> filiali ) throws ArcaContextDbException;
	
}
