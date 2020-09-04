Feature: Master Test Scenarios Feature

#####Invalid Error Codes Test Scenarios####
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

    Scenario: 404-(Not Found) error wiil occur not passing URI path for GET /{order_number}/{account}
	    Given standard oauth tokens are set
        When I GET /
        Then response header Content-Type should be application/json
		Then response code should be 404

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

    ####Other Negative Test Scenarios####
    ## Negative Scenarios for NO Access Token
	Scenario:  I GET error when not passing an access token
		Given I set Authorization header to Bearer
		And I set Content-Type header to application/json
		And I set query parameters to
                         |parameter|value|
                         |customerAcctId|1234|
		And I POST to /custID
		Then response code should be 401

    ## Negative Scenarios for EXPIRED Access Token
	Scenario:  I GET error when passing expired oauth token
		Given I set Authorization header to Bearer YgDvUEMBgJL5cQmwUAk4Er8gQEAl
		And I set Content-Type header to application/json
		And I set headers to
                         |parameter|value|
                         |customerAcctId|1234|
		And I POST to /custID
		Then response code should be 401

    ## Negative Scenarios for INVALID access token
	Scenario:  I GET error when passing invalid oauth token
		Given I set Authorization header to Bearer @#$%^&**************
		And I set Content-Type header to application/json
		And I set query parameters to
                         |parameter|value|
                         |customerAcctId|1234|
		And I POST to /custID
		Then response code should be 401

    ## Negative Scenario for catchAll policy enforce when passing wrong URI
	Scenario:  I GET error catchAll when passing bad URI path
		Given standard oauth tokens are set
		And I set Content-Type header to application/json
		And I POST to /abc
		Then response code should be 404

    ## Negative Scenario for when I do not pass form parameters
	Scenario:  I POST /BipXmlToJson and get 400 status code when I do not pass form parameters
		Given standard oauth tokens are set
       	And I set Content-Type header to multipart/form-data; boundary=<calculated when request is sent>
		When I POST to /BipXmlToJson
		Then response code should be 400
------------------------------------------------------------------------------------------------------------------
    ####Success Status Code Scenarios####
    Scenario: Testing CORS headers
        Given standard oauth tokens are set
		And I set Content-Type header to application/json
		When I set body to {"contractId":"","shipWhseId":"86","product":[{"productId":"31523","qty":"2"},{"productId":"43365","qty":"5"}]}
		And I set headers to
                         |parameter|value|
                         |customerAcctId|1234|
		And I POST to /custID
  		 Then response header Access-Control-Allow-Origin should exist
  		 Then response header Access-Control-Allow-Credentials should exist
  		 Then response header Access-Control-Allow-Headers should exist
  		 Then response header Access-Control-Max-Age should exist
  		 Then response header Access-Control-Allow-Methods should exist

    Scenario:Testing creditcard details
		Given standard oauth tokens are set
		And I set Content-Type header to application/json
		When I set body to {"contractId":"","shipWhseId":"86","product":[{"productId":"31523","qty":"2"},{"productId":"43365","qty":"5"}]}
		And I set query parameters to
                         |parameter|value|
                         |customerAcctId|1234|
		And I POST to /custID
		Then response code should be 200
		Then response header server should not exist

    Scenario:  I GET /metadata and get a valid xml response with 200 status code
		Given standard oauth tokens are set
		Given I set query parameters to
              | parameter | value  |
              | account| 474 |
        When I GET /metadata
        Then response header Content-Type should be application/xml
		Then response code should be 200
		Then response header authorization should not exist
		Then response header Server should not exist
------------------------------------------------------------------------------------------------------------------
    ####Generate Access Token Test Scenarios#####
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
-----------------------------------------------------------------------------------------------------------------
    ##Encryption Test Scenarios##
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

    ##Decryption Test Scenarios##
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