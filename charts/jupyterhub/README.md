Used official jupyter hub helm chart
See chart on:
 - [github](https://github.com/jupyterhub/helm-chart?tab=readme-ov-file#usage)

To connect to this service via VSCode, you will have to do following:
- run `sudo minikube tunnel`
- open ipynb file
- Click select Kernel
- Existing JupyterHub Server
- http://localhost:80/user/dummy/let-me-in
- username: dummy
- password: c0a775a17b0bea5e934fdecd0a086fec6a27b913724468091f7f7bccaab7b62b
> THIS IS FOR TESTING PURPOSE ONLY. DO NOT USE SUCH SOLUTION IN PRODUCTION
- Notebbook: any