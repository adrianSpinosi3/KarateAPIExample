@Status
Feature: Shorten API capacitacion 2023
  Background:
    Given url urlShort
    And path 'shorten'
    * def body = {"url":"https://google.com/"}
    * def key = {"X-RapidAPI-Key":"ab72d64ebdmshfea109e4fd68075p19ab3cjsn966ab103535c"}

  @Success
  Scenario Outline: Consulta Status code 200 con validacion
    And headers key
    And request body
    And method POST
    And status 200
    Then match <response>
    Examples:
    |response|
    |response.result_url =='#string'|

  @Empty
  Scenario Outline:Se valida la respuesta del Status 400 con url vacia
    And headers key
    And request {}
    And method POST
    And status 400
    Then match <response>
    Examples:
      |response|
      |response == read('classpath:examples/users/response/emptyUrl.json')|

    @invalidUrl
  Scenario Outline:Se valida la respuesta del Status 400 con url no valida
    * def invalidUrl = {"url": "gogle"}
    And headers key
    And request invalidUrl
    And method POST
    And status 400
    Then match <response>
    Examples:
    |response|
    |response == read('classpath:examples/users/response/invalidUrl.json')|

      @invalidToken
  Scenario Outline: Se valida la respuesta del Status 403 Token no valido
    And header X-RapidAPI-Key = 'ab72d64ebdmshfea109e4fd68075p19ab3cjsn966ab10546hc'
    And request body
    And method POST
    And status 403
    Then match <response>

    Examples:
      |response|
      |response == read('classpath:examples/users/response/invalidToken.json')|


