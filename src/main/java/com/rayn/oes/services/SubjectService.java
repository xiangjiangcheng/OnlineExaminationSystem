package com.rayn.oes.services;

import com.rayn.oes.entities.Problem;
import com.rayn.oes.entities.Subject;
import com.rayn.oes.repositories.ProblemRepository;
import com.rayn.oes.repositories.SubjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

/**
 * SubjectService
 * Created by rayn on 05/22 2015.
 */
@Service
@Transactional
public class SubjectService {
    @Autowired
    private SubjectRepository subjectRepository;

    public long count() {
        return subjectRepository.count();
    }
    public Subject findOne(int id) {
        return subjectRepository.findOne(id);
    }
    public List<Subject> findAll() {
        return subjectRepository.findAll();
    }
    public Subject create(Subject subject) {
        return subjectRepository.save(subject);
    }
    public void delete(int id) {
        Subject subject = subjectRepository.findOne(id);
        Set<Problem> problems = subject.getProblems();
        for (Problem problem: problems) {
            problem.setSubject(null);
        }
        subjectRepository.delete(id);
    }
    public Subject update(int id, Subject subject) {
        subject.setId(id);
        return subjectRepository.save(subject);
    }

}
