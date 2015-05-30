package com.rayn.oes.config;

import com.rayn.oes.auth.CustomAuthenticationProvider;
import com.rayn.oes.auth.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;


/**
 * SecurityConfig
 * Created by rayn on 05/09 2015.
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Bean
    public UserDetailsService userDetailsService() {
        return new CustomUserDetailsService();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        return new CustomAuthenticationProvider(customUserDetailsService);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authenticationProvider());
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/static/**");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authorizeRequests()
                .antMatchers("/hello", "/register").permitAll()
                .antMatchers("/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
            .and().formLogin()
                .loginPage("/hello")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/")
                .failureUrl("/hello?error")
                .usernameParameter("username")
                .passwordParameter("password")
                .permitAll()
            .and().rememberMe()
                .rememberMeParameter("remember-me")
                .key("9D119EE5A2B7DAF6B4DC1EF871D0AC3C")
                .tokenValiditySeconds(60 * 60 * 24 * 7) // remember for one week
            .and().logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/hello?logout")
                .permitAll()
            .and().exceptionHandling()
                .accessDeniedPage("/error/403");
    }
}
