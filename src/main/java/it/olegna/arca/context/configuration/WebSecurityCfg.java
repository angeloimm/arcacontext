package it.olegna.arca.context.configuration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfTokenRepository;
import org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

@Configuration
@EnableWebSecurity
@Import(value= {WebMvcConfig.class, DbConfig.class})
@PropertySource( value={"classpath:configuration.properties"}, encoding="UTF-8", ignoreResourceNotFound=false)
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled=true)
public class WebSecurityCfg extends WebSecurityConfigurerAdapter
{
	@Override
	public void configure(WebSecurity web) throws Exception {
		
		super.configure(web);
		web.httpFirewall(this.allowUrlEncodedSlashHttpFirewall());
	}
	@Bean
    public HttpFirewall allowUrlEncodedSlashHttpFirewall()
    {

      StrictHttpFirewall firewall = new StrictHttpFirewall();
      firewall.setAllowUrlEncodedSlash(true);
      firewall.setAllowSemicolon(true);
      return firewall;

    } 
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception
	{
		auth
			.inMemoryAuthentication()
			.withUser("s.dipalma")
			.password("{noop}s.dipalma")
			.roles("ADMIN","USER","SUPER_ADMIN");
	}
	private CsrfTokenRepository csrfTokenRepository() 
	{ 
	    HttpSessionCsrfTokenRepository repository = new HttpSessionCsrfTokenRepository(); 
	    repository.setSessionAttributeName("_csrf");
	    return repository; 
	}
	@Override
	protected void configure(HttpSecurity http) throws Exception
	{

		http
		.authorizeRequests()
		.antMatchers("/resources/**")
		.permitAll()
		.antMatchers("/pages/protected/**", "/rest/protected/**")
		.access("hasAnyRole('ADMIN','USER','SUPER_ADMIN')")
		.and()
		.formLogin()
		.loginPage("/pages/loginPage")
		.permitAll()
		.usernameParameter("username")
		.passwordParameter("password")
		.defaultSuccessUrl("/pages/protected/adminHome")
		.failureUrl("/pages/loginPage?error")
		.loginProcessingUrl("/login")
		.and()
		.logout()
		.permitAll()
		.logoutSuccessUrl("/pages/loginPage?logout")
		.and()
		.csrf()
		.csrfTokenRepository(this.csrfTokenRepository())
		.and()
		.exceptionHandling()
		.accessDeniedPage("/pages/accessDenied");
	}
	@Bean
	public PasswordEncoder delegatingPasswordEncoder() {
	    
	    return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}
