package com.rayn.oes.services;

import com.rayn.oes.entities.User;
import com.rayn.oes.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * UserService
 * Created by rayn on 05/09 2015.
 */
@Service
@Transactional
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public User getCurrentUser() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userRepository.getOne(user.getId());
    }
    public User create(User user) {
        return userRepository.save(user);
    }
    public User findById(int id) {
        return userRepository.findOne(id);
    }
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
}
