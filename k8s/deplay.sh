docker build -t 99percent/multi-client:latest -t 99percent/multi-client:$GITSHA -f ./client/Dockerfile ./client
docker build -t 99percent/multi-server:latest -t 99percent/multi-server:$GITSHA -f ./server/Dockerfile ./server
docker build -t 99percent/multi-worker:latest -t 99percent/multi-worker:$GITSHA -f ./docker/Dockerfile ./worker
docker push 99percent/multi-client:latest
docker push 99percent/multi-server:latest
docker push 99percent/multi-worker:latest
docker push 99percent/multi-client:$GITSHA
docker push 99percent/multi-server:$GITSHA
docker push 99percent/multi-worker:$GITSHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=99percent/multi-server:$GITSHA
kubectl set image deployments/client-deployment client=99percent/multi-client:$GITSHA
kubectl set image deployments/worker-deployment worker=99percent/multi-worker:$GITSHA

