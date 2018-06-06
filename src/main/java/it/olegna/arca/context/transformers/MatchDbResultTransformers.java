package it.olegna.arca.context.transformers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.transform.ResultTransformer;

import it.olegna.arca.context.web.dto.MatchDbDto;
@SuppressWarnings("rawtypes")
public class MatchDbResultTransformers implements ResultTransformer
{

	private static final long serialVersionUID = 3717158207471110318L;
	private Map<Long, MatchDbDto> results;
	
	public MatchDbResultTransformers()
	{
		super();
		results = new HashMap<>();
	}

	@Override
	public Object transformTuple(Object[] tuple, String[] aliases)
	{
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public List transformList(List collection)
	{
		return new ArrayList<>(results.values());
	}

}
