package com.rayn.oes.repositories;

import com.rayn.oes.entities.Problem;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * ProblemRepository
 * Created by rayn on 05/13 2015.
 */
public interface ProblemRepository extends JpaRepository<Problem, Integer> {
}
