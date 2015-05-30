package com.rayn.oes.services;

import com.rayn.oes.entities.Problem;
import com.rayn.oes.repositories.ProblemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * ProblemService
 * Created by rayn on 05/25 2015.
 */
@Service
@Transactional
public class ProblemService {
    @Autowired
    private ProblemRepository problemRepository;

    private final String[] answerMap = new String[] {"A", "B", "C", "D"};
    private final String[] weightMap = new String[] {"简单", "中等", "难题"};

    public String[] getAnswerMap() {
        return answerMap;
    }
    public String[] getWeightMap() {
        return weightMap;
    }
    public Problem findOne(int id) {
        return problemRepository.findOne(id);
    }
    public List<Problem> findAll() {
        return problemRepository.findAll();
    }
    public Problem create(Problem problem) {
        return problemRepository.save(problem);
    }
    public void delete(int id) {
        problemRepository.delete(id);
    }
    public Problem updateWithId(int id, Problem problem) {
        problem.setId(id);
        return problemRepository.save(problem);
    }
    public Problem update(Problem problem) {
        return problemRepository.save(problem);
    }
}
