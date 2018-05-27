package it.olegna.arca.context.service;

import java.util.List;

import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.web.dto.ClassificaCampionatoDto;

public interface GenericSvc<T>
{
	long getDataProssimoCampionato() throws ArcaContextDbException;
	boolean esisteCampionatoAttivo() throws ArcaContextDbException;
	List<ClassificaCampionatoDto> getClassificheCampionatoAttivo() throws ArcaContextDbException;
}
