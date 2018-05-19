package it.olegna.arca.context.dto;
import java.io.Serializable;
import java.util.List;

public class BaseResponse<T> implements Serializable
{

	private static final long serialVersionUID = -7368495448380244389L;
	private int esitoOperazione;
	private String descrizioneOperazione;
	private long numeroOggettiTotali;
	private long numeroOggettiRestituiti;
	private List<T> payload;
	
	public BaseResponse()
	{
		super();
	}
	public BaseResponse(int esitoOperazione, String descrizioneOperazione, long numeroOggettiTotali, long numeroOggettiRestituiti, List<T> payload)
	{
		super();
		this.esitoOperazione = esitoOperazione;
		this.descrizioneOperazione = descrizioneOperazione;
		this.numeroOggettiTotali = numeroOggettiTotali;
		this.numeroOggettiRestituiti = numeroOggettiRestituiti;
		this.payload = payload;
	}
	public int getEsitoOperazione()
	{
		return esitoOperazione;
	}
	public void setEsitoOperazione(int esitoOperazione)
	{
		this.esitoOperazione = esitoOperazione;
	}
	public String getDescrizioneOperazione()
	{
		return descrizioneOperazione;
	}
	public void setDescrizioneOperazione(String descrizioneOperazione)
	{
		this.descrizioneOperazione = descrizioneOperazione;
	}
	public long getNumeroOggettiTotali()
	{
		return numeroOggettiTotali;
	}
	public void setNumeroOggettiTotali(long numeroOggettiTotali)
	{
		this.numeroOggettiTotali = numeroOggettiTotali;
	}
	public long getNumeroOggettiRestituiti()
	{
		return numeroOggettiRestituiti;
	}
	public void setNumeroOggettiRestituiti(long numeroOggettiRestituiti)
	{
		this.numeroOggettiRestituiti = numeroOggettiRestituiti;
	}
	public List<T> getPayload()
	{
		return payload;
	}
	public void setPayload(List<T> payload)
	{
		this.payload = payload;
	}
	
	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((descrizioneOperazione == null) ? 0 : descrizioneOperazione.hashCode());
		result = prime * result + (int)esitoOperazione;
		result = prime * result + (int) (numeroOggettiRestituiti ^ (numeroOggettiRestituiti >>> 32));
		result = prime * result + (int) (numeroOggettiTotali ^ (numeroOggettiTotali >>> 32));
		result = prime * result + ((payload == null) ? 0 : payload.hashCode());
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public boolean equals(Object obj)
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BaseResponse other = (BaseResponse) obj;
		if (descrizioneOperazione == null)
		{
			if (other.descrizioneOperazione != null)
				return false;
		}
		else if (!descrizioneOperazione.equals(other.descrizioneOperazione))
			return false;
		if (esitoOperazione != other.esitoOperazione)
			return false;
		if (numeroOggettiRestituiti != other.numeroOggettiRestituiti)
			return false;
		if (numeroOggettiTotali != other.numeroOggettiTotali)
			return false;
		if (payload == null)
		{
			if (other.payload != null)
				return false;
		}
		else if (!payload.equals(other.payload))
			return false;
		return true;
	}
	@Override
	public String toString()
	{
		return "BaseAjaxResponse [esitoOperazione=" + esitoOperazione + ", descrizioneOperazione=" + descrizioneOperazione + ", numeroOggettiTotali=" + numeroOggettiTotali + ", numeroOggettiRestituiti=" + numeroOggettiRestituiti + ", payload=" + payload + "]";
	}
}