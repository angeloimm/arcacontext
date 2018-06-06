package it.olegna.arca.context.service;

import java.util.Date;

import it.olegna.arca.context.exception.ArcaContextDbException;

public interface ClassicaCampionatoSvc
{
	void calcolaPunteggiCampionati( Date dataDati ) throws ArcaContextDbException;
}
