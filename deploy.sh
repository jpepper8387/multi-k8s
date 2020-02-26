docker build -t jpepper8387/multi-client:lastest -t jpepper8387/multi-client:$SHA -f  ./client/Dockerfile ./client
docker build -t jpepper8387/multi-server:latest -t jpepper8387/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jpepper8387/multi-worker -t jpepper8387/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jpepper8387/multi-client:latest
docker push jpepper8387/multi-server:latest
docker push jpepper8387/multi-worker:latest

docker push jpepper8387/multi-client:$SHA
docker push jpepper8387/multi-server:$SHA
docker push jpepper8387/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jpepper8387/multi-server:$SHA
kubectl set image deployments/client-deployment client=jpepper8387/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jpepper8387/multi-worker:$SHA
