docker build -t yilong9407/multi-client:latest -t yilong9407/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yilong9407/multi-server:latest -t yilong9407/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yilong9407/multi-worker:latest -t yilong9407/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yilong9407/multi-client:latest
docker push yilong9407/multi-server:latest
docker push yilong9407/multi-worker:latest

docker push yilong9407/multi-client:$SHA
docker push yilong9407/multi-server:$SHA
docker push yilong9407/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=yilong9407/multi-client:$SHA
kubectl set image deployments/server-deployment server=yilong9407/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=yilong9407/multi-worker:$SHA
