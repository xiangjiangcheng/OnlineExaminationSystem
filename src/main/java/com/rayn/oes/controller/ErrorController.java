package com.rayn.oes.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * ErrorController
 * Created by rayn on 05/22 2015.
 */
@Controller
@RequestMapping(value = "/error")
public class ErrorController {

    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public String accesssDenied(Model model) {
        model.addAttribute("title", "HTTP Status 403");
        model.addAttribute("message", "访问受限");
        return "error/403";
    }

}
