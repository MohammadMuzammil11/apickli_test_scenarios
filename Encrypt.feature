Feature: Test Scenarios for Encryption 

Scenario: 401-(Unauthorized) Error occurs when i pass invalid Api Key
        Given I set headers to
            | name          | value                 |
            | Content-Type  | application/json      |
            | apikey        | mbDqYBRBwo2nTwM5US7jVA|
        When I set body to {"Hello": "World"}
		When I POST to /enc_decapicklitest
        Then response header Content-Type should be application/json
        Then response code should be 401

Scenario: 404-(Not Found) error wiil occur not passing URI path for GET /{order_number}/{account}
	    Given I set User-Agent header to apickli
        When I GET /
        Then response header Content-Type should be application/json
        Then response code should be 404
        
Scenario:  I GET error catchAll when passing bad URI path
		Given I set User-Agent header to apickli
		And I set Content-Type header to application/json
		And I POST to /abc
		Then response code should be 404

Scenario: 405-(Method Not Allowed) Error should occur when i pass wrong method type (passes PATCH but it was GET) 
	    Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
	    And I PATCH /enc_decapicklitest
        Then response code should be 405
        
Scenario: 412-(Precondition Failed) Error should occur when i passes invalid OAuth access token
        Given I set headers to
            | name          | value                           |
            | Content-Type  | application/json                |
            | apikey        | tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu|
            | Authorization | Bearer casjhjinvalidtokenakjcn  |
        When I set body to {"Hello": "World"}
        When I POST to /enc_decapicklitest
        Then response header Content-Type should be application/json 
        Then response code should be 412

## Negative Scenarios for NO Access Token
	Scenario:  I get error when i am not passing an access token
		Given I set headers to
            | name          | value                           |
            | Content-Type  | application/json                |
            | apikey        | tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu|
            | Authorization | Bearer  |
        When I set body to {"Hello": "World"}
        When I POST to /enc_decapicklitest
        Then response header Content-Type should be application/json 
        Then response code should be 412

    ## Negative Scenarios for EXPIRED Access Token
	Scenario:  I GET error when i am passing expired oauth token
		Given I set headers to
            | name          | value                           |
            | Content-Type  | application/json                |
            | apikey        | tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu|
            | Authorization | Bearer casjhjinvalidtokenakjcn  |
        When I set body to {"Hello": "World"}
        When I POST to /enc_decapicklitest
        Then response header Content-Type should be application/json 
        Then response code should be 412

Scenario: 422-(SQL Injection) Error should occur whenever we finds SQL commands in api request
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
            | apikey        | tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu|
            | query         | delete          |
            | Authorization | Bearer n5s9f08Fx40SjZJnpcqxNWxJ7Ycb  |            
        When I POST to /enc_decapicklitest
        Then response header Content-Type should be application/json 
        Then response code should be 422       

###Generate Access Token
###Positive Scenario
Scenario: Sending request with  username and password to generate Oauth Access Token authentication
            Given I have basic authentication credentials tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu and JGVX859A3egHIBB9
            Given I set form parameters to
                | parameter | value |
                |grant_type |client_credentials|
            When I GET /oauthgenerate
            Then response code should be 200

###Negative Scenario
    Scenario: 400(Bad-Request) Error will occurs when u are not passing grant_type
            Given I set User-Agent header to apickli
            Given I have basic authentication credentials tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu and JGVX859A3egHIBB9
            When I GET /oauthgenerate
            Then response code should be 400

    Scenario: Sending request with Invalid Username
            Given I have basic authentication credentials username12 and C7NX9UdNbtHStD5n
            Given I set form parameters to
                | parameter | value |
                |grant_type |client_credentials|
            When I GET /oauthgenerate
            Then response code should be 401

    Scenario: Sending request with Invalid Password
            Given I have basic authentication credentials tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu and JX859A3egHIBB9
            Given I set form parameters to
                | parameter | value |
                |grant_type |client_credentials|
            When I POST to /oauthgenerate
            Then response code should be 401 

    ##Generate JWS
        ##Positive Scenario
        Scenario: Sending a request to Generate JWS
            Given I set User-Agent header to apickli
            Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
            When I POST to /generate_jws
            Then response code should be 200

        ##Negative Scenario
        Scenario: Sending a request Using wrong Method to Generate JWS
            Given I set User-Agent header to apickli
            Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
            When I GET /generate_jws
            Then response code should be 405

        Scenario: Error occurs when not passing JWS Verify token in headers
        Given I set User-Agent header to apickli
		Given I set headers to
            | name          | value                           |
            | Content-Type  | application/json                |
            | apikey        | tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu|
            | Authorization | Bearer n5s9f08Fx40SjZJnpcqxNWxJ7Ycb|
        When I set body to {"Hello": "World"}
        And I POST to /enc_decapicklitest
        Then response code should be 401
        
    Scenario: Testing Encryption Proxy with CORS headers
        Given I set User-Agent header to apickli
		Given I set headers to
            | name          | value                           |
            | Content-Type  | application/json                |
            | apikey        | tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu|
            | Authorization | Bearer n5s9f08Fx40SjZJnpcqxNWxJ7Ycb|
        And I set query parameters to
                         |parameter|value|
                         | JWS           | eyJjcml0IjpbIiJdLCJhbGciOiJIUzI1NiJ9.aGVsbG8.TF7PqrJRxAM7soOmcd8ELownOw4gCOXdPDyHO2F8nnA |
		When I set body to {"Hello": "World"}
		And I POST to /enc_decapicklitest
        Then response header Access-Control-Allow-Methods should exist
        Then response code should be 200

Scenario: 429-(Too Many Request) Error should occur when we give too many request 
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
            | apikey        | tmaVaNujEHFvN2eOAnTG9L5RWQZ2xHKu|
            | Authorization | Bearer n5s9f08Fx40SjZJnpcqxNWxJ7Ycb  |
        When I POST to /enc_decapicklitest
        Then response header Content-Type should be application/json 
        Then response code should be 429