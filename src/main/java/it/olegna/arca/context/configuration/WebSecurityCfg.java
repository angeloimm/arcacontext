package it.olegna.arca.context.configuration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfTokenRepository;
import org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository;

@Configuration
@EnableWebSecurity
@Import(value= {WebMvcConfig.class, DbConfig.class})
@PropertySource( value={"classpath:config.properties"}, encoding="UTF-8", ignoreResourceNotFound=false)
public class WebSecurityCfg extends WebSecurityConfigurerAdapter
{

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
		.antMatchers("/pages/protected/**")
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
	public PasswordEncoder passwordEncoder()
	{
		BCryptPasswordEncoder webPwdEnc = new BCryptPasswordEncoder();
		return webPwdEnc;
	}
}
