echo "Do you want to start minikube? (y/n)"
read -r answer

if [ "$answer" == "y" ]; then
    minikube start --memory 8192 --cpus 4
fi


echo "Deploying storages ..."
helm template storage storage
helm install storage storage

echo "Storages deployed successfully!"

echo "Creating databases ..."
sleep 5

kubectl apply -f database-create-job.yaml

echo "Databases created successfully!"

echo "Preparing backend deployment ..."
helm template products products
helm templtae orders orders
helm template auth auth
helm template gateway gateway

echo "Backend deployment is ready!"
slee 2

helm install products products
helm install orders orders
helm install auth auth
helm install gateway gateway

echo "Backend deployed successfully!"