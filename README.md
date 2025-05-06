# mlops-platform-mac-arm

## Prerequisits
*install docker enginer*, credentials manager, minikube, helm and colima
```bash
brew install docker docker-credential-helper colima minikube helm;
```
> Colima is container runtime fo containerd and docker. See [documentation](https://github.com/abiosoft/colima?tab=readme-ov-file#readme)



edit *docker congifuration* to use colima context
```bash
mkdir ~/.docker && \
cat <<EOF > ~/.docker/config.json
{
        "auths": {},
        "credsStore": "osxkeychain",
        "currentContext": "colima"
}
EOF
```



*start colima* to download base image
```bash
colima start
```
> Note: if this step fails, try running `colima start` again

*Optional*: Add colima as a service, to aurtostart with mac
```bash
brew services start colima
```

download minikube image
```bash
minikube start --dry-run
```


## Prepare Environment

Configure local resources
```bash
export KUBE_CPU='12';
export KUBE_MEMORY='20';
```

Stop running instances, and start new one, with configured resources
```bash
colima stop && \
colima start --cpu $KUBE_CPU --memory ${KUBE_MEMORY} && \
minikube stop && \
minikube start --driver=docker --cpus="${KUBE_CPU}" --gpus="all"
```
> in this example, we are using 12 cpu cores using `--cpus` and 20GB memory using `--memory` commands
> We can use `-g` or `--gpu` option to allow pods to use GPUs

