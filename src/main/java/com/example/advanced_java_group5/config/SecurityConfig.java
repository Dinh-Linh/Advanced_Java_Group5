package com.example.advanced_java_group5.config;

import com.example.advanced_java_group5.filter.AdminAuthFilter;
import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.services.AuthService;
import com.example.advanced_java_group5.services.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
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
    private UserService userService;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .addFilterBefore(customAdminAuthFilter(),
                        SessionManagementFilter.class)
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/admin/login", "/admin/logout").permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/admin/login")
                        .defaultSuccessUrl("/admin")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/admin/logout")
                        .logoutSuccessUrl("/admin/login?logout")
                        .addLogoutHandler(new SecurityContextLogoutHandler())
                        .permitAll()
                );

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(AuthService authService) {
        return username -> {
            try {
                User user = authService.findByEmail(username);
                if (user == null) {
                    throw new UsernameNotFoundException("User not found: " + username);
                }
                return org.springframework.security.core.userdetails.User
                        .withUsername(user.getEmail())
                        .password(user.getPassword())
                        .roles(user.getRole())
                        .build();
            } catch (Exception e) {
                throw new UsernameNotFoundException("Error loading user: " + username, e);
            }
        };
    }

    @Bean
    public AdminAuthFilter customAdminAuthFilter() {
        return new AdminAuthFilter(userService);
    }
}
