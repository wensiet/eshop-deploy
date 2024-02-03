
echo "Deploying storages ..."
helm template storage storage
helm install storage storage

echo "Storages deployed successfully!"

echo "Creating databases ..."
sleep 5
kubectl apply -f database-create-job.yaml

echo "Databases created successfully!"

echo "Deploying backend ..."
helm template products products
helm templtae orders orders
helm template auth auth
helm template gateway gateway

helm install products products
helm install orders orders
helm install auth auth
helm install gateway gateway

echo "Backend deployed successfully!"