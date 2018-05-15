package it.olegna.arca.context.dto;
import java.io.Serializable;
import java.util.List;

public class FileUploadResponseDto implements Serializable
{

	private static final long serialVersionUID = 9188702303776340505L;
	private List<UploadedFileDto> files;

	public FileUploadResponseDto()
	{
	}

	public FileUploadResponseDto(List<UploadedFileDto> files)
	{
		super();
		this.files = files;
	}

	public List<UploadedFileDto> getFiles()
	{
		return files;
	}

	public void setFiles(List<UploadedFileDto> files)
	{
		this.files = files;
	}

	@Override
	public String toString()
	{
		return "FileUploadResponseDto [files=" + files + "]";
	}
}