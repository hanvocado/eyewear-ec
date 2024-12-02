package com.eyewear.configs;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.eyewear.entities.User;
import com.eyewear.repositories.UserRepository;

@Service
@Primary
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
       User user = userRepository.findUserByEmail(email);
       
       if(user != null) {
    	   return new CustomUserDetails(user);
       }
       throw new UsernameNotFoundException("User not available");
        
    }
}
