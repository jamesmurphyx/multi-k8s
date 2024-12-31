docker build -t jamesmurphyx/multi-client-k8s:latest -t jamesmurphyx/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t jamesmurphyx/multi-server-k8s:latest -t jamesmurphyx/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t jamesmurphyx/multi-worker-k8s:latest -t jamesmurphyx/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push jamesmurphyx/multi-client-k8s:latest
docker push jamesmurphyx/multi-server-k8s:latest
docker push jamesmurphyx/multi-worker-k8s:latest

docker push jamesmurphyx/multi-client-k8s:$SHA
docker push jamesmurphyx/multi-server-k8s:$SHA
docker push jamesmurphyx/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jamesmurphyx/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=jamesmurphyx/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=jamesmurphyx/multi-worker-k8s:$SHA