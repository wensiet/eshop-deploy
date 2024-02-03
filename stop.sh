echo "This action will delete PersistentVolumes, are you sure about this? (y/n)"
read -r answer

if [ "$answer" != "y" ]; then
    echo "Aborting."
    exit 0
fi


echo "Stopping the deployment ..."

helm uninstall storage
helm uninstall products
helm uninstall orders
helm uninstall auth
helm uninstall gateway

kubectl delete job eshop-init-db

echo "Deployment successfully stopped."