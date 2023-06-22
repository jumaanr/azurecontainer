#application stack order
# start with data layer
docker run -d --name=redis redis
docker run -d --name=db postgres

#application services
docker run --name=vote -p 5000:80 voting-app
docker run --name=result -p 5001:80 result-app
docker run --name=worker worker

#But we havent actually linked them together

#asking webapplication to use redis instance, this adds an entry to the /etc/hosts file of voting-app container adding hostname=redis with the internal ip of the redis container
docker run --name=vote -p 5000:80 --link redis:redis voting-app
docker run --name=result -p 5001:80 --link db:db result-app
docker run --name=worker --link db:db --link redis:redis worker
# please note that using links this way has been deprecated
# lets create a docker compose file out of this
