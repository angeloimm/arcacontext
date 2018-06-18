package it.olegna.arca.context.transformers;

import java.util.Date;

import java.util.List;
import java.util.Map;
import static it.olegna.arca.context.util.TimeUtil.recuperaSettimanaIncontro;
import static it.olegna.arca.context.util.TimeUtil.formatDateTime;
import static it.olegna.arca.context.util.TimeUtil.DATA_FINE_KEY;
import static it.olegna.arca.context.util.TimeUtil.DATA_INIZIO_KEY;

import org.hibernate.transform.ResultTransformer;
import org.joda.time.DateTime;

import it.olegna.arca.context.dto.DataIncontroDto;

public class DataIncontroDtoTransformer implements ResultTransformer
{

	private static final long serialVersionUID = 8716519918173959545L;

	@Override
	public Object transformTuple(Object[] tuple, String[] aliases)
	{
		Date dataIncontro = (Date)tuple[0];
		DateTime dt = new DateTime(dataIncontro.getTime());
		Map<String, Long> settimanaIncontro = recuperaSettimanaIncontro(formatDateTime(dt, "dd/MM/yyyy"));		
		DataIncontroDto did = new DataIncontroDto();
		did.setDataIncontro(dataIncontro);
		did.setDataInizioSettimana(new Date(settimanaIncontro.get(DATA_INIZIO_KEY)));
		did.setDataFineSettimana(new Date(settimanaIncontro.get(DATA_FINE_KEY)));
		return did;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List transformList(List collection)
	{
		return collection;
	}

}
