docker build -t jkankaanpaa/multi-client:latest -t jkankaanpaa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jkankaanpaa/multi-server:latest -t jkankaanpaa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jkankaanpaa/multi-worker:latest -t jkankaanpaa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jkankaanpaa/multi-client:latest
docker push jkankaanpaa/multi-server:latest
docker push jkankaanpaa/multi-worker:latest

docker push jkankaanpaa/multi-client:$SHA
docker push jkankaanpaa/multi-server:$SHA
docker push jkankaanpaa/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jkankaanpaa/multi-server:$SHA
kubectl set image deployments/client-deployment client=jkankaanpaa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jkankaanpaa/multi-worker:$SHA