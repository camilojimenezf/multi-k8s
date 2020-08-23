docker build -t camilojimenez/multi-client:latest -t camilojimenez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t camilojimenez/multi-server:latest -t camilojimenez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t camilojimenez/multi-worker:latest -t camilojimenez/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push camilojimenez/multi-client:latest
docker push camilojimenez/multi-server:latest
docker push camilojimenez/multi-worker:latest

docker push camilojimenez/multi-client:$SHA
docker push camilojimenez/multi-server:$SHA
docker push camilojimenez/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=camilojimenez/multi-client:$SHA
kubectl set image deployments/server-deployment server=camilojimenez/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=camilojimenez/multi-worker:$SHA
