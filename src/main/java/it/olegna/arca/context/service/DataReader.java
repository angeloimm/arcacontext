package it.olegna.arca.context.service;

import java.io.InputStream;
import java.util.Date;

import it.olegna.arca.context.exception.ArcaContextDataReaderException;
import it.olegna.arca.context.web.dto.DatiFilialiContainer;

public interface DataReader
{
	DatiFilialiContainer dataReader(InputStream is, Date data) throws ArcaContextDataReaderException; 
}
