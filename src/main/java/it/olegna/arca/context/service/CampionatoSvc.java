package it.olegna.arca.context.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.web.dto.CreazioneCampionatoDto;

public interface CampionatoSvc<T>
{
	List<T> findByDc(DetachedCriteria dc, int start, int end) throws ArcaContextDbException;
	Long countByDc(DetachedCriteria dc) throws ArcaContextDbException;
	void salvaEntity( T entity ) throws ArcaContextDbException;
	void salvaEntities( List<T> entities ) throws ArcaContextDbException;
	void creaCampionato( CreazioneCampionatoDto dto ) throws ArcaContextDbException;
	void attivaCampionato() throws ArcaContextDbException;
}
