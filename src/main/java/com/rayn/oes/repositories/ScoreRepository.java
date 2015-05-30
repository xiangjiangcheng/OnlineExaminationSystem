package com.rayn.oes.repositories;

import com.rayn.oes.entities.Score;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * ScoreRepository
 * Created by rayn on 05/13 2015.
 */
public interface ScoreRepository extends JpaRepository<Score, Integer> {
}
