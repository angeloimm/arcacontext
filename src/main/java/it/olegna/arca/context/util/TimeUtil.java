package it.olegna.arca.context.util;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

public class TimeUtil
{
	private static final Logger logger = LoggerFactory.getLogger(TimeUtil.class.getName());
	private static final DateTimeZone EUROPE_ROME_TIME_ZONE = DateTimeZone.forID("Europe/Rome");
	public static String formatDateTime(DateTime dt, String pattern)
	{
		if( !StringUtils.hasText(pattern) )
		{
			pattern = "dd/MM/yyyy";
		}
		DateTimeFormatter formatter = DateTimeFormat.forPattern(pattern);
		String result = formatter.withZone(EUROPE_ROME_TIME_ZONE).print(dt);
		if( logger.isDebugEnabled() )
		{
			logger.debug("DATETIME ["+dt+"] TIMEZONE UTILIZZATO ["+EUROPE_ROME_TIME_ZONE+"] STRINGA COSTRUITA ["+result+"]");
		}		
		return result;
	}
	public static DateTime todayDateTime()
	{
		
		DateTime result = new DateTime(EUROPE_ROME_TIME_ZONE);
		if( logger.isDebugEnabled() )
		{
			logger.debug("TIMEZONE UTILIZZATO ["+EUROPE_ROME_TIME_ZONE+"] DATA COSTRUITA ["+result+"]");
		}
		return result;
	}	
	public static DateTime toDateTime(Long instant)
	{
		if( instant <= 0 )
		{
			throw new IllegalArgumentException("Passata una data in millisecondi non valida <"+instant+">");
		}
		DateTime result = new DateTime(instant, EUROPE_ROME_TIME_ZONE);
		if( logger.isDebugEnabled() )
		{
			logger.debug("DATA IN MILLISECONDI ["+instant+"] TIMEZONE UTILIZZATO ["+EUROPE_ROME_TIME_ZONE+"] DATA COSTRUITA ["+result+"]");
		}
		return result;
	}
	public static DateTime toDateTime(String data, String pattern)
	{
		if( !StringUtils.hasText(data) )
		{
			throw new IllegalArgumentException("Passata una stringa rappresentante la data nulla o vuota <"+data+">");
		}
		if( !StringUtils.hasText(pattern) )
		{
			throw new IllegalArgumentException("Passata una stringa rappresentante il pattern nulla o vuota <"+pattern+">");
		}
		DateTimeFormatter formatter = DateTimeFormat.forPattern(pattern);
		DateTime result = formatter.withZone(EUROPE_ROME_TIME_ZONE).parseDateTime(data);
		//DateTime result = formatter.parseDateTime(data);
		if( logger.isDebugEnabled() )
		{
			logger.debug("STRINGA RAPPRESENTANTE LA DATA ["+data+"] TIMEZONE UTILIZZATO ["+EUROPE_ROME_TIME_ZONE+"] DATA COSTRUITA ["+result+"]");
		}
		return result;	
	}
	public static XMLGregorianCalendar dateTOXMLGregorianCalendar(DateTime date) throws DatatypeConfigurationException
	{

		GregorianCalendar gc = new GregorianCalendar();
		gc.setTimeZone(EUROPE_ROME_TIME_ZONE.toTimeZone());
		gc.setTime(date.toDate());
		XMLGregorianCalendar result = DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
		if( logger.isDebugEnabled() )
		{
			logger.debug("DATA INPUT ["+date+"] TIMEZONE UTILIZZATO ["+gc.getTimeZone()+"] XML GREGORIAN CALENDAR COSTRUITO ["+result+"]");
			
		}
		return result;
	}
	public static Date asDate(XMLGregorianCalendar xmlGC)
	{
		if (xmlGC == null)
		{
			return null;
		}
		else
		{
			GregorianCalendar gc = xmlGC.toGregorianCalendar();
			gc.setTimeZone(EUROPE_ROME_TIME_ZONE.toTimeZone());
			Date result = gc.getTime();
			if( logger.isDebugEnabled() )
			{
				logger.debug("XML GREGORIAN CALENDAR ["+xmlGC+"] DATE ["+result+"] USED DATETIMEZONE ["+EUROPE_ROME_TIME_ZONE+"]");
			}
			return result;
		}
	}
	public static DateTime asDateTime( XMLGregorianCalendar xmlGC )
	{
		if( null == xmlGC )
		{
			return null;
		}
		else
		{
			GregorianCalendar gc = xmlGC.toGregorianCalendar();
			gc.setTimeZone(EUROPE_ROME_TIME_ZONE.toTimeZone());
			DateTime result = new DateTime(xmlGC.toGregorianCalendar().getTime());
			if( logger.isDebugEnabled() )
			{
				logger.debug("XML GREGORIAN CALENDAR ["+xmlGC+"] DATE TIME["+result+"] USED DATETIMEZONE ["+EUROPE_ROME_TIME_ZONE+"]");
			}
			return result;
		}
	}
	public static String formatXmlGregorianCalendar( XMLGregorianCalendar xmlGC, String pattern )
	{
		if( null == xmlGC )
		{
			return null;
		}
		if( !StringUtils.hasText(pattern) )
		{
			return null;
		}
		DateTimeFormatter dtf = DateTimeFormat.forPattern(pattern);
		DateTime dt = asDateTime(xmlGC);
		String result = dtf.withZone(EUROPE_ROME_TIME_ZONE).print(dt);
		if( logger.isDebugEnabled() )
		{
			logger.debug("XML GREGORIAN CALENDAR ["+xmlGC+"] PATTERN ["+pattern+"] RESULT ["+result+"] USED DATETIMEZONE ["+EUROPE_ROME_TIME_ZONE+"]");
		}
		return result;
	}

}