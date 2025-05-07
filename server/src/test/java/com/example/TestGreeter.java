package com.example;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import org.junit.jupiter.api.Test;

public class TestGreeter {
    
    @Test
    public void testGreetContains() {
        String result = new Greeter().greet("World");
        assertThat(result, containsString("Hello"));
    }
    
    @Test
    public void testGreetLength() {
        String result = new Greeter().greet("World");
        assertThat(result.length(), greaterThan(5));
    }
}
