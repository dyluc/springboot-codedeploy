package com.thenullproject.springbootcodedeploy;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

@Controller
public class TemplateController {

    @Value("${server.port}")
    private String port;

    @Value("${app.props.secret}")
    private String secret;

    @GetMapping("/")
    public String home(Model model) {
        model.addAllAttributes(Map.of(
                "port", port,
                "secret", secret
        ));
        return "home";
    }
}
