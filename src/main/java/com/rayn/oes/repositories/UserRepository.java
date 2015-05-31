package com.rayn.oes.repositories;

import com.rayn.oes.entities.Role;
import com.rayn.oes.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * UserRepository
 * Created by rayn on 05/09 2015.
 */
public interface UserRepository extends JpaRepository<User, Integer> {
    public User findByUsername(String username);
    public List<User> findByRole(Role role);
}
