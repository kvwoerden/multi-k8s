docker build -t kvanwoerden/multi-client:latest -t kvanwoerden/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kvanwoerden/multi-server:latest -t kvanwoerden/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kvanwoerden/multi-worker:latest -t kvanwoerden/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kvanwoerden/multi-client:latest
docker push kvanwoerden/multi-server:latest
docker push kvanwoerden/multi-worker:latest

docker push kvanwoerden/multi-client:$SHA
docker push kvanwoerden/multi-server:$SHA
docker push kvanwoerden/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kvanwoerden/multi-server:$SHA
kubectl set image deployments/client-deployment client=kvanwoerden/multi-client:$SHA
kubectl set iamge deployments/worker-deployment worker=kvanwoerden/multi-worker:$SHA