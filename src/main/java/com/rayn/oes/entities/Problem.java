package com.rayn.oes.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Problem
 * Created by rayn on 05/13 2015.
 */
@Entity
@Table(name = "problems")
public class Problem implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(nullable = false, length = 1024)
    private String description;

    @Column(nullable = false)
    private String A;

    @Column(nullable = false)
    private String B;

    @Column(nullable = false)
    private String C;

    @Column(nullable = false)
    private String D;

    @Column(nullable = true)
    private int answer;

    @Column(nullable = false)
    private int weight;

    @ManyToOne(cascade = {CascadeType.REFRESH, CascadeType.MERGE}, fetch = FetchType.EAGER)
    private Subject subject;

    public int getAnswer() {
        return answer;
    }

    public void setAnswer(int answer) {
        this.answer = answer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getA() {
        return A;
    }

    public void setA(String a) {
        A = a;
    }

    public String getB() {
        return B;
    }

    public void setB(String b) {
        B = b;
    }

    public String getC() {
        return C;
    }

    public void setC(String c) {
        C = c;
    }

    public String getD() {
        return D;
    }

    public void setD(String d) {
        D = d;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }
}
