docker build -t jonathanz25/multi-client:latest -t jonathanz25/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jonathanz25/multi-server:latest -t jonathanz25/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jonathanz25/multi-worker:latest -t jonathanz25/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jonathanz25/multi-client:latest
docker push jonathanz25/multi-worker:latest
docker push jonathanz25/multi-server:latest

docker push jonathanz25/multi-client:latest:$SHA
docker push jonathanz25/multi-worker:latest:$SHA
docker push jonathanz25/multi-server:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jonathanz25/multi-server:$SHA
kubectl set image deployments/client-deployment client=jonathanz25/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jonathanz25/multi-worker:$SHA