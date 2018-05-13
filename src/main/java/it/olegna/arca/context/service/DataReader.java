package it.olegna.arca.context.service;

import java.io.InputStream;
import java.util.List;

import it.olegna.arca.context.exception.ArcaContextDataReaderException;
import it.olegna.arca.context.models.Filiale;

public interface DataReader
{
	List<Filiale> dataReader(InputStream is) throws ArcaContextDataReaderException; 
}
