[![CI](https://github.com/Ftywan/golang-backend-example/actions/workflows/go.yml/badge.svg)](https://github.com/Ftywan/golang-backend-example/actions/workflows/go.yml)
# Golang Backend Example
The base project is a simple Rest API collection using Golang. It can serve as an extendable backend template, with connections to PostgreSQL and Redis as the caching layer.

In addition to the project, a CI pipeline is configured using Github Actions. Here is the sequence of operations the pipeline performs:

- Provision a Ubuntu environment to execute the pipeline.
- Download and install the specified Go language pack and required packages.
- Run testing cases defined in the repository.
- Authenticate and set up Google Cloud connection.
- Configure Docker and GCP Artifact Registry.
- Compile the service and build a Docker image.
- Upload the newly built image to the cloud Artifact Registry for further deployment.
  
The pipeline will be triggered anytime there is a new commit submitted or a PR is made to the main branch. It can also be triggered manually if needed. At the end of the pipeline, a Docker image containing the latest executable file is uploaded to the Artifact Registry. For deployment, an engineer can choose the corresponding version to deploy new features or to rollback to a previous stable version.

Why the deployment process is not included: To run as expected, the backend service also needs other running database/caching services. A cloud deployment of PostgreSQL to GCP was attempted, and the connection to which requires inevitable certificate setup. Given the complexity of setting up a secret management system in a production environment, the backend sample is only packaged and uploaded to the Artifact Registry. No further deployments are followed up due to the complexity of setting up a database connection/secret management. Even if the Docker image is instantiated into a container, the process will still crash and stop the container.

The following sections are from the original readme contents with the setup guide:
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
