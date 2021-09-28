package com.example.demogradle.Controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
//import static org.hamcrest.CoreMatchers.is;
//import static org.hamcrest.MatcherAssert.assertThat;

import com.example.demogradle.controller.DemoController;
import org.junit.jupiter.api.Test;

public class  DemoControllerTest{

    public DemoController target = new DemoController();

    @Test
    public void indexの戻り値テスト() {
        String actual = target.index();
        assertEquals("index",actual);
    }
}
