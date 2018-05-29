package it.olegna.arca.context.service;

import java.util.List;

import it.olegna.arca.context.exception.ArcaContextDbException;
import it.olegna.arca.context.web.dto.CampionatoFilialiDto;

public interface MatchScheduleBuilder
{
	void creaCalendarioMatch( List<CampionatoFilialiDto> campionatoFiliali ) throws ArcaContextDbException;
}
