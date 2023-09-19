#! /bin/bash

cd ../vagrant;
sudo vagrant ssh master -c "sudo kubectl apply -f /vagrant/deployments/calico.yaml"
sudo vagrant ssh master -c "sudo kubectl taint nodes k8s-worker1 node-role.kubernetes.io/notReady-" 
sudo vagrant ssh master -c "sudo kubectl taint nodes k8s-worker2 node-role.kubernetes.io/notReady-" 
sudo vagrant ssh master -c "sudo kubectl apply -f /vagrant/deployments/deployment.yaml"
sudo vagrant ssh master -c "sudo kubectl apply -f /vagrant/deployments/service.yaml"

