package com.rayn.oes.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * Subject
 * Created by rayn on 05/13 2015.
 */
@Entity
@Table(name = "subjects")
public class Subject implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(name = "subject_name", nullable = false, unique = true)
    private String subjectName;

    @Column(name = "single_score", nullable = false)
    private int singleScore;

    @Column(name = "single_count", nullable = false)
    private int singleCount;

    @Column(nullable = false)
    private String description;

    @Column(name = "test_time", nullable = false)
    private Integer testTime;

    @OneToMany(mappedBy = "subject", cascade = {CascadeType.PERSIST, CascadeType.REFRESH,
            CascadeType.MERGE})
    @OrderBy("id ASC")
    private Set<Problem> problems = new HashSet<>();

    @OneToMany(mappedBy = "subject", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Score> scores = new HashSet<>();


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public int getSingleScore() {
        return singleScore;
    }

    public void setSingleScore(int singleScore) {
        this.singleScore = singleScore;
    }

    public int getSingleCount() {
        return singleCount;
    }

    public void setSingleCount(int singleCount) {
        this.singleCount = singleCount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getTestTime() {
        return testTime;
    }

    public void setTestTime(Integer testTime) {
        this.testTime = testTime;
    }

    public Set<Problem> getProblems() {
        return problems;
    }

    public void setProblems(Set<Problem> problems) {
        this.problems = problems;
    }

    public Set<Score> getScores() {
        return scores;
    }

    public void setScores(Set<Score> scores) {
        this.scores = scores;
    }
}
