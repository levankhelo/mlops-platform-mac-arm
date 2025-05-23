#!/bin/bash

delete() {
  helm delete $@
}

delete_all() {
  delete_jupyter;
  delete_airflow;
  delete_mlflow;
  delete_postgresql;
  delete_mongodb;
}

delete_airflow() {
  delete airflow --namespace airflow
}

delete_mlflow() {
  delete mlflow --namespace mlflow
}

delete_jupyter() {
  delete jupyter --namespace jupyter
}

delete_postgresql() {
  delete postgresql --namespace postgresql
}

delete_mongodb() {
  delete mongodb --namespace mongodb
}

delete_ollama() {
  delete ollama --namespace ollama
}

delete_openwebui() {
  delete openwebui --namespace openwebui
}

if [ $# -eq 0 ]; then
  echo "No arguments provided. Deleting all services..."
  delete_all
else
  for arg in "$@"; do
    case $arg in
      airflow|air*)
        echo "Deleting Airflow..."
        delete_airflow;
        ;;
      mlflow|ml*)
        echo "Deleting MLflow..."
        delete_mlflow;
        ;;
      jupyter|jup*)
        echo "Deleting Jupyter..."
        delete_jupyter;
        ;;
      postgresql|pos*|pg*)
        echo "Deleting PostgreSQL..."
        delete_postgresql;
        ;;
      mongodb|mon*)
        echo "Deleting MongoDB..."
        delete_mongodb;
        ;;
      ollama|oll*)
        echo "Deleting Ollama..."
        delete_ollama;
        ;;
      openwebui|open*)
        echo "Deleting OpenWebUI..."
        delete_openwebui;
        ;;
      netbox|net*)
        echo "Deleting NetBox..."
        kubectl delete pod netbox --namespace default
        ;;
      all)
        echo "Deleting all services..."
        # Delete all services if 'all' is specified
        delete_all;
        ;;
      *)
        delete_all;
        ;;
    esac
  done
fi