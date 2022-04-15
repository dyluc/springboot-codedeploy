package com.thenullproject.springbootcodedeploy;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class TemplateControllerIT {

    @Autowired
    private MockMvc mockMvc;

    @Value("${server.port}")
    private String port;

    @Value("${app.props.secret}")
    private String secret;

    @Test
    @DisplayName("Should get home template")
    public void shouldGetHomeTemplate() throws Exception {

        MvcResult mvcResult = mockMvc.perform(
                        get("/")
                                .contentType(MediaType.TEXT_HTML_VALUE))
                .andExpect(status().isOk())
                .andReturn();

        String html = mvcResult.getResponse().getContentAsString();
        String expected = String.format("""
                <html>
                <head>
                                
                    <style>
                        * {
                            font-family: 'Arial', 'sans-serif';
                        }
                    </style>
                                
                </head>
                <body>
                    <h1>Hello World! 🦑</h1>
                    <h3>This application is running on port <span>%s</span>.</h3>
                    <h3>The secret is <span>%s</span>.</h3>
                </body>
                </html>""", port, secret);

        assertEquals(expected, html);
    }
}
