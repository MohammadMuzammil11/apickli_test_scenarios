Feature: Threat Protection Scenarios Feature

##SQL INJECTION
Scenario: error should occur when i am passing SQL statement in query params
        Given I set User-Agent header to apickli
        And I set test variables
        When I POST to /regex_demo?query=`SQL_INJECTION`
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing SQL statement in headers
        Given I set User-Agent header to apickli
        And I set test variables
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
                | header        | `SQL_INJECTION` |
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing SQL statement in body
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        And I set test variables
        When I set body to {"test" : `SQL_INJECTION`}
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing SQL statement in form params
        Given I set User-Agent header to apickli
        And I set test variables
        Given I set form parameters to
                | parameter     | value           |
                | fparam        | `SQL_INJECTION` |
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500
    
    ###JS/HTML_INJECTION
    Scenario: error should occur when i am passing JS & HTML tags in query params
        Given I set User-Agent header to apickli
        And I set test variables
        When I POST to /regex_demo?query=`JS/HTML_INJECTION`
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing JS & HTML tags in headers
        Given I set User-Agent header to apickli
        And I set test variables
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
                | header        | `JS/HTML_INJECTION` |
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing JS & HTML tags in form params
        Given I set User-Agent header to apickli
        And I set test variables
        Given I set form parameters to
                | parameter     | value           |
                | fparam        | `JS/HTML_INJECTION` |
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing JS & HTML tags in body
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        And I set test variables
        When I set body to {"test" :`JS/HTML_INJECTION`}
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    ###XPATH_INJECTION
    Scenario: error should occur when i am passing XPATH_INJECTION in query params
        Given I set User-Agent header to apickli
        And I set test variables
        When I POST to /regex_demo?query=`XPATH_INJECTION`
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing XPATH_INJECTION in headers
        Given I set User-Agent header to apickli
        And I set test variables
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
                | header        | `XPATH_INJECTION` |
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing XPATH_INJECTION in form params
        Given I set User-Agent header to apickli
        And I set test variables
        Given I set form parameters to
                | parameter     | value           |
                | fparam        |`XPATH_INJECTION`|
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing XPATH_INJECTION in body
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        And I set test variables
        When I set body to {"test" :`XPATH_INJECTION`}
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    ###JAVA_EXCEPTION
    Scenario: error should occur when i am passing JAVA_EXCEPTION in headers
        Given I set User-Agent header to apickli
        And I set test variables
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
                | header        | `JAVA_EXCEPTION` |
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing JAVA_EXCEPTION in body
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        And I set test variables
        When I set body to {"test" :`JAVA_EXCEPTION`}
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing XPATH_INJECTION in form params
        Given I set User-Agent header to apickli
        And I set test variables
        Given I set form parameters to
                | parameter     | value          |
                | Content-Type  | x-www-form-urlencoded|
                | fparam        |`JAVA_EXCEPTION`|
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario: error should occur when i am passing JAVA_EXCEPTION in body
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        And I set test variables
        When I POST to /regex_demo/following-sibling
        Then response header Content-Type should be application/json 
        Then response code should be 500

    ###JSON Threat Protection
    Scenario:error should occur when ObjectEntryCount is exceeds the limit present in JSON Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        When I set body to {"aaaa" :"world","bbbb" : "hello"}
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario:error should occur when ObjectEntryNameLength is exceeds the limit present in JSON Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        When I set body to {"aaaaaaaaaaaaaaaaa" :"world"}
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500 

    Scenario:error should occur when StringValueLength is exceeds the limit present in JSON Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        When I set body to {"aaaa" :"bbbbbbbbbbbbbbbb"}
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario:error should occur when ArrayElementCount is exceeds the limit present in JSON Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        When I set body to {"aaaa" :["abc","world","cde"]}
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario:error should occur when Container Depth is exceeds the limit present in JSON Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/json|
        When I set body to {"foo" :{"foo" :{"foo":"bar"}}}
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    ###XML Threat Protection
        Scenario:error should occur when child count is exceeds the limit present in XML Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/xml |
        When I set body to <Parent><child1>abc</child1><child2>abc2</child2><child3>abc3</child3><child4>abc4</child4></Parent>
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario:error should occur when node depth is exceeds the limit present in XML Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/xml |
        When I set body to <book><title><author><year>2003</year></author></title></book>
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario:error should occur when AttributeCountPerElement is exceeds the limit present in XML Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/xml |
        When I set body to <book name="books" page="20"><title><year>2003</year></title></book>
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario:error should occur when ValueLimits is exceeds the limit present in XML Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/xml |
        When I set body to <book name="books"><title><year>2003200320032003</year></title></book>
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500

    Scenario:error should occur when AttributeValueLimits is exceeds the limit present in XML Threat Protection Policy
        Given I set User-Agent header to apickli
        Given I set headers to
                | name          | value           |
                | Content-Type  | application/xml |
        When I set body to <book name="booksbooks1"><title><year>2003</year></title></book>
        And I set test variables
        When I POST to /regex_demo
        Then response header Content-Type should be application/json 
        Then response code should be 500
    