package it.olegna.arca.context.configuration;

import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@EnableTransactionManagement
@ComponentScan(basePackages = { "it.olegna.arca.context" })
@Import(CacheConfiguration.class)
@EnableScheduling
public class DbConfig
{
	@Autowired
	private Environment env;
	private Properties hibProps()
	{
		Properties props = new Properties();
		
		props.put(org.hibernate.cfg.Environment.DIALECT, env.getProperty("arca.context.hibernate.dialect"));
		props.put(org.hibernate.cfg.Environment.SHOW_SQL, new Boolean(env.getProperty("arca.context.hibernate.show.sql")));
		props.put(org.hibernate.cfg.Environment.GENERATE_STATISTICS, new Boolean(env.getProperty("arca.context.hibernate.generate.statistics")));
		props.put(org.hibernate.cfg.Environment.FORMAT_SQL, new Boolean(env.getProperty("arca.context.hibernate.format.sql")));
		props.put(org.hibernate.cfg.Environment.HBM2DDL_AUTO, env.getProperty("arca.context.hibernate.ddl.auto"));
		props.put(org.hibernate.cfg.Environment.USE_SECOND_LEVEL_CACHE, new Boolean(env.getProperty("arca.context.hibernate.use.second.cache")));
		props.put(org.hibernate.cfg.Environment.USE_QUERY_CACHE, new Boolean(env.getProperty("arca.context.hibernate.use.query.cache")));
		props.put(org.hibernate.cfg.Environment.CACHE_REGION_FACTORY, env.getProperty("arca.context.hibernate.ehcache.region.factory.class"));
		props.put(org.hibernate.cfg.Environment.STATEMENT_BATCH_SIZE, new Integer(env.getProperty("arca.context.hibernate.batch.size")));
		props.put("hibernate.javax.cache.provider", "org.ehcache.jsr107.EhcacheCachingProvider");
		return props;
	}
	@Bean(name="hikariDs", destroyMethod = "close")
	public DataSource hikariDataSource(){
	    HikariConfig hikariConfig = new HikariConfig();
	    hikariConfig.setDriverClassName(env.getProperty("arca.context.db.driverClassName"));
	    hikariConfig.setJdbcUrl(env.getProperty("arca.context.db.jdbcUrl"));
	    hikariConfig.setUsername(env.getProperty("arca.context.db.username"));
	    hikariConfig.setPassword(env.getProperty("arca.context.db.password"));
	    hikariConfig.setMaximumPoolSize(new Integer(env.getProperty("arca.context.db.maxPoolSize")));
	    hikariConfig.setConnectionTestQuery(env.getProperty("arca.context.db.validationQuery"));
	    hikariConfig.setPoolName("springHikariCP");
	    hikariConfig.setIdleTimeout(new Integer(env.getProperty("arca.context.db.maxIdleTime")));
	    hikariConfig.addDataSourceProperty("dataSource.cachePrepStmts", "true");
	    hikariConfig.addDataSourceProperty("dataSource.prepStmtCacheSize", "250");
	    hikariConfig.addDataSourceProperty("dataSource.prepStmtCacheSqlLimit", "2048");
	    hikariConfig.addDataSourceProperty("dataSource.useServerPrepStmts", "true");
	    HikariDataSource dataSource = new HikariDataSource(hikariConfig);
	    return dataSource;
	}

	@Bean
	public LocalSessionFactoryBean sessionFactory()
	{
		LocalSessionFactoryBean lsfb = new LocalSessionFactoryBean();
		lsfb.setPackagesToScan(new String[]{"it.olegna.arca.context.models"});
		lsfb.setDataSource(this.hikariDataSource());
		lsfb.setHibernateProperties(hibProps());
		return lsfb;
	}
	@Bean("hibTx")
	@Autowired
	public PlatformTransactionManager hibTxMgr(SessionFactory s)
	{
		HibernateTransactionManager result = new HibernateTransactionManager();
		result.setSessionFactory(s);
		return result;
	}
	@Bean("passwordEncoder")
	public PasswordEncoder passwordEncoder() 
	{
		return new BCryptPasswordEncoder();
	}
	 @Bean(initMethod="start",destroyMethod="stop")
	 public org.h2.tools.Server h2WebConsonleServer () throws SQLException {
	   return org.h2.tools.Server.createWebServer("-web","-webAllowOthers","-webDaemon","-webPort", "8082");
	 }	
}