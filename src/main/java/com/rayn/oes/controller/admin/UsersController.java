package com.rayn.oes.controller.admin;

import com.rayn.oes.entities.User;
import com.rayn.oes.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * StudentController
 * Created by rayn on 05/30 2015.
 */
@Controller
@RequestMapping(value = "/admin/users")
public class UsersController {
    @Autowired
    private UserService userService;

    @RequestMapping(method = RequestMethod.GET)
    public String studentManage(Model model) {
        Set<User> userSet = userService.findAllStudents();
        model.addAttribute("title", "用户管理 - 在线考试系统");
        model.addAttribute("userSet", userSet);
        return "admin/users";
    }
    @RequestMapping(value = "/del/{student_id}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> deleteStudent(@PathVariable int student_id) {
        Map<String, Object> result = new HashMap<>();
        userService.delete(student_id);
        result.put("success", true);
        return result;
    }
}
