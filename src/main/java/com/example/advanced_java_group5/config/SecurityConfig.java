package com.example.advanced_java_group5.config;

import com.example.advanced_java_group5.filter.AdminAuthFilter;
import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.services.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.session.SessionManagementFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final UserService userService;

    public SecurityConfig(UserService userService) {
        this.userService = userService;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .addFilterBefore(adminAuthFilter(), SessionManagementFilter.class)
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/", "/home", "/resources/**", "/css/**", "/js/**", "/img/**", "/vendor/**", "/error").permitAll()
                        .requestMatchers("/admin/login", "/admin/logout").permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().permitAll()
                )
                .formLogin(form -> form
                        .loginPage("/admin/login")
                        .loginProcessingUrl("/admin/login")
                        .usernameParameter("email")
                        .passwordParameter("password")
                        .defaultSuccessUrl("/admin", true)
                        .failureUrl("/admin/login?error=true")
                        .successHandler((request, response, authentication) -> {
                            System.out.println("Đăng nhập thành công: Email=" + authentication.getName() + ", Roles=" + authentication.getAuthorities());
                            response.sendRedirect("/admin");
                        })
                        .failureHandler((request, response, exception) -> {
                            System.out.println("Đăng nhập thất bại: " + exception.getMessage());
                            response.sendRedirect("/admin/login?error=true");
                        })
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/admin/logout")
                        .logoutSuccessUrl("/admin/login?logout=true")
                        .addLogoutHandler(new SecurityContextLogoutHandler())
                        .permitAll()
                )
                .sessionManagement(session -> session
                        .maximumSessions(1)
                        .expiredUrl("/admin/login?expired=true")
                )
                .csrf(csrf -> csrf.disable());

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return username -> {
            System.out.println("UserDetailsService: Tìm kiếm email: " + username);
            User user = userService.getUserByEmail(username);
            if (user == null) {
                System.out.println("UserDetailsService: Không tìm thấy user với email: " + username);
                throw new UsernameNotFoundException("User not found: " + username);
            }
            System.out.println("UserDetailsService: Tìm thấy user: " + user.getEmail() + ", role: " + user.getRole());
            return org.springframework.security.core.userdetails.User
                    .withUsername(user.getEmail())
                    .password(user.getPassword())
                    .roles(user.getRole().replace("ROLE_", "").toUpperCase())
                    .build();
        };
    }

    @Bean
    public AdminAuthFilter adminAuthFilter() {
        return new AdminAuthFilter(userService);
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder authBuilder = http.getSharedObject(AuthenticationManagerBuilder.class);
        authBuilder.authenticationProvider(authenticationProvider());
        return authBuilder.build();
    }

}
