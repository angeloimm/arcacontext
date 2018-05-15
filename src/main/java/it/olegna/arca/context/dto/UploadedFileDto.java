package it.olegna.arca.context.dto;
import java.io.Serializable;

public class UploadedFileDto implements Serializable
{

	private static final long serialVersionUID = 9144776326140505208L;
	// Valorizzati sempre
	private String name;
	private long size;
	private String id;
	// Valorizzati solo se upload OK
	private String url;
	private String thumbnailUrl;
	private String deleteUrl;
	private String deleteType;
	// Valorizzato solo in caso di errore
	private String error;

	public UploadedFileDto()
	{
	}

	public UploadedFileDto(String id, String name, long size, String url, String thumbnailUrl, String deleteUrl, String deleteType, String error)
	{
		super();
		// Se <= 0 vuol dire che non è stato salvato nella MG
		this.id = id;
		this.name = name;
		this.size = size;
		this.url = url;
		this.thumbnailUrl = thumbnailUrl;
		this.deleteUrl = deleteUrl;
		this.deleteType = deleteType;
		this.error = error;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public long getSize()
	{
		return size;
	}

	public void setSize(long size)
	{
		this.size = size;
	}

	public String getUrl()
	{
		return url;
	}

	public void setUrl(String url)
	{
		this.url = url;
	}

	public String getThumbnailUrl()
	{
		return thumbnailUrl;
	}

	public void setThumbnailUrl(String thumbnailUrl)
	{
		this.thumbnailUrl = thumbnailUrl;
	}

	public String getDeleteUrl()
	{
		return deleteUrl;
	}

	public void setDeleteUrl(String deleteUrl)
	{
		this.deleteUrl = deleteUrl;
	}

	public String getDeleteType()
	{
		return deleteType;
	}

	public void setDeleteType(String deleteType)
	{
		this.deleteType = deleteType;
	}

	public String getError()
	{
		return error;
	}

	public void setError(String error)
	{
		this.error = error;
	}


	@Override
	public String toString()
	{
		return super.toString();
	}
}