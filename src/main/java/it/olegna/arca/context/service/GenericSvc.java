package it.olegna.arca.context.service;

import it.olegna.arca.context.exception.ArcaContextDbException;

public interface GenericSvc<T>
{
	long getDataProssimoCampionato() throws ArcaContextDbException;
	boolean esisteCampionatoAttivo() throws ArcaContextDbException;
}
