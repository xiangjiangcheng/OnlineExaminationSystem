package com.rayn.oes.services;

import com.rayn.oes.entities.Role;
import com.rayn.oes.repositories.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * RoleService
 * Created by rayn on 05/28 2015.
 */
@Service
@Transactional
public class RoleService {
    @Autowired
    private RoleRepository roleRepository;
    public Role findById(int id) {
        return roleRepository.findOne(id);
    }
    public Role findByAuthority(String authority) {
        return roleRepository.findByAuthorityEndingWith(authority);
    }
}
