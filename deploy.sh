docker build -t noko84/multi-client:latest -t noko84/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t noko84/multi-server:latest -t noko84/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t noko84/multi-worker:latest -t noko84/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push noko84/multi-client:latest
docker push noko84/multi-server:latest
docker push noko84/multi-worker:latest

docker push noko84/multi-client:$SHA
docker push noko84/multi-server:$SHA
docker push noko84/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=noko84/multi-server:$SHA
kubectl set image deployments/client-deployment client=noko84/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=noko84/multi-worker:$SHA