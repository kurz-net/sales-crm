
#!/bin/bash

docker run --rm --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v /home/danielkurz/saleup/software/dashboard/data:/var/lib/postgresql/data postgres

