package it.olegna.arca.context.configuration.events;

import java.util.Date;

import org.springframework.context.ApplicationEvent;

public class CaricamentoDatiEvent extends ApplicationEvent
{

	private static final long serialVersionUID = -439958563721782966L;
	private Date dataDati;
	public CaricamentoDatiEvent(Object source, Date dataDati)
	{
		super(source);
		this.dataDati = dataDati;
	}
	public Date getDataDati()
	{
		return dataDati;
	}
	public void setDataDati(Date dataDati)
	{
		this.dataDati = dataDati;
	}
}