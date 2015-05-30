package com.rayn.oes.controller;

import com.rayn.oes.entities.User;
import com.rayn.oes.services.RoleService;
import com.rayn.oes.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * BaseController
 * Created by rayn on 05/10 2015.
 */
@Controller
public class BaseController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "/")
    public String index() {
        User currentUser = userService.getCurrentUser();
        if (currentUser.getRole().getAuthority().endsWith("ADMIN")) {
            return "redirect:/admin/paper";
        } else {
            return "redirect:/home";
        }
    }
    @RequestMapping(value = "/hello")
    public String hello(Model model) {
        model.addAttribute("title", "登录 - 在线考试系统");
        return "hello";
    }

    @RequestMapping(value = "/helloReg")
    public String helloReg(Model model) {
        model.addAttribute("title", "注册 - 在线考试系统");
        model.addAttribute("reg", true);
        return "hello";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(User user, BindingResult bindingResult, Model model) {
        System.out.println(user.getUsername());
        if (userService.findByUsername(user.getUsername()) != null) {
            model.addAttribute("title", "注册 - 在线考试系统");
            model.addAttribute("exist", true);
            model.addAttribute("reg", true);
            return "hello";
        }
        if (bindingResult.hasErrors()) {
            model.addAttribute("title", "注册 - 在线考试系统");
            model.addAttribute("reg_error", true);
            model.addAttribute("reg", true);
            return "hello";
        }
        user.setRole(roleService.findByAuthority("STU"));
        userService.create(user);
        model.addAttribute("title", "登录 - 在线考试系统");
        return "redirect:/hello?login";
    }
}
