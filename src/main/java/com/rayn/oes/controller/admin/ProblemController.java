package com.rayn.oes.controller.admin;

import com.rayn.oes.entities.Problem;
import com.rayn.oes.services.ProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ProblemController
 * Created by rayn on 05/25 2015.
 */
@Controller
@RequestMapping(value = "/admin/problem")
public class ProblemController {
    @Autowired
    private ProblemService problemService;

    @RequestMapping(method = RequestMethod.GET)
    public String ProblemManager(Model model) {
        List<Problem> problemList = problemService.findAll();
        model.addAttribute("title", "试卷管理 - 在线考试系统");
        model.addAttribute("problemList", problemList);
        model.addAttribute("answerMap", problemService.getAnswerMap());
        model.addAttribute("weightMap", problemService.getWeightMap());
        return "admin/problem";
    }
    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addProblem(@RequestBody @Valid Problem problem, BindingResult bindingResult) {
        Map<String, Object> result = new HashMap<>();
        if (bindingResult.hasErrors()) {
            result.put("success", false);
        } else {
            problemService.create(problem);
            result.put("success", true);
        }
        return result;
    }

    @RequestMapping(value = "/update/{problem_id}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateProblem(@RequestBody @Valid Problem problem, BindingResult bindingResult,
                                             @PathVariable int problem_id) {
        Map<String, Object> result = new HashMap<>();
        if (bindingResult.hasErrors()) {
            result.put("success", false);
        } else {
            Problem curProblem = problemService.updateWithId(problem_id, problem);
            result.put("success", true);
            result.put("problem", curProblem);
        }
        return result;
    }
    @RequestMapping(value = "/delete/{problem_id}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> deleteProblem(@PathVariable int problem_id) {
        Map<String, Object> result = new HashMap<>();
        problemService.delete(problem_id);
        result.put("success", true);
        return result;
    }
}
