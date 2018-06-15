package it.olegna.arca.context.service;

import java.util.Date;
import java.util.List;

import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.web.dto.ClassificaCampionatoDto;
import it.olegna.arca.context.web.dto.IncontroCampionatoDto;

public interface GenericSvc<T>
{
	long getDataProssimoCampionato() throws ArcaContextDbException;
	boolean esisteCampionatoAttivo() throws ArcaContextDbException;
	List<ClassificaCampionatoDto> getClassificheCampionatoAttivo() throws ArcaContextDbException;
	List<IncontroCampionatoDto> getIncontri() throws ArcaContextDbException;
	List<Date> getDateIncontri() throws ArcaContextDbException;
}
