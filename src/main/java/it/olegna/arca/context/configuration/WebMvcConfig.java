package it.olegna.arca.context.configuration;
import java.io.IOException;
import java.security.KeyStore;
import java.security.cert.CertificateException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.KeyManager;
import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.commons.ssl.KeyMaterial;
import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ApplicationEventMulticaster;
import org.springframework.context.event.SimpleApplicationEventMulticaster;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.task.SimpleAsyncTaskExecutor;
import org.springframework.http.MediaType;
import org.springframework.http.client.BufferingClientHttpRequestFactory;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.ws.soap.SoapVersion;
import org.springframework.ws.soap.axiom.AxiomSoapMessageFactory;
import org.springframework.ws.transport.http.ClientHttpRequestMessageSender;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import it.olegna.arca.context.configuration.util.KeyStoreInfo;
import it.olegna.arca.context.configuration.util.ProxyRoutePlanner;
import it.olegna.arca.context.configuration.util.WsKeepAliveStrategy;
import it.olegna.arca.context.interceptor.LoggingInteceptor;
import ro.isdc.wro.http.ConfigurableWroFilter;
import ro.isdc.wro.http.WroFilter;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages= {"it.eng.tz.arca.context"})
public class WebMvcConfig implements WebMvcConfigurer
{
	private static final Logger logger = LoggerFactory.getLogger(WebMvcConfig.class.getName());
	@Autowired
	private Environment env;
	@Bean(name="multipartResolver") 
	public CommonsMultipartResolver getResolver() throws IOException
	{
		CommonsMultipartResolver resolver = new CommonsMultipartResolver();
		resolver.setMaxUploadSizePerFile(Long.parseLong(env.getProperty("arca.context.max.file.dimension")));

		return resolver;
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry)
	{
		
		registry.addInterceptor(new LoggingInteceptor()).addPathPatterns("/pages/protected/*","/rest/*");
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry)
	{
		registry.addResourceHandler("resources/**").addResourceLocations(new String[] { "resources/" });
		registry.addResourceHandler("adminWebTheme/**").addResourceLocations(new String[] { "adminWebTheme/" });
	}
	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer)
	{
		// Ignoro gli header a considero solo l'estensione del path; per default
		// restituisco un HTML
		Map<String, MediaType> medias = new HashMap<String, MediaType>();
		// la key è l'estensione del path; il valore il media type restituito
		// medias.put("html", MediaType.TEXT_HTML);
		medias.put("json", MediaType.APPLICATION_JSON);
		configurer.favorPathExtension(true).ignoreAcceptHeader(true).defaultContentType(MediaType.TEXT_HTML).mediaTypes(medias);
	}

	@Bean
	public ViewResolver contentNegotiatingViewResolver(ContentNegotiationManager manager)
	{
		ContentNegotiatingViewResolver resolver = new ContentNegotiatingViewResolver();
		resolver.setContentNegotiationManager(manager);
		List<ViewResolver> viewResolvers = new ArrayList<ViewResolver>(2);
		viewResolvers.add(internalResourceViewResolver());
		viewResolvers.add(beanNameViewResolver());
		resolver.setViewResolvers(viewResolvers);
		List<View> defaultViews = new ArrayList<View>(1);
		defaultViews.add(new MappingJackson2JsonView());
		resolver.setDefaultViews(defaultViews);
		return resolver;
	}

	@Bean
	public TilesConfigurer tilesConfigurer()
	{
		TilesConfigurer tilesConfigurer = new TilesConfigurer();
		tilesConfigurer.setDefinitions(new String[] { "/WEB-INF/tiles/tiles-definitions.xml" });
		tilesConfigurer.setCheckRefresh(true);
		return tilesConfigurer;
	}

	@Bean("beanNameViewResolver")
	public ViewResolver beanNameViewResolver()
	{
		BeanNameViewResolver bnvr = new BeanNameViewResolver();
		return bnvr;
	}

	@Bean("internalViewResolver")
	public ViewResolver internalResourceViewResolver()
	{
		InternalResourceViewResolver tvr = new InternalResourceViewResolver();
		tvr.setPrefix("/WEB-INF/jsp/");
		tvr.setSuffix(".jsp");
		return tvr;
	}

	// Resource bundle
	@Bean
	public MessageSource messageSource()
	{
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasename("WEB-INF/bundle/messages");
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setUseCodeAsDefaultMessage(true);
		messageSource.setFallbackToSystemLocale(false);
		return messageSource;
	}
	@Bean("hpRestTemp")
	@Autowired
	public RestTemplate restTemplate(BufferingClientHttpRequestFactory factory)
	{
		RestTemplate result = new RestTemplate(factory);
		List<ClientHttpRequestInterceptor> interceptors = new ArrayList<ClientHttpRequestInterceptor>();
		result.setInterceptors(interceptors);
		return result;
	}

	@Bean
	public ClientHttpRequestFactory requestFactory() throws Exception
	{
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
		factory.setHttpClient(httpClient());
		return factory;
	}

	@Bean
	public BufferingClientHttpRequestFactory bufferingRequestFactory() throws Exception
	{
		return new BufferingClientHttpRequestFactory(requestFactory());
	}

	@Bean
	public HttpClient httpClient() throws Exception
	{
		int timeout = new Integer(env.getProperty("arca.context.web.http.client.timeout"));
		CloseableHttpClient httpClient = null;
		String keystores = env.getProperty("arca.context.certificate");
		PoolingHttpClientConnectionManager pcm = null;
		if (StringUtils.hasText(keystores))
		{
			Resource jsonRes = new ClassPathResource(keystores);
			if (jsonRes.exists())
			{

				List<KeyStoreInfo> ksInfo = objectMapper().readValue(jsonRes.getInputStream(), new TypeReference<List<KeyStoreInfo>>()
				{
				});
				SSLContext sslCtx = SSLContext.getInstance("TLS");
				List<KeyManager> keymanagers = new ArrayList<KeyManager>();
				for (KeyStoreInfo ksi : ksInfo)
				{
					String keystoreName = ksi.getNomeKeyStore();
					String keyStorePwd = ksi.getPasswordKeyStore();
					if (StringUtils.hasText(keystoreName))
					{
						Resource keystoreRes = new ClassPathResource(keystoreName);
						KeyMaterial km = new KeyMaterial(keystoreRes.getInputStream(), keyStorePwd.toCharArray());
						KeyStore clientStore = km.getKeyStore();
						KeyManagerFactory kmfactory = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
						kmfactory.init(clientStore, keyStorePwd != null ? keyStorePwd.toCharArray() : null);
						keymanagers.addAll(Arrays.asList(kmfactory.getKeyManagers()));
					}
				}
				if (!keymanagers.isEmpty())
				{
					// Crediamo a tutti
					X509TrustManager tm = new X509TrustManager()
					{

						@Override
						public void checkClientTrusted(java.security.cert.X509Certificate[] arg0, String arg1) throws CertificateException
						{

						}

						@Override
						public void checkServerTrusted(java.security.cert.X509Certificate[] arg0, String arg1) throws CertificateException
						{

						}

						@Override
						public java.security.cert.X509Certificate[] getAcceptedIssuers()
						{

							return null;
						}

					};
					sslCtx.init(keymanagers.toArray(new KeyManager[keymanagers.size()]), new TrustManager[]
							{ tm }, null);
					SSLConnectionSocketFactory sslConnectionFactory = new SSLConnectionSocketFactory(sslCtx);
					Registry<ConnectionSocketFactory> registry = RegistryBuilder.<ConnectionSocketFactory> create().register("https", sslConnectionFactory).register("http", new PlainConnectionSocketFactory()).build();
					pcm = new PoolingHttpClientConnectionManager(registry);
				}
				else
				{
					if (logger.isInfoEnabled())
					{
						logger.info("Nessun keystore presente nel JSON di configurazione {}. Creo un PoolingHttpClientConnectionManager di default", keystores);
					}
					pcm = new PoolingHttpClientConnectionManager();
				}
			}
		}
		else
		{
			if (logger.isInfoEnabled())
			{
				logger.info("Nessun keystore da caricare. Creo un PoolingHttpClientConnectionManager di default");
			}
			pcm = new PoolingHttpClientConnectionManager();
		}
		HttpClientBuilder hcb = HttpClientBuilder.create();
		pcm.closeIdleConnections(timeout, TimeUnit.MILLISECONDS);
		RequestConfig config = RequestConfig.custom().setConnectionRequestTimeout(timeout).setSocketTimeout(timeout).setConnectTimeout(timeout).build();
		hcb.setDefaultRequestConfig(config);
		hcb.setConnectionManager(pcm).setConnectionManagerShared(true);
		boolean proxyEnable = new Boolean(env.getProperty("arca.context.web.http.client.proxyEnable"));
		if (proxyEnable)
		{
			int proxyPort = new Integer(env.getProperty("arca.context.web.http.client.portProxy"));
			String proxyHost = env.getProperty("arca.context.web.http.client.hostProxy");
			BasicCredentialsProvider credentialProvider = new BasicCredentialsProvider();
			AuthScope scope = new AuthScope(proxyHost, proxyPort);
			String usernameProxy = env.getProperty("arca.context.web.http.client.usernameProxy");
			String passwordProxy = env.getProperty("arca.context.web.http.client.passwordProxy");
			if (StringUtils.hasText(usernameProxy) && StringUtils.hasText(passwordProxy))
			{

				UsernamePasswordCredentials credentials = new UsernamePasswordCredentials(usernameProxy, passwordProxy);
				credentialProvider.setCredentials(scope, credentials);
			}
			ProxyRoutePlanner proxyRoutPlanner = new ProxyRoutePlanner(new HttpHost(proxyHost, proxyPort), env.getProperty("arca.context.web.http.client.urlNotProxy"));
			hcb.setDefaultCredentialsProvider(credentialProvider).setRoutePlanner(proxyRoutPlanner);
		}
		WsKeepAliveStrategy cas = new WsKeepAliveStrategy();
		cas.setTimeout(new Long(timeout));
		hcb.setKeepAliveStrategy(cas);
		httpClient = hcb.build();
		return httpClient;
	}

	@Bean("objectMapper")
	public ObjectMapper objectMapper()
	{
		ObjectMapper mapper = new ObjectMapper();
		return mapper;
	}


	@Bean
	public AxiomSoapMessageFactory axiomSoapMessageFactory()
	{
		AxiomSoapMessageFactory factory = new AxiomSoapMessageFactory();
		factory.setPayloadCaching(true);
		factory.setAttachmentCaching(true);
		factory.setSoapVersion(SoapVersion.SOAP_11);
		return factory;
	}
	@Bean
	public ClientHttpRequestMessageSender clientHttpRequestMessageSender() throws Exception
	{

		ClientHttpRequestMessageSender clientHttpRequestMessageSender = new ClientHttpRequestMessageSender(requestFactory());

		return clientHttpRequestMessageSender;
	}
	@Bean(name= {"applicationEventMulticaster"})
	public ApplicationEventMulticaster simpleApplicationEvtsMulticaster()
	{
		SimpleApplicationEventMulticaster eventMulticaster = new SimpleApplicationEventMulticaster();
		eventMulticaster.setTaskExecutor(new SimpleAsyncTaskExecutor());
		return eventMulticaster;
	}
	@Bean("wroFilter")
	public WroFilter createWroFilter()
	{
		ConfigurableWroFilter cwr = new ConfigurableWroFilter();
		cwr.setProperties(this.createWroProperties());
		return cwr;
	}
	private Properties createWroProperties()
	{
		Properties props = new Properties();
		props.put("debug", env.getProperty("debug"));
		props.put("gzipEnabled", env.getProperty("gzipEnabled"));
		props.put("jmxEnabled", env.getProperty("jmxEnabled"));
		props.put("mbeanName", env.getProperty("mbeanName"));
		props.put("cacheUpdatePeriod", env.getProperty("cacheUpdatePeriod"));
		props.put("modelUpdatePeriod", env.getProperty("modelUpdatePeriod"));
		props.put("disableCache", env.getProperty("disableCache"));
		props.put("encoding", env.getProperty("encoding"));
		return props;
	}
}