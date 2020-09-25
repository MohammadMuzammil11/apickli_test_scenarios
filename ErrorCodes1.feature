Feature: Error Codes Feature

    Scenario: Success Reponse should come 
        Given I set headers to
            | name          | value          |
            | Content-Type  | application/json|
        When I POST to /quota/post
        Then response header Content-Type should be application/json 
        Then response header Quota-Left should be 2
        Then response header Quota-Exausted should be 1
        Then response header Quota-Reset should exist 
        Then response code should be 200

    Scenario: Success Reponse should come 
        Given I set headers to
            | name          | value          |
            | Content-Type  | application/json|
        When I POST to /quota/post
        Then response header Content-Type should be application/json 
        Then response header Quota-Left should be 1
        Then response header Quota-Exausted should be 2
        Then response header Quota-Reset should exist 
        Then response code should be 200

    Scenario: Success Reponse should come 
        Given I set headers to
            | name          | value          |
            | Content-Type  | application/json|
        When I POST to /quota/post
        Then response header Content-Type should be application/json 
        Then response header Quota-Left should be 0
        Then response header Quota-Exausted should be 3
        Then response header Quota-Reset should exist 
        Then response code should be 200

    Scenario: 509(Bandwidth Limit Exceeded) Error should occur when Accout Limit Exceeded
            Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
        When I POST to /oauth2_verify
        And I set Authorization header to Bearer ABFQcYNAILZ74PxnnMIcm8mPNzY4
        Then response header Content-Type should be application/json 
        Then response body should contain TH99429: API Access quota Exceeded 
        Then response code should be 429

    Scenario: Success Reponse should come 
        Given I set headers to
            | name          | value          |
            | Content-Type  | application/json|
        When I GET /quota/get
        Then response header Content-Type should be application/json 
        Then response code should be 200

    Scenario: Success Reponse should come 
        Given I set headers to
            | name          | value          |
            | Content-Type  | application/json|
        When I GET /quota/get
        Then response header Content-Type should be application/json 
        Then response code should be 200

    ##Spike Arrest Policy
    Scenario: 429-(Too Many Request) Error should occur when we get DDOS Attack Detected from Requestor
        Given I set headers to
            | name          | value           |
            | Content-Type  | application/json|
        When I GET /quota/get
        Then response header Content-Type should be application/json 
        Then response body should contain TH99429: DDOS Attack Detected from Requestor
        Then response code should be 429
