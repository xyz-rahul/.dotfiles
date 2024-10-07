# SPRING BOOT
Maven is a build and dependency manager. Basically, it allows you to build your
code, while also managing your dependencies for you so that you don't have to
download jars manually.

Spring is the brand for a bunch of different frameworks and libraries.


## Metadata Fields
### Group ID
- **Company Name**
- **Unique Identifier for Your Project** (reverse domain name).
    - **Example**: `com.mycompany`
    - **Guideline**: Use a domain you own to avoid conflicts.
### Artifact ID
- **Name of Your Project/Module** (part of the artifact name).
    - **Example**: `my-app`
    - **Guideline**: Choose a name that clearly indicates the project’s purpose.
### Name
- **Human-readable Project Name**.
    - **Example**: `My Application`
    - **Guideline**: Keep it concise and descriptive.
### Packaging
- **Type of Artifact Produced** (e.g., JAR or WAR).
    - **Example**: `jar`
    - **Guideline**: Use `jar` for Spring Boot apps unless you need a WAR.
### Description
- **Brief Overview of What Your Project Does**.
    - **Example**: A sample Spring Boot application.
    - **Guideline**: Write a clear and informative summary.
    

## Example XML
```xml
<groupId>com.mycompany</groupId>
<artifactId>my-app</artifactId>
<version>1.0.0</version>
<packaging>jar</packaging>
```

## Bean
A bean is an object managed by the Spring Framework within a Java application. It is instantiated, configured, and managed by the Spring IoC (Inversion of Control) container. The lifecycle of a bean is handled by the container, which exemplifies the concept of IoC.

### BEAN SCOPE
Singleton is default scope of bean

## Annotations

### @Configuration
- Declares a class as a "full" configuration class.
- The class must be **non-final** and **public**.

### @Bean
- Declares a bean configuration in a configuration class.
- The method must be **non-final** and **non-private**.

### Example
```java
@Configuration
public class AppConfig {
    
    @Bean
    public UserService userService() {
        return new UserService();
    }

    @Bean("customName")
    public EmployeeService employeeService() {
        return new EmployeeService();
    }
}
```




```txt
    Scope	        Description
    ----------      -------------------------------------------------------------------------------
    singleton       only one instance is created and shared
    prototype       single instance each time bean is requested (like normal java class) 

    request         One instance for lifecycle each HTTP request.                  (webapplication) 
    session         One instance for lifecycle each HTTP Session.                  (webapplication)
    application     One instance for the entire lifecycle of the web application.  (webapplication)
    websocket       single bean is created for lifecycle each WebSocket.           (webapplication)

```

### @Primary Annotation
The `@Primary` annotation in Spring is used to designate a primary bean among multiple beans of the same type. When a primary bean is defined using `@Primary`, it is preferred for injection when no specific bean name or qualifier is provided.

### Example
```java
public interface UserService {
    void getUserInfo();
}

@Component
public class DatabaseUserService implements UserService {
    @Override
    public void getUserInfo() {
        System.out.println("Fetching user info from database.");
    }
}

@Component
@Primary
public class CacheUserService implements UserService {
    @Override
    public void getUserInfo() {
        System.out.println("Fetching user info from cache.");
    }
}
```

## @Qualifier Annotation
The `@Qualifier` annotation is used to specify the exact bean to be injected when multiple beans of the same type are present. It works in conjunction with bean names or custom qualifiers to resolve ambiguity and specify the desired bean for injection.

### Example
```java
@Component
public class ServiceConsumer {
    private final UserService userService;

    public ServiceConsumer(@Qualifier("databaseUserService") UserService userService) {
        this.userService = userService;
    }

    public void performOperation() {
        userService.getUserInfo();
    }
}
```

## @Component Annotation
The `@Component` annotation allows Spring to detect custom beans automatically. It is a class-level annotation that marks a class as a component.

### Meta-Components
- `@Repository`
- `@Service`
- `@Controller`

### Example
```java
@Component("customName")
public class MyComponent {
    // Class implementation
}
```

In other words, without having to write any explicit code, Spring will:
- Scan the application for classes annotated with `@Component`.
- Instantiate them and inject any specified dependencies into them.
- Inject them wherever needed.


### @Autowired Annotation
@Autowired allows Spring to automatically resolve and inject the required dependencies into your Spring-managed beans.

Field Injection:
```java
    @Component
    public class MyService {
        @Autowired
        private MyRepository myRepository; // injected automatically
    }
```

**NOTE**: discouraged makes testing difficult


#### Constructor Injection:
```java
    @Component
    public class MyService {
        private final MyRepository myRepository;

        @Autowired
        public MyService(MyRepository myRepository) {
            this.myRepository = myRepository; // injected automatically
        }
    }
```

#### Setter Injection:
```java
    @Component
    public class MyService {
        private MyRepository myRepository;

        @Autowired
        public void setMyRepository(MyRepository myRepository) {
            this.myRepository = myRepository; // injected automatically
        }
    }
```

#### Optional Dependency: 
You can use the required attribute to specify whether the dependency is mandatory. For example:
```java
    @Autowired(required = false)
    private Optional<MyRepository> myRepository; // can be null if not available
```

## Qualifier Annotation
If there are multiple beans of the same type, you can use @Qualifier to specify which one to inject:
```java
    @Autowired
    @Qualifier("specificRepository")
    private MyRepository myRepository;
```

Here’s the content formatted in Markdown:

## Environment

### Environment API
The Environment API is available through an `ApplicationContext`.

### Example
```java
ApplicationContext ctx = new GenericApplicationContext();
Environment env = ctx.getEnvironment();
boolean containsMyProperty = env.containsProperty("my-property");
System.out.println("Does my environment contain the 'my-property' property? " + containsMyProperty);
```

### @PropertySource Annotation
The `@PropertySource` annotation is used to load properties from a file into the application's environment.

### Example
```java
@Configuration
@PropertySource("classpath:/com/${my.placeholder:default/path}/app.properties")
public class AppConfig {

    @Autowired
    Environment env;

    @Bean
    public TestBean testBean() {
        TestBean testBean = new TestBean();
        testBean.setName(env.getProperty("testbean.name"));
        return testBean;
    }
}
```

# Profiles

Profiles are a way to segregate parts of your application configuration and make it available only in certain environments, such as production, development, etc.

## Defining Profiles
Profiles can be defined in `application.properties` or `application.yml`.

### Naming Convention
- `application-{profile}.properties`
- `application-{profile}.yml`

### Example
#### `application-dev.properties`
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/dev_db
spring.datasource.username=dev_user
spring.datasource.password=dev_pass
```

#### `application-prod.properties`
```properties
spring.datasource.url=jdbc:mysql://prod-db-server:3306/prod_db
spring.datasource.username=prod_user
spring.datasource.password=prod_pass
```

## Activating Profiles
1. Activate the "dev" profile via command line:
   ```bash
   java -jar your-app.jar --spring.profiles.active=dev
   ```

2. Set the active profile using an environment variable:
   ```bash
   export SPRING_PROFILES_ACTIVE=dev
   ```

3. Specify the active profile in the `application.properties` file:
   ```properties
   spring.profiles.active=dev,hsqldb
   ```

## Using @Profile
The `@Profile` annotation is used to conditionally enable or disable beans based on the active profile(s). Any `@Component` or `@Configuration` can be marked with `@Profile` to limit when it is loaded.

### Example
```java
@Configuration
public class DataSourceConfig {

    @Bean
    @Profile("dev")
    public DataSource devDataSource() {
        return new DataSource("jdbc:mysql://localhost:3306/dev_db", "dev_user", "dev_pass");
    }

    @Bean
    @Profile("prod")
    public DataSource prodDataSource() {
        return new DataSource("jdbc:mysql://prod-db-server:3306/prod_db", "prod_user", "prod_pass");
    }
}
```

Here’s the content formatted in Markdown, with additional explanations added:

## @Value Annotation

The `@Value` annotation in Spring is used to inject values into fields from property files, system properties, or even expressions.

### Example Property File: `db.properties`
```properties
db.url=jdbc:mysql://localhost:3306/mydb
db.username=myuser
db.password=mypassword
```

### Using @Value in a Configuration Class
```java
@Configuration
@PropertySource("classpath:database.properties")
public class ApplicationConfig {

    @Value("${db.url}")
    private String url;

    @Value("${db.username}")
    private String username;

    @Value("${db.password}")
    private String password;

    @Bean
    public DataSource dataSource() {
        // Configuration for DataSource using url, username, and password
        return ...; // Provide DataSource implementation
    }
}
```

### Important Notes:
- Ensure the property file is located in the correct classpath for the `@PropertySource` to work.
- Use `${}` syntax for placeholder resolution.

### Using @Value in a Component
```java
@Component
public class MyConfig {

    // String value with default
    @Value("${app.description:Default Description}")
    private String appDescription;

    // String value with default
    @Value("${APP_NAME_NOT_FOUND:Default}")
    private String defaultAppName;

    // List of strings (comma-separated)
    @Value("${app.servers}")
    private List<String> serverList;

    // Calculated double value (circumference of a circle with radius 10)
    @Value("#{2 * T(java.lang.Math).PI * 10}")
    private double circumference;

    // Static string value
    @Value("Test")
    public void printValues(String s, String v) {
        // Both 's' and 'v' will be "Test"
    }
}
```

### Additional Explanations:
- **Default Values**: The syntax `${property:default}` allows for setting a default value if the property is not found.
- **List Injection**: Spring can automatically convert comma-separated values into a `List`.
- **SpEL (Spring Expression Language)**: You can use SpEL to compute values dynamically, as shown with the `circumference` example.
- **Static Values**: Static values can be injected directly without using a placeholder.

### Best Practices:
- Always provide default values where appropriate to prevent application failures due to missing properties.
- Keep property files organized and document the expected properties for easier maintenance.



# SPRING REST

## Spring Boot REST API Annotations

## Overview of Annotations

- **@RestController** (introduced in Spring 4.0)
  - Combines `@Controller` and `@ResponseBody`; indicates that the class is a REST controller.

- **@Controller**
  - Marks a class as a Spring MVC controller; can be used with `@ResponseBody` for JSON responses.

- **@RequestMapping**
  - Maps HTTP requests to handler methods of MVC and REST controllers; can specify method type and path.

- **@GetMapping**
  - Shorthand for `@RequestMapping(method = RequestMethod.GET)`; handles GET requests.

- **@PostMapping**
  - Shorthand for `@RequestMapping(method = RequestMethod.POST)`; handles POST requests.

- **@PutMapping**
  - Shorthand for `@RequestMapping(method = RequestMethod.PUT)`; handles PUT requests.

- **@DeleteMapping**
  - Shorthand for `@RequestMapping(method = RequestMethod.DELETE)`; handles DELETE requests.

- **@PatchMapping**
  - Shorthand for `@RequestMapping(method = RequestMethod.PATCH)`; handles PATCH requests.

- **@PathVariable**
  - Extracts values from the URI path and binds them to method parameters.

- **@RequestParam**
  - Extracts query parameters from the request URL and binds them to method parameters.

- **@RequestHeader**
  - Extracts HTTP headers from the request and binds them to method parameters.

- **@RequestBody**
  - Binds the HTTP request body to a method parameter, typically for POST and PUT requests.

- **@ResponseStatus**
  - Specifies the HTTP status code that should be returned with a response.

- **@ExceptionHandler**
  - Handles exceptions in a controller method and returns appropriate responses.

- **@CrossOrigin**
  - Enables Cross-Origin Resource Sharing (CORS) for the API.

- **@Valid**
  - Indicates that a method parameter should be validated (typically with bean validation).

- **@Autowired**
  - Injects dependencies into the controller.

## Example Class
```java
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/users")  // Maps all requests to this controller to /api/users
public class UserController {

    @Autowired
    private UserService userService;  // Injects the UserService dependency

    @GetMapping("/{id}")  // Handles GET requests for a user by ID
    public User getUser(@PathVariable("id") Long id) {
        return userService.findUserById(id);  // Retrieves the user by ID
    }

    @PostMapping  // Handles POST requests to create a new user
    @ResponseStatus(HttpStatus.CREATED)  // Sets the response status to 201 Created
    public User createUser(@RequestBody @Valid User user) {
        return userService.saveUser(user);  // Saves the new user
    }

    @PutMapping("/{id}")  // Handles PUT requests to update an existing user by ID
    public User updateUser(@PathVariable("id") Long id, @RequestBody @Valid User user) {
        return userService.updateUser(id, user);  // Updates the user with the provided data
    }

    @DeleteMapping("/{id}")  // Handles DELETE requests for a user by ID
    @ResponseStatus(HttpStatus.NO_CONTENT)  // Sets the response status to 204 No Content
    public void deleteUser(@PathVariable("id") Long id) {
        userService.deleteUser(id);  // Deletes the user by ID
    }

    @GetMapping  // Handles GET requests to retrieve all users
    public List<User> getAllUsers(@RequestParam(required = false) String role) {
        return userService.findAllUsers(role);  // Retrieves all users, optionally filtered by role
    }

    @ExceptionHandler(UserNotFoundException.class)  // Handles UserNotFoundException
    @ResponseStatus(HttpStatus.NOT_FOUND)  // Sets the response status to 404 Not Found
    public String handleUserNotFound(UserNotFoundException e) {
        return e.getMessage();  // Returns the exception message
    }
}
```

### Key Points:
- The `UserController` handles CRUD operations for users, leveraging various Spring Boot annotations to map HTTP requests and manage responses.
- Dependency injection is managed using `@Autowired`.
- Error handling is done with `@ExceptionHandler` to return appropriate HTTP status codes and messages.



# Spring Data JPA

## Name
**@Entity** - Requirements for a Java class to be recognized as a JPA entity.

## Synopsis
To define a class as an entity in Spring Boot, it must fulfill the following requirements:

## Description
A Java class intended to be a JPA entity must meet these criteria:

1. **Class Annotation**:  
   The class must be annotated with `@Entity`.

2. **No-Argument Constructor**:  
   A public or protected no-argument constructor must be provided.

3. **Primary Key**:  
   The class must have a field annotated with `@Id`, which serves as the unique identifier (primary key).

4. **Serializable (Recommended)**:  
   The class should implement the `Serializable` interface for potential use in distributed applications.

5. **Field or Property Access**:  
   The entity can use either field access (direct field manipulation) or property access (getter/setter methods). Ensure private fields have appropriate getters and setters if using property access.

6. **Compatible Data Types**:  
   Fields should utilize data types compatible with database column types (e.g., String, int, Long, Date).

## Example
```java
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String email;

    // No-argument constructor
    public User() {}

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
```

## Spring Data JPA Configuration
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/postgres
spring.datasource.username=postgres
spring.datasource.password=password
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.hibernate.ddl-auto=create
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
```

### DDL Auto Options
- **create**: Create a new schema and destroy previous data.
- **create-drop**: Create a new schema and destroy at the end of the session.
- **validate**: Validate the schema and make no changes.
- **update**: Update the schema if necessary.
- **none**: Disable DDL auto.

Hibernate will automatically detect the dialect based on the provided JDBC URL.

### Using Explicit Dialect
If you want to explicitly set the dialect:
```properties
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
```

## Annotations

- **@Entity**: Marks a class as a JPA entity, representing a table in the database.
- **@Table**: Specifies the name and properties of the database table that the entity maps to.
- **@Id**: Indicates the primary key.
- **@GeneratedValue**: Specifies the generation strategy for the primary key.
- **@Column**: Specifies the details of a column in the database.

## GenerationType
`GenerationType` specifies the strategies for generating primary keys in JPA:

### Options
1. **GenerationType.AUTO**:  
   Default generation strategy. Allows the persistence provider to choose the generation method based on the database dialect, generally selecting `GenerationType.SEQUENCE` for popular databases.

2. **GenerationType.IDENTITY**:  
   Relies on an auto-incremented column in the database to generate primary keys.  
   **Cons**: Not performant with Hibernate, as it requires immediate insert statements for each entity, preventing optimization techniques like JDBC batching.

3. **GenerationType.SEQUENCE**:  
   Uses a database sequence to generate unique primary key values.  
   **How It Works**: Requires additional `SELECT` statements to retrieve the next value from a database sequence. By default, Hibernate requests the next value from its built-in sequence but can be customized using the `@SequenceGenerator` annotation.  
   **Example**:
   ```java
   @Id
   @GeneratedValue(strategy = GenerationType.SEQUENCE)
   @SequenceGenerator(name="car_generator", sequenceName = "car_seq", allocationSize=50)
   private Long id;
   ```
   **Pros**:
   - Efficient for most applications, even with additional `SELECT` statements.
   - Allows customization of sequence parameters for fine-tuning.
   
   **Cons**: Requires knowledge of database sequences and configuration.

   **Note**: If you are using MySQL, which doesn't support database sequence objects, Hibernate will fall back to using `GenerationType.TABLE`, which is undesirable since the `TABLE` generation performs badly.

4. **GenerationType.TABLE**:  
   Simulates a sequence by storing and updating its current value in a dedicated database table.  
   **How It Works**: Utilizes a table to manage the current value, requiring pessimistic locks, which enforce sequential access to key values.  
   **Cons**: 
   - Rarely used due to performance drawbacks. The use of locks can significantly slow down applications.
   - Preferable to use `GenerationType.SEQUENCE` when supported by the database.

5. **GenerationType.UUID**:  
   (Details to be added.)







REPOSITORY
----------
                                     interface                                 
                                    Repository                           
                                        ^                                      
                                        |                                      
                  ----------------------------------------------               
                  |                                            |             
               extends                                      extends                  
                  |                                            |             
                  |                                            |             
               interface                                    interface        
       PagingAndSortingRepository                        CrudRepository       
                  ^                                            ^             
                  |                                            |             
                  |                                            |             
               extends                                      extends                  
                  |                                            |             
                  |                                            |             
              interface                                    interface        
     ListPagingAndSortingRepository                   ListCrudRepository      
                  |                                            |             
                  |                                            |             
                  ----------------------------------------------               
                                        |                                      
                                        |                                      
                                    interface                               
                                  JPARepository                               
                                        |                                      
                                     extends                                    
                                        |                                      
                                        |                                      
                                   interface                               
                                StudentRepository                               

--------------------------------------------------------------------------------


# Mappings in Spring Data JPA

## One-to-One
```java
@Entity
public class User {
    @Id
    private Long id;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "profile_id")
    private Profile profile;

    // Getters and setters
}
```

## One-to-Many
```java
@Entity
public class User {
    @Id
    private Long id;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Post> posts;

    // Getters and setters
}
```

### Many-to-One
```java
@Entity
public class Post {
    @Id
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // Getters and setters
}
```

## Many-to-Many
```java
@Entity
public class Student {
    @Id
    private Long id;

    @ManyToMany
    @JoinTable(
        name = "student_course",
        joinColumns = @JoinColumn(name = "student_id"),
        inverseJoinColumns = @JoinColumn(name = "course_id")
    )
    private Set<Course> courses;

    // Getters and setters
}
```

```java
@Entity
public class Course {
    @Id
    private Long id;

    @ManyToMany(mappedBy = "courses")
    private Set<Student> students;

    // Getters and setters
}
```

## Join Column
`@JoinColumn` specifies the foreign key column used for joining.

### Example:
```java
@OneToOne
@JoinColumn(name = "profile_id")
private Profile profile;
```

## Join Table
`@JoinTable` specifies a join table for many-to-many relationships.

### Example:
```java
@ManyToMany
@JoinTable(
    name = "student_course",
    joinColumns = @JoinColumn(name = "student_id"),
    inverseJoinColumns = @JoinColumn(name = "course_id")
)
private Set<Course> courses;
```

## Note
**MappedBy** means this column is mapped by that attribute as a column in that table, and this key is used as a foreign key.



Here’s the content rearranged for clarity and better organization:


# Jackson Annotations and Strategies
[Jackson Annotations Documentation](https://github.com/FasterXML/jackson-annotations?tab=readme-ov-file)

## Overview
- `@JsonIgnore`
- `@JsonManagedReference`
- `@JsonBackReference`
- `@JsonIdentityInfo`
- DTO (Data Transfer Objects)
- ObjectMapper Configuration

## Jackson Annotations

## @JsonProperty
Specifies how a Java object field should be serialized to JSON and deserialized from JSON.



### @JsonIgnore (Preventing Infinite Loops)
Use this annotation to prevent certain fields from being serialized, thus avoiding infinite loops.

#### Example:
```java
@Entity
public class User {
    @Id
    private Long id;

    @OneToMany(mappedBy = "user")
    @JsonIgnore
    private Set<Post> posts; // Getters and setters
}
```

### @JsonManagedReference
Manages parent-child relationships to avoid infinite recursion during serialization.

### @JsonBackReference
Works in conjunction with `@JsonManagedReference` to manage serialization of bidirectional relationships. This annotation means do not go back to the parent.

#### Example:
```java
@Entity
public class User {
    @Id
    private Long id;

    @OneToMany(mappedBy = "user")
    @JsonManagedReference
    private Set<Post> posts; // Getters and setters
}

@Entity
public class Post {
    @Id
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @JsonBackReference
    private User user; // Getters and setters
}
```

### @JsonIdentityInfo
Helps manage object identity during serialization, preventing infinite loops.

#### Example:
```java
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class User {
    @Id
    private Long id;

    @OneToMany(mappedBy = "user")
    private Set<Post> posts; // Getters and setters
}
```
## @Embeddable
Used to embed an embeddable class within an entity.

### Example:
```java
import javax.persistence.Embeddable;

@Embeddable
public class Address {
    private String street;
    private String city;

    // Getters and setters
}

@Entity
public class User {
    @Id
    private Long id;

    @Embedded
    private Address address; // Getters and setters
}
```

## @Transient
Indicates that a field should not be persisted to the database.

### Example:
```java
@Transient
private String temporaryField;
```

## DTO (Data Transfer Objects)
Create DTOs to avoid exposing the full entity graph.

### Example:
```java
public class UserDTO {
    private Long id;
    private String username; // Add only necessary fields
}

// Service method
public UserDTO getUser(Long id) {
    User user = userRepository.findById(id).orElseThrow();
    return new UserDTO(user.getId(), user.getUsername());
}
```

## ObjectMapper Configuration
Configure the Jackson ObjectMapper to handle cyclic references.

### Example:
```java
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

@Bean
public ObjectMapper objectMapper() {
    ObjectMapper mapper = new ObjectMapper();
    // Additional configuration
    return mapper;
}
```


??
---------------------------------

ioc - inversion of control
aop - aspect oriented programming
mvc - 
daf - data access framework

Spring Data JPA Mappings and Infinite Loop Prevention