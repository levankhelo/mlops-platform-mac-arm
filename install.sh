#!/bin/bash

run() {
  helm upgrade --install --cleanup-on-fail $@
}

run_all() {
  run_jupyter;
  run_airflow;
  run_mlflow;
  run_postgresql;
  run_mongodb;
  run_ollama;
  run_openwebui;
}

run_airflow() {
  run airflow apache-airflow/airflow --namespace airflow --create-namespace --values charts/airflow/values.yaml
}

run_mlflow() {
  run mlflow oci://registry-1.docker.io/bitnamicharts/mlflow --namespace mlflow --create-namespace --values charts/mlflow/values.yaml
}

run_jupyter() {
  run jupyter jupyterhub/jupyterhub --namespace jupyter --create-namespace --values charts/jupyterhub/values.yaml
}

run_postgresql() {
  run postgresql oci://registry-1.docker.io/bitnamicharts/postgresql --namespace postgresql --create-namespace --values charts/postgresql/values.yaml
}

run_mongodb() {
  run mongodb oci://registry-1.docker.io/bitnamicharts/mongodb --namespace mongodb --create-namespace --values charts/mongodb/values.yaml
}

run_ollama() {
  run ollama ollama-helm/ollama --namespace ollama --create-namespace --values charts/ollama/values.yaml
}

run_openwebui() {
  run openwebui open-webui/open-webui --namespace openwebui --create-namespace --values charts/openwebui/values.yaml
}

run_netbox() {
  kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: netbox
  labels:
    app: netbox
spec:
  containers:
  - name: netbox
    image: levankhelo/netbox:latest
    ports:
    - containerPort: 8000
EOF
}

if [ $# -eq 0 ]; then
  echo "No arguments provided. Running all services..."
  run_all
else
  for arg in "$@"; do
    case $arg in
      airflow|air*)
        echo "Running Airflow..."
        run_airflow;
        ;;
      mlflow|ml*)
        echo "Running MLflow..."
        run_mlflow;
        ;;
      jupyter|jup*)
        echo "Running Jupyter..."
        run_jupyter;
        ;;
      netbox|net*)
        echo "Running NetBox..."
        run_netbox;
        ;;
      postgresql|pos*|pg*)
        echo "Running PostgreSQL..."
        run_postgresql;
        ;;
      mongodb|mon*)
        echo "Running MongoDB..."
        run_mongodb;
        ;;
      ollama|oll*)
        echo "Running Ollama..."
        run_ollama;
        ;;
      openwebui|open*)
        echo "Running OpenWebUI..."
        run_openwebui;
        ;;
      all)
        echo "Running all services..."
        # Run all services if 'all' is specified
        run_all;
        ;;
      *)
        run_all;
        ;;
    esac
  done
fi