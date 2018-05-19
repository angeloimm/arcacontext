package it.olegna.arca.context.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class MorrisDataDto implements Serializable
{

	private static final long serialVersionUID = 303190775077100149L;
	private List<String> etichette;
	private List<Map<String, Object>> data;
	private List<String> yaxesKeys;
	@JsonIgnore
	private Map<Long, Map<String, Object>> dataContainer;
	
	public MorrisDataDto()
	{
		super();
		this.etichette = new ArrayList<>();
		this.data = new ArrayList<>();
		this.dataContainer = new HashMap<>();
		this.yaxesKeys = new ArrayList<>();
	}
	public Map<Long, Map<String, Object>> getDataContainer()
	{
		return dataContainer;
	}
	public void setDataContainer(Map<Long, Map<String, Object>> dataContainer)
	{
		this.dataContainer = dataContainer;
	}
	public List<String> getEtichette()
	{
		return etichette;
	}
	public void setEtichette(List<String> etichette)
	{
		this.etichette = etichette;
	}

	public List<Map<String, Object>> getData()
	{
		return new ArrayList<>(dataContainer.values());
	}
	public void setData(List<Map<String, Object>> data)
	{
		this.data = data;
	}
	public List<String> getYaxesKeys()
	{
		return yaxesKeys;
	}
	public void setYaxesKeys(List<String> yaxesKeys)
	{
		this.yaxesKeys = yaxesKeys;
	}
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((data == null) ? 0 : data.hashCode());
		result = prime * result + ((etichette == null) ? 0 : etichette.hashCode());
		result = prime * result + ((yaxesKeys == null) ? 0 : yaxesKeys.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj)
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MorrisDataDto other = (MorrisDataDto) obj;
		if (data == null)
		{
			if (other.data != null)
				return false;
		}
		else if (!data.equals(other.data))
			return false;
		if (etichette == null)
		{
			if (other.etichette != null)
				return false;
		}
		else if (!etichette.equals(other.etichette))
			return false;
		if (yaxesKeys == null)
		{
			if (other.yaxesKeys != null)
				return false;
		}
		else if (!yaxesKeys.equals(other.yaxesKeys))
			return false;
		return true;
	}
	@Override
	public String toString()
	{
		return "MorrisDataDto [etichette=" + etichette + ", data=" + data + ", yaxesKeys=" + yaxesKeys + "]";
	}
}
