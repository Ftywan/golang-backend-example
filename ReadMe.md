[![CI](https://github.com/Ftywan/golang-backend-example/actions/workflows/go.yml/badge.svg)](https://github.com/Ftywan/golang-backend-example/actions/workflows/go.yml)
# Golang Backend Example
The base project is a simeple Rest API collection using Golang. It can serve as an extendable backend template, with connection to postgresql and redis as the caching layer. 

In addition to the project, a CI pipeline is configured using Github action. Here is the sequence of operations the pipeline performs:
- provision a ubuntu enviroment to execute the pipeline
- download and install the specified go language pack and required packages
- run testing cases defined in the repo
- authenticate and set up google cloud connection
- configure docker and gcp artifacotry
- compile the service and build a docker image
- upload the newly built image to the cloud artifactory for further deployment.

The pipeline will be triggered anytime when there is a new commit submitted or a PR is made to the main branch. At the end of the pipeline, a docker image containing the latest executable file is uploaded to the artifactory. For deployment, ope engineer can choose the corresponding version to deploy new features, or to rollback to a previous stable version. 

original readme contents with set-up guide:
## Requirement
### Docker Environment
- Docker 

### Host Environment  
- Golang 1.14 or later
- PostgreSQL

## How to run

### Running Unit Tests
    
```
make test
```

### Docker Environment
1. Run docker compose command
    ```
    make docker-compose
    ```

### Host Environment
1. Install Golang [https://golang.org/dl/](https://golang.org/dl/)
2. Install PostgreSQL [https://www.postgresql.org/](https://www.postgresql.org/)
3. Change database host on .config.toml file
    ```
    [database]
    host        = "localhost"
    ...........
    ```

4. Login to postgresql
5. Create database *linkaja_test*
    ```
    create database linkaja_test;
    ```
6.  Run program
    ```
    make run
    ```   

### How To Test
1. Check Saldo
   
    Request:
   ```
   curl -XGET 'http://localhost:8000/account/555001' 
   ```
   Response:
   * Success (*200*)
       ```
        {
            "account_number": 555001,
            "customer_name": "Bob Martin",
            "balance": 10000
        }
        ```
   * Data not exists (*404*)
       ```
       Account not exists
       ```
     
2. Transfer
   
    Request:
   ```
   curl -XPOST -H "Content-type: application/json" -d '{"to_account_number":"555002", "amount":100}' 'localhost:8000/account/555001/transfer'
   ```
   Response:
   * Success (*201*)
       ```
       <no content>
       ```
   * Sender not exists (*400*)
       ```
       Sender account not found
       ``` 
   * Receiver not exists (*400*)
     ```
      Receiver account not found
      ``` 
   * Insufficient balance (*400*)
     ```
     Insufficient balance
     ```
