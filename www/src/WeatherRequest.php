<?php
class WeatherRequest {
  public function __construct($code) {
    $this->code = $code;
  }

  public function perform() {
    $response = $this->performRequest($this->code);

    return $response === "ERROR" ? "Unable to get weather. Please try another airport code." : $response;
  }

  public function performRequest($code) {
    $curl = curl_init();    

    $url = "http://wttr.in/".$code;
    curl_setopt($curl, CURLOPT_URL, $url);

    $output = curl_exec($curl);

    curl_close($curl);

    return $output;
  }
}