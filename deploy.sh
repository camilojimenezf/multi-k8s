docker build -t camilojimenezf/multi-client:latest -t camilojimenezf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t camilojimenezf/multi-server:latest -t camilojimenezf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t camilojimenezf/multi-worker:latest -t camilojimenezf/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push camilojimenezf/multi-client:latest
docker push camilojimenezf/multi-server:latest
docker push camilojimenezf/multi-worker:latest

docker push camilojimenezf/multi-client:$SHA
docker push camilojimenezf/multi-server:$SHA
docker push camilojimenezf/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=camilojimenezf/multi-server:$SHA
kubectl set image deployments/client-deployment client=camilojimenezf/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=camilojimenezf/multi-worker:$SHA