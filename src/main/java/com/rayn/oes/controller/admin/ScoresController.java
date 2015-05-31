package com.rayn.oes.controller.admin;

import com.rayn.oes.entities.Score;
import com.rayn.oes.services.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ScoresController
 * Created by rayn on 05/30 2015.
 */
@Controller
@RequestMapping("/admin/scores")
public class ScoresController {
    @Autowired
    private ScoreService scoreService;

    @RequestMapping(method = RequestMethod.GET)
    public String scoresManage(Model model) {
        List<Score> scoreList = scoreService.findAll();
        model.addAttribute("title", "成绩统计 - 在线考试系统");
        model.addAttribute("scoreList", scoreList);
        return "admin/scores";
    }

    @RequestMapping(value = "/del/{score_id}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> deleteScore(@PathVariable int score_id) {
        Map<String, Object> result = new HashMap<>();
        scoreService.delete(score_id);
        result.put("success", true);
        return result;
    }
}
