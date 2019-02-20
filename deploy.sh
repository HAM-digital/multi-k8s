docker build -t hamdigital/multi-client:latest -t hamdigital/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hamdigital/multi-server:latest -t hamdigital/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hamdigital/multi-worker:latest -t hamdigital/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hamdigital/multi-client:latest
docker push hamdigital/multi-server:latest
docker push hamdigital/multi-worker:latest

docker push hamdigital/multi-client:$SHA
docker push hamdigital/multi-server:$SHA
docker push hamdigital/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=hamdigital/multi-client:$SHA
kubectl set image deployments/server-deployment server=hamdigital/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=hamdigital/multi-worker:$SHA

