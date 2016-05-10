<?php

require_once 'src/WeatherRequest.php';

class WeatherRequestTest extends PHPUnit_Framework_TestCase
{
    public function testWithAnInvalidAirportCodeAFriendlyMessageIsReturned()
    {
        // Create a stub for the WeatherRequest class.
        $stub = $this->getMockBuilder("WeatherRequest")
                     ->setConstructorArgs(array("area51"))
                     ->setMethods(array('performRequest'))
                     ->getMock();

        // Simulate an error response from wttr.in
        $stub->method('performRequest')
             ->willReturn('ERROR');

        // Assert a friendly error message is returned
        $this->assertEquals("Unable to get weather. Please try another airport code.", $stub->perform());
    }

    public function testWithAValidAirportCodeTheWttrInResponseIsReturned()
    {
        // Create a stub for the WeatherRequest class.
        $stub = $this->getMockBuilder("WeatherRequest")
                     ->setConstructorArgs(array("AUS"))
                     ->setMethods(array("performRequest"))
                     ->getMock();

        // Simulate a valid response from wttr.in    
        $stub->method("performRequest")
             ->willReturn("<h1>wttr.in response</h1>");

        // Assert the wttr.in response is returned
        $this->assertEquals("<h1>wttr.in response</h1>", $stub->perform());
    }

    // ...
}