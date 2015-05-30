package com.rayn.oes.controller;

import com.rayn.oes.entities.Score;
import com.rayn.oes.entities.Subject;
import com.rayn.oes.entities.User;
import com.rayn.oes.services.ProblemService;
import com.rayn.oes.services.ScoreService;
import com.rayn.oes.services.SubjectService;
import com.rayn.oes.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * StudentController
 * Created by rayn on 05/13 2015.
 */
@Controller
public class StudentController {
    @Autowired
    private UserService userService;
    @Autowired
    private SubjectService subjectService;
    @Autowired
    private ProblemService problemService;
    @Autowired
    private ScoreService scoreService;

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String index(Model model) {
        List<Subject> paperList = subjectService.findAll();
        User user = userService.getCurrentUser();
        Set<Score> scoreSet = user.getScores();
        for (Score score : scoreSet) {
            for (Subject subject : paperList) {
                if (subject.getId() == score.getSubject().getId()) {
                    paperList.remove(subject);
                    break;
                }
            }
        }
        model.addAttribute("title", "在线考试系统");
        model.addAttribute("paperList", paperList);
        return "home";
    }
    @RequestMapping(value = "/exam/{paper_id}", method = RequestMethod.GET)
    public String exam(@PathVariable int paper_id, Model model) {
        Subject subject = subjectService.findOne(paper_id);
        model.addAttribute("title", "考试 - " + subject.getSubjectName());
        model.addAttribute("paper", subject);
        model.addAttribute("problemList", subject.getProblems());
        model.addAttribute("answerMap", problemService.getAnswerMap());
        model.addAttribute("weightMap", problemService.getWeightMap());
        return "exam";
    }
    @RequestMapping(value = "/exam/{paper_id}/{score}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> examScore(@PathVariable int paper_id, @PathVariable double score) {
        Map<String, Object> result = new HashMap<>();
        User user = userService.getCurrentUser();
        Subject subject = subjectService.findOne(paper_id);
        Score scoreEntity = new Score();
        scoreEntity.setScore(score);
        scoreEntity.setUser(user);
        scoreEntity.setSubject(subject);
        scoreEntity.setEndTime(new Date());
        scoreService.create(scoreEntity);
        result.put("success", true);
        return result;
    }
    @RequestMapping(value = "/history", method = RequestMethod.GET)
    public String history(Model model) {
        User user = userService.getCurrentUser();
        Set<Score> scoreSet = user.getScores();
        model.addAttribute("title", "历史成绩查询 - " + user.getUsername());
        model.addAttribute("user", user);
        model.addAttribute("scoreSet", scoreSet);
        return "history";
    }

    @RequestMapping(value = "/score/del/{score_id}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> deleteScore(@PathVariable int score_id) {
        Map<String, Object> result = new HashMap<>();
        scoreService.delete(score_id);
        result.put("success", true);
        return result;
    }

}
