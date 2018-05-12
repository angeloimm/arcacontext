package it.olegna.arca.context.hibernate.cache.config;
import java.util.Properties;

import javax.cache.Cache;

import org.hibernate.cache.spi.CacheDataDescription;

public class JCacheRegionFactory extends org.hibernate.cache.jcache.JCacheRegionFactory
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1021281213463444167L;

	@Override
	protected Cache<Object, Object> createCache(String regionName, Properties properties, CacheDataDescription metadata)
	{
		throw new IllegalArgumentException("Unknown hibernate cache: " + regionName);
	}
}