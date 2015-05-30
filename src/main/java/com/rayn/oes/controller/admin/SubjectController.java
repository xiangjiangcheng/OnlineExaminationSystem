package com.rayn.oes.controller.admin;

import com.rayn.oes.entities.Problem;
import com.rayn.oes.entities.Subject;
import com.rayn.oes.services.ProblemService;
import com.rayn.oes.services.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * SubjectController
 * Created by rayn on 05/13 2015.
 */
@Controller
@RequestMapping("/admin/paper")
public class SubjectController {
    @Autowired
    private SubjectService subjectService;
    @Autowired
    private ProblemService problemService;

    @RequestMapping(method = RequestMethod.GET)
    public String subjectManager(Model model) {
        List<Subject> paperList = subjectService.findAll();
        model.addAttribute("title", "试卷管理 - 在线考试系统");
        model.addAttribute("paperList", paperList);
        return "admin/paper";
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addSubject(@RequestBody @Valid Subject subject, BindingResult bindingResult) {
        Map<String, Object> result =  new HashMap<>();
        if (bindingResult.hasErrors()) {
            result.put("success", false);
        } else {
            subjectService.create(subject);
            result.put("success", true);
        }
        return result;
    }

    @RequestMapping(value = "/delete/{paper_id}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> deleteSubject(@PathVariable int paper_id) {
        Map<String, Object> result =  new HashMap<>();
        subjectService.delete(paper_id);
        result.put("success", true);
        return result;
    }

    @RequestMapping(value = "/update/{paper_id}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateSubject(@RequestBody @Valid Subject subject, @PathVariable int paper_id,
                                             BindingResult bindingResult) {
        Map<String, Object> result =  new HashMap<>();
        if (bindingResult.hasErrors()) {
            result.put("success", false);
        } else {
            Subject curSubject = subjectService.update(paper_id, subject);
            result.put("success", true);
            result.put("paper", curSubject);
        }
        return result;
    }

    @RequestMapping(value = "/{paper_id}", method = RequestMethod.GET)
    public String manageProblemForSubject(@PathVariable int paper_id, Model model) {
        Subject subject = subjectService.findOne(paper_id);
        List<Problem> problemList = problemService.findAll();
        model.addAttribute("title", "添加题目 - " + subject.getSubjectName());
        model.addAttribute("paper", subject);
        model.addAttribute("problemList", problemList);
        model.addAttribute("answerMap", problemService.getAnswerMap());
        model.addAttribute("weightMap", problemService.getWeightMap());
        return "admin/add_problem";
    }
    @RequestMapping(value = "/{paper_id}/add/{pro_id}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> addProblemForSubject(@PathVariable int paper_id, @PathVariable int pro_id) {
        Map<String, Object> result =  new HashMap<>();
        Subject subject = subjectService.findOne(paper_id);
        if (subject.getProblems().size() >= subject.getSingleCount()) {
            result.put("success", false);
            result.put("upper", true);
            return result;
        }
        Problem problem = problemService.findOne(pro_id);
        problem.setSubject(subject);
        problemService.update(problem);
        result.put("success", true);
        return result;
    }
    @RequestMapping(value = "/del/{pro_id}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> delProblemForSubject(@PathVariable int pro_id) {
        Map<String, Object> result =  new HashMap<>();
        Problem problem = problemService.findOne(pro_id);
        problem.setSubject(null);
        problemService.update(problem);
        result.put("success", true);
        return result;
    }
}
