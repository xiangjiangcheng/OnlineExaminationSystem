package com.rayn.oes.repositories;

import com.rayn.oes.entities.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * RoleRepository
 * Created by rayn on 05/13 2015.
 */
public interface RoleRepository extends JpaRepository<Role, Integer> {
    public Role findByAuthorityEndingWith(String authority);
}
