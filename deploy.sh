docker build -t prabu444/multi-client:latest -t prabu444/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t prabu444/multi-server:latest -t prabu444/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t prabu444/multi-worker:latest -t prabu444/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push prabu444/multi-client:latest
docker push prabu444/multi-server:latest
docker push prabu444/multi-worker:latest

docker push prabu444/multi-client:$SHA
docker push prabu444/multi-server:$SHA
docker push prabu444/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=prabu444/multi-client:$SHA
kubectl set image deployments/server-deployment server=prabu444/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=prabu444/multi-worker:$SHA