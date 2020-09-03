Feature: Master Test Scenarios Feature

#####Invalid Error Codes Test Scenarios
Scenario: 411-(Length_Required) Error occurs when i am passing wrong Content-Type that doesn't match's with response payload
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/xml |
        When I GET /oauth2_verify
        Then response code should be 411 
        
        
	Scenario: 400-(Bad Request) Error occurs when i am passing payload in body and giving request with wrong method
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
        And I set body to {"name" : "foo"}
        When I GET  /oauth2_verify
        Then response code should be 400

    ###Use Verify Api Key Policy
    Scenario: 401-(Unauthorized) Error occurs when i pass invalid Api Key
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
		When I GET /oauth2_verify/json?apikey=mbDqYBRBwo2nTwM5US7jVA
        Then response header Content-Type should be application/json
        Then response code should be 401

    ###used Access Control Policy and give valid IPAddress 
    Scenario: 401-(Unauthorized) Error occurs when i attempt to with Unauthorized IP Address
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
            | IPAddress     | 198.90.78.56    |
		When I GET /oauth2_verify/ip
        Then response header Content-Type should be application/json
        Then response code should be 401

     Scenario: 405-(Method Not Allowed) Error should occur when i pass wrong method type (passes PATCH but it was GET) 
	    Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
	   And I PATCH /oauth2_verify
	   Then response code should be 405
    
    Scenario: 412-(Precondition Failed) Error should occur when i passes invalid OAuth access token
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
        And I set Authorization header to Bearer casjhjinvalidtokenakjcn
        When I GET /oauth2_verify/xml
        Then response header Content-Type should be application/json 
        Then response code should be 412

    ###Used Regular Expression Protection policy
    Scenario: 422-(SQL Injection) Error should occur whenever we finds SQL commands in api request
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
            | query         | delete          |
        When I GET /oauth2_verify
        Then response header Content-Type should be application/json 
        Then response code should be 422
    
    Scenario: 429-(Too Many Request) Error should occur when we give too many request 
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
        When I GET /oauth2_verify
        Then response header Content-Type should be application/json 
        Then response code should be 429


    ####Generate Access Token Test Scenarios
    ##Positive
    Scenario: Sending request with  username and password to generate Oauth Access Token authentication
            Given I have basic authentication credentials poeVigXcTsjtVNE8jJkr8AFDFQxtvnM4 and C7NX9UdNbtHStD5n
            Given I set form parameters to
                | parameter | value |
                |grant_type |client_credentials|
            When I POST to /oauthgenerator
            Then response code should be 200  

    ##Negative
    Scenario: Sending request with Invalid Username
            Given I have basic authentication credentials username12 and iF7eiOZDYMniXG2J
            Given I set form parameters to
                | parameter | value |
                |grant_type |client_credentials|
            When I POST to /oauthgenerator
            Then response code should be 401

    Scenario: Sending request with Invalid password
            Given I have basic authentication credentials userpoeVigXcTsjtVNE8jJkr8AFDFQxtvnM4 and passwordin
            Given I set form parameters to
                | parameter | value |
                |grant_type |client_credentials|
            When I POST to /oauthgenerator
            Then response code should be 401


    ##Encryption Test Scenarios
    ###Positive Scenario
    Scenario: i should able to do encryption after giving verfied access token
        Given I set headers to
                | name           | value                              |
                | Authorization  | Bearer 7Qfy6a90Vli9MHBxV1uM2A7fpy7X|
                | Content-Type   | appliation/json                    |
        And I set body to {"name" : "foo"}
        When I POST to /encrypt_decrypt
        Then response code should be 200

    ###Negative Scenario
        Scenario: i should not be able to do encryption after giving invalid access token
        Given I set headers to
                | name           | value                    |
                | Authorization  | Bearer eeYe72TYr5nuAm0EOI|
                | Content-Type   | appliation/json          |
        And I set body to {"name" : "foo"}
        When I POST to /encrypt_decrypt
        Then response code should be 401

    ##Decryption Test Scenarios
    ##### Positive Test Scenario
    Scenario: i should able to do decryption after giving verfied access token
        Given I set headers to
                | name           | value                              |
                | Authorization  | Bearer 7Qfy6a90Vli9MHBxV1uM2A7fpy7X|
                | Content-Type   | appliation/json                    |
        And I set body to {"encryptedKey": "BRonVgvNpJzWemBabJUWBnh4rusazrpIcI0XIrNSpxw="}
        When I POST to /encrypt_decrypt
        Then response code should be 200

    ###Negative Test Scenario
        Scenario: i should not be able to do decryption after giving invalid access token
        Given I set headers to
                | name           | value                    |
                | Authorization  | Bearer eeYe72TYr5nuAm0EOI|
                | Content-Type   | appliation/json          |
        And I set body to {"encryptedKey": "BRonVgvNpJzWemBabJUWBnh4rusazrpIcI0XIrNSpxw="}
        When I POST to /encrypt_decrypt
        Then response code should be 401