package com.rayn.oes.services;

import com.rayn.oes.entities.Role;
import com.rayn.oes.entities.User;
import com.rayn.oes.repositories.RoleRepository;
import com.rayn.oes.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;


/**
 * UserService
 * Created by rayn on 05/09 2015.
 */
@Service
@Transactional
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;

    public User getCurrentUser() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userRepository.getOne(user.getId());
    }
    public User create(User user) {
        return userRepository.save(user);
    }
    public void delete(int id) {
        userRepository.delete(id);
    }
    public User update(User user) {
        return userRepository.save(user);
    }
    public User findById(int id) {
        return userRepository.findOne(id);
    }
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    public Set<User> findAllStudents() {
        return roleRepository.findByAuthorityEndingWith("STU").getUsers();
    }
}
