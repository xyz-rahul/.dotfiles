# REST - Representational State Transfer
    - Representational State Transfer (REST) 
    - architectural style coined by Roy Fielding

## Key Properties
- **Uniform Interface**: A consistent method for interacting with resources, promoting simplicity and standardization.
- **Statelessness**: Each request from the client to the server must contain all the information needed to understand and process it, independent of any previous requests.

## Client-Server 
client sends a request, server serve it and send response

## HTTP Methods
    GET          Retrieve data
    POST         Create a new resource
    PUT          Update/replace a resource
    PATCH        Partially update a resource
    DELETE       Remove a resource

    OPTIONS      Describe communication options for the target resource
    HEAD         Retrieve headers for a resource



## STATUS CODE  (3-digit code)

    INFORMATION         1xx
    SUCCESS             2xx
    REDIRECTION         3xx
    CLIENT ERROR        4xx
    SERVER ERROR        5xx


## IMPORTANT STATUS CODE
```
200    OK                          # Request was successful.
201    CREATED                     # Resource was successfully created.
204    NO CONTENT                  # Request was successful but there is no content to return.

301    MOVED PERMANENTLY           # Resource has been permanently moved to a new URL.
304    NOT MODIFIED                # Resource has not been modified since the last request.

400    BAD REQUEST                 # The request could not be understood due to malformed syntax.
401    UNAUTHORIZED                # Authentication is required and has failed or has not yet been provided.
403    FORBIDDEN                   # The server understands the request but refuses to authorize it.
404    NOT FOUND                   # The requested resource could not be found.
409    CONFLICT                    # Request could not be completed due to a conflict with the current state of the resource.
410    GONE                        # The resource previously existed but is no longer available.
415    UNSUPPORTED MEDIA TYPE      # The media type of the request is not supported.
429    TOO MANY REQUESTS           # The user has sent too many requests in a given timeframe; should include retry headers.

500    INTERNAL SERVER ERROR       # An unexpected condition was encountered.
503    SERVICE UNAVAILABLE         # The server is temporarily unable to handle the request.
```

## API Endpoint Guidelines
- **Use Plural Nouns for Resources**:
```
    GET    /users                # Retrieve all users
    POST   /users                # Create a new user
    PUT    /users/1              # Update user with ID 1
    DELETE /users/1              # Delete user with ID 1
```

- **Use Logical Nesting for Related Resources**:
```
    GET /articles/{articleId}/comments  # Retrieve comments for a specific article
```

- **Handle Errors Gracefully**:
Return standard error codes such as:
```
    404 Not Found                # Resource not found
    400 Bad Request              # Invalid request data
    500 Internal Server Error    # Unexpected server error
```

- **Implement Filtering, Sorting, and Pagination**: Enhance data retrieval efficiency.
```
  GET /users?age=25&sort=name&page=2&limit=10
```

- **Be Clear with Versioning**: Use versioning in URLs to manage changes to the API.
```
    GET    /v1/users                # Access version 1 of the users endpoint
    GET    /v2/users                # Access version 2 of the users endpoint with new features
```
