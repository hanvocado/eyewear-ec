package com.eyewear.configs;

import com.eyewear.entities.User;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Arrays;
import java.util.Collection;

public class CustomUserDetails implements UserDetails {

	private static final long serialVersionUID = -4452060929118917376L;
	private User user;

   
    public CustomUserDetails(User user) {
    	super();
        this.user = user;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        String role = "ROLE_" + user.getRoles().toUpperCase();
        SimpleGrantedAuthority authority = new SimpleGrantedAuthority(role);
        return Arrays.asList(authority);
    }


    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getEmail();
    }

    public String getUserId(){
        return user.getId();
    }

    
    public User getUser() {
        return user;
    }
    
}
