package com.rayn.oes.services;

import com.rayn.oes.entities.Score;
import com.rayn.oes.repositories.ScoreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * ScoreService
 * Created by rayn on 05/27 2015.
 */
@Service
@Transactional
public class ScoreService {
    @Autowired
    private ScoreRepository scoreRepository;

    public Score create(Score score) {
        return scoreRepository.save(score);
    }
    public void delete(int id) {
        scoreRepository.delete(id);
    }
}
