docker build -t shawnie86/multi-client:latest -t shawnie86/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shawnie86/multi-server:latest -t shawnie86/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shawnie86/multi-worker:latest -t shawnie86/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push shawnie86/multi-client:latest
docker push shawnie86/multi-worker:latest
docker push shawnie86/multi-server:latest
docker push shawnie86/multi-client:$SHA
docker push shawnie86/multi-worker:$SHA
docker push shawnie86/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shawnie86/multi-server:$SHA
kubectl set image deployments/client-deployment client=shawnie86/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shawnie86/multi-worker:$SHA
