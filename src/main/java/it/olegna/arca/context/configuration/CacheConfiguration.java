package it.olegna.arca.context.configuration;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.cache.CacheManager;
import javax.cache.Caching;
import javax.persistence.Entity;

import org.ehcache.config.builders.CacheConfigurationBuilder;
import org.ehcache.config.builders.ResourcePoolsBuilder;
import org.ehcache.core.config.DefaultConfiguration;
import org.ehcache.expiry.Expirations;
import org.ehcache.jsr107.EhcacheCachingProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.jcache.JCacheCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.core.type.filter.AnnotationTypeFilter;

@Configuration
@EnableCaching
public class CacheConfiguration extends CachingConfigurerSupport
{
	@Autowired
	private Environment env;
	@Bean("cacheManager")
	@Override
	public org.springframework.cache.CacheManager cacheManager()
	{

		return new JCacheCacheManager(createCacheManager());
	}
	private CacheManager createCacheManager()
	{
		long dimensioneCache = new Long(env.getProperty("arca.context.cache.size"));
		long ttlMillisecondi = new Long(env.getProperty("arca.context.cache.ttl"));
		org.ehcache.config.CacheConfiguration<Object, Object> cacheConfiguration = CacheConfigurationBuilder.
																								newCacheConfigurationBuilder(Object.class, Object.class, 
																								ResourcePoolsBuilder.heap(dimensioneCache)
																								).withExpiry(Expirations.timeToLiveExpiration(new org.ehcache.expiry.Duration(ttlMillisecondi, TimeUnit.MILLISECONDS))).build();
		Map<String, org.ehcache.config.CacheConfiguration<?, ?>> caches = createCacheConfigurations(cacheConfiguration);
		//Creo la cache di hibernate org.hibernate.cache.spi.UpdateTimestampsCache. 
		//Dalla documentazione di hibernate https://docs.jboss.org/hibernate/orm/5.2/userguide/html_single/Hibernate_User_Guide.html#caching
		//Questa cache non dovrebbe mai spirare
		ResourcePoolsBuilder rpb = ResourcePoolsBuilder.heap(dimensioneCache*1000000);
		org.ehcache.config.CacheConfiguration<Object, Object> eternalCacheConfiguration = CacheConfigurationBuilder.newCacheConfigurationBuilder(Object.class, Object.class, rpb).withExpiry(Expirations.noExpiration()).build();
		caches.put("org.hibernate.cache.spi.UpdateTimestampsCache", eternalCacheConfiguration);
		//Aggiungo la cache per i codici domanda
		EhcacheCachingProvider provider = getCachingProvider();
		DefaultConfiguration configuration = new DefaultConfiguration(caches, provider.getDefaultClassLoader());
		CacheManager result = provider.getCacheManager(provider.getDefaultURI(), configuration);
		return result;
	}

	private Map<String, org.ehcache.config.CacheConfiguration<?, ?>> createCacheConfigurations(org.ehcache.config.CacheConfiguration<Object, Object> cacheConfiguration)
	{
		Map<String, org.ehcache.config.CacheConfiguration<?, ?>> caches = new HashMap<>();
		// Ricerco tutte le entity con annotazione @Entity per creare le apposite
		// regioni di caching
		ClassPathScanningCandidateComponentProvider scanner = new ClassPathScanningCandidateComponentProvider(false);
		scanner.addIncludeFilter(new AnnotationTypeFilter(Entity.class));
		for (BeanDefinition bd : scanner.findCandidateComponents("it.olegna.arca.context.models"))
		{
			String className = bd.getBeanClassName();
		}
		//Creo la cache di hibernate org.hibernate.cache.internal.StandardQueryCache
		caches.put("org.hibernate.cache.internal.StandardQueryCache", cacheConfiguration);
		return caches;
	}
	
	private EhcacheCachingProvider getCachingProvider()
	{
		return (EhcacheCachingProvider) Caching.getCachingProvider();
	}
}