# Day 59 – Helm — Kubernetes Package Manager

## Task
Over the past eight days you have written Deployments, Services, ConfigMaps, Secrets, PVCs, and more — all as individual YAML files. For a real application you might have dozens of these. Helm is the package manager for Kubernetes, like apt for Ubuntu. Today you install charts, customize them, and create your own.

---

## Challenge Tasks

### Task 1: Install Helm
1. Install Helm (brew, curl script, or chocolatey depending on your OS)
2. Verify with `helm version` and `helm env`

Three core concepts:
- **Chart** — a package of Kubernetes manifest templates
- **Release** — a specific installation of a chart in your cluster
- **Repository** — a collection of charts (like a package repo)

`
# Download the Windows zip file
curl -LO https://get.helm.sh/helm-v4.1.3-windows-amd64.zip

# Unzip the file
unzip helm-v4.1.3-windows-amd64.zip

# Move the Windows executable to a standard Windows path (requires admin terminal)
mv windows-amd64/helm.exe /c/Windows/System32/

If you get a permission denied error with the command above, see Step 3.

# Add it to a custom folder and update your PATH
export PATH=$PATH:/c/helm
`

And 

`
# 1. Create a helm folder in your user directory
mkdir -p ~/helm

# 2. Move the windows executable into that new folder
mv windows-amd64/helm.exe ~/helm/

# 3. Tell your current terminal session where to find it
export PATH=$PATH:~/helm

# 4. Test it
helm version
`

**Verify:** What version of Helm is installed?
- v4.1.3

<img width="887" height="582" alt="image" src="https://github.com/user-attachments/assets/b6aeea8d-4b71-4a46-9020-6e33c480d2fa" />
<img width="1497" height="626" alt="image" src="https://github.com/user-attachments/assets/e0ca972c-5ec9-4fa6-b99b-cfc45ada5c8c" />

---

### Task 2: Add a Repository and Search
1. Add the Bitnami repository: `helm repo add bitnami https://charts.bitnami.com/bitnami`
2. Update: `helm repo update`
3. Search: `helm search repo nginx` and `helm search repo bitnami`

**Verify:** How many charts does Bitnami have?

<img width="1217" height="867" alt="image" src="https://github.com/user-attachments/assets/48c41d29-b086-4ec1-8721-5b7f455dd9bd" />
<img width="472" height="67" alt="image" src="https://github.com/user-attachments/assets/92edb61e-2dd2-473f-88e8-1ac7b384ca4c" />

---

### Task 3: Install a Chart
1. Deploy nginx: `helm install my-nginx bitnami/nginx`

<img width="707" height="361" alt="image" src="https://github.com/user-attachments/assets/e3d9bdbd-8e91-4306-8356-54206000ce69" />

2. Check what was created: `kubectl get all`

<img width="977" height="266" alt="image" src="https://github.com/user-attachments/assets/cf192c4d-cb2c-40f3-b1ba-276f67fc001c" />

3. Inspect the release: `helm list`, `helm status my-nginx`, `helm get manifest my-nginx`

- `helm list` -  Lists all Helm releases in the current namespace

<img width="1236" height="92" alt="image" src="https://github.com/user-attachments/assets/0d08533a-a33b-4f51-ab05-4ff181a05461" />

- `helm status my-nginx` - Shows the current status (deployed, failed, etc.) of the my-nginx

<img width="935" height="815" alt="image" src="https://github.com/user-attachments/assets/1efa15b0-b614-4930-9d63-5af39fbfaf34" />

- `helm get manifest my-nginx` - Displays the Kubernetes YAML manifests generated for the my-nginx release

<img width="642" height="972" alt="image" src="https://github.com/user-attachments/assets/4f6756b5-2672-4b28-9beb-63fae97d5548" />

One command replaced writing a Deployment, Service, and ConfigMap by hand.

**Verify:** How many Pods are running? What Service type was created?

- One pod is running, LoadBalancer service type is created.

---

### Task 4: Customize with Values
1. View defaults: `helm show values bitnami/nginx`
2. Install a custom release with `--set replicaCount=3 --set service.type=NodePort`
<img width="1207" height="240" alt="image" src="https://github.com/user-attachments/assets/187be160-c52d-46f5-9c52-81ad81237fb8" />

<img width="877" height="297" alt="image" src="https://github.com/user-attachments/assets/7ce15533-e212-4b1c-940a-a458eacea49f" />

3. Create a `custom-values.yaml` file with replicaCount, service type, and resource limits
4. Install another release using `-f custom-values.yaml`

- `helm install custom-values-nginx bitnami/nginx -f custom-values.yml --namespace cm-file --create-namespace`
  
<img width="1035" height="312" alt="image" src="https://github.com/user-attachments/assets/8c7a5dc4-0074-4daa-813f-9556ba96405c" />

5. Check overrides: `helm get values <release-name>`

<img width="650" height="262" alt="image" src="https://github.com/user-attachments/assets/885f6058-1f95-41fb-96b4-b33e71536d28" />

**Verify:** Does the values file release have the correct replicas and service type?

-  Yes
  
---

### Task 5: Upgrade and Rollback
1. Upgrade: `helm upgrade my-nginx bitnami/nginx --set replicaCount=5`

<img width="697" height="250" alt="image" src="https://github.com/user-attachments/assets/c60b6165-5f8f-4355-abbb-f5d212542bed" />

2. Check history: `helm history my-nginx`
3. Rollback: `helm rollback my-nginx 1`
4. Check history again — rollback creates a new revision (3), not overwriting revision 2

Same concept as Deployment rollouts from Day 52, but at the full stack level.

<img width="1107" height="362" alt="image" src="https://github.com/user-attachments/assets/a37b2ec7-809a-4a65-92d7-b5d5246ca0f0" />

**Verify:** How many revisions after the rollback?

- 3 revisions

---

### Task 6: Create Your Own Chart
1. Scaffold: `helm create my-app`
2. Explore the directory: `Chart.yaml`, `values.yaml`, `templates/deployment.yaml`

<img width="1230" height="627" alt="image" src="https://github.com/user-attachments/assets/f34703c1-6bd2-43e4-b236-2de97974027f" />

3. Look at the Go template syntax in templates: `{{ .Values.replicaCount }}`, `{{ .Chart.Name }}`

<img width="1052" height="872" alt="image" src="https://github.com/user-attachments/assets/b4df35b1-cd2b-49bc-8be1-188c6042d80f" />

4. Edit `values.yaml` — set replicaCount to 3 and image to nginx:1.25
5. Validate: `helm lint my-app`
6. Preview: `helm template my-release ./my-app`
7. Install: `helm install my-release ./my-app`
8. Upgrade: `helm upgrade my-release ./my-app --set replicaCount=5`

<img width="1626" height="772" alt="image" src="https://github.com/user-attachments/assets/c6a460c1-8261-4861-b8b7-04719ff5b52c" />

<img width="757" height="182" alt="image" src="https://github.com/user-attachments/assets/8a455996-85d5-4b0c-a361-98f74fef21d2" />

**Verify:** After installing, 3 replicas? After upgrading, 5?

- Yes

---

### Task 7: Clean Up
1. Uninstall all releases: `helm uninstall <name>` for each
2. Remove chart directory and values file
3. Use `--keep-history` if you want to retain release history for auditing

**Verify:** Does `helm list` show zero releases?
- Yes

<img width="1392" height="606" alt="image" src="https://github.com/user-attachments/assets/a2d62151-cd1b-4b12-8603-aa6e8ebaeace" />

---

`What Helm is and the three core concepts`
  - Helm package manager for Kubernetes applications includes templating and lifecycle management functionality.
  - It is a package manager for Kubernetes manifests (such as Deployments, ConfigMaps, Services, etc.)

`Three core concepts:`
    - **Chart** — a package of Kubernetes manifest templates
    - **Release** — a specific installation of a chart in your cluster
    - **Repository** — a collection of charts (like a package repo)

**How to install, customize, upgrade, and rollback**

1. `Install`
```bash
helm install my-app ./my-chart
```
`With custom values:`
```bash
helm install my-app ./my-chart -f values.yml
```
2. `Customize`

`Method 1: values.yml`
```bash
replicaCount: 3

image:
  repository: nginx
  tag: "1.25"
```
`Method 2: CLI override`
```bash
helm install my-app ./my-chart \
  --set replicaCount=5 \
  --set image.tag=latest
```
3. `Upgrade`
```bash
helm upgrade my-app ./my-chart -f values.yml
```
`Helm tracks changes and applies only diffs.`

4. `Rollback`
```bash
helm rollback my-app 1
```
`Check revisions:`
```bash
helm history my-app
```

**The structure of a Helm chart and how Go templating works**
```bash
nginx-chart/
├── Chart.yaml
├── values.yaml
├── charts/
├── templates/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── _helpers.tpl
│   └── ingress.yaml
└── .helmignore
```

`Chart.yaml` metadata

`values.yaml` (default config) This is where all configurable variables live.

`templates/` Contains Kubernetes manifests with Go templating

`charts/` Used for dependencies (subcharts)

`Go templating in Helm`
- Helm uses Go-based templates to turn parameterized files into valid Kubernetes YAML.
- Placeholders inside {{ ... }} are replaced with actual values during rendering.
- Configuration values are sourced from:
    - Default values.yaml
    - User-provided files via -f
    - Command-line overrides using --set

- This allows the same chart to be reused across environments with different configurations.

**`custom-values.yml` with explanations**

```bash
# Number of pod replicas to run (scaling)
replicaCount: 3 

service:
  type: NodePort  # Exposes service externally via <NodeIP>:<NodePort>
  port: 80        # Internal service port inside the cluster

resources:
  requests:
    cpu: "100m"     # Minimum CPU guaranteed
    memory: "128Mi" # Minimum memory guaranteed
  limits:
    cpu: "250m"     # Max CPU allowed
    memory: "256Mi" # Max memory allowed
```
---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
