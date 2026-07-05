# Day 57 – Resource Requests, Limits, and Probes

## Task
Your Pods are running, but Kubernetes has no idea how much CPU or memory they need — and no way to tell if they are actually healthy. Today you set resource requests and limits for smart scheduling, then add probes so Kubernetes can detect and recover from failures automatically.

---

## Challenge Tasks

### Task 1: Resource Requests and Limits
1. Write a Pod manifest with `resources.requests` (cpu: 100m, memory: 128Mi) and `resources.limits` (cpu: 250m, memory: 256Mi)
2. Apply and inspect with `kubectl describe pod` — look for the Requests, Limits, and QoS Class sections
3. Since requests and limits differ, the QoS class is `Burstable`. If equal, it would be `Guaranteed`. If missing, `BestEffort`.

CPU is in millicores: `100m` = 0.1 CPU. Memory is in mebibytes: `128Mi`.

**Requests** = guaranteed minimum (scheduler uses this for placement). **Limits** = maximum allowed (kubelet enforces at runtime).

**Verify:** What QoS class does your Pod have?

- Pod have Qos Class Burstable

<img width="777" height="172" alt="image" src="https://github.com/user-attachments/assets/b472b427-0b39-4bad-a653-1751b9a8fff6" />

<img width="1245" height="916" alt="image" src="https://github.com/user-attachments/assets/120de58c-d932-4537-8999-40daaacccc78" />

---

### Task 2: OOMKilled — Exceeding Memory Limits
1. Write a Pod manifest using the `polinux/stress` image with a memory limit of `100Mi`
2. Set the stress command to allocate 200M of memory: `command: ["stress"] args: ["--vm", "1", "--vm-bytes", "200M", "--vm-hang", "1"]`
3. Apply and watch — the container gets killed immediately

CPU is throttled when over limit. Memory is killed — no mercy.

Check `kubectl describe pod` for `Reason: OOMKilled` and `Exit Code: 137` (128 + SIGKILL).

**Verify:** What exit code does an OOMKilled container have?

- An OOMKilled container exits with code 137

<img width="1311" height="392" alt="image" src="https://github.com/user-attachments/assets/f48fa1a6-4a49-41f9-bea5-7e55de257a92" />

<img width="672" height="87" alt="image" src="https://github.com/user-attachments/assets/0c58b9a1-69dd-4f5c-b0ae-c4ddc9ba4b4a" />

---

### Task 3: Pending Pod — Requesting Too Much
1. Write a Pod manifest requesting `cpu: 100` and `memory: 128Gi`
2. Apply and check — STATUS stays `Pending` forever
3. Run `kubectl describe pod` and read the Events — the scheduler says exactly why: insufficient resources

**Verify:** What event message does the scheduler produce?

- 0/3 nodes are available: Insufficient cpu, Insufficient memory
  
<img width="1901" height="761" alt="image" src="https://github.com/user-attachments/assets/6aab09c5-4d55-4f1a-8e6c-23c1a8ecaf2d" />

---

### Task 4: Liveness Probe
A liveness probe detects stuck containers. If it fails, Kubernetes restarts the container.

1. Write a Pod manifest with a busybox container that creates `/tmp/healthy` on startup, then deletes it after 30 seconds
2. Add a liveness probe using `exec` that runs `cat /tmp/healthy`, with `periodSeconds: 5` and `failureThreshold: 3`
3. After the file is deleted, 3 consecutive failures trigger a restart. Watch with `kubectl get pod -w`

**Verify:** How many times has the container restarted?

- 4 times container restarted
  
<img width="686" height="155" alt="image" src="https://github.com/user-attachments/assets/c68767f1-4b75-402e-b63c-10e81425150f" />

<img width="1272" height="447" alt="image" src="https://github.com/user-attachments/assets/b816198c-663f-40e5-a9ac-0419c5a19941" />

---

### Task 5: Readiness Probe
A readiness probe controls traffic. Failure removes the Pod from Service endpoints but does NOT restart it.

1. Write a Pod manifest with nginx and a `readinessProbe` using `httpGet` on path `/` port `80`
2. Expose it as a Service: `kubectl expose pod <name> --port=80 --name=readiness-svc`
3. Check `kubectl get endpoints readiness-svc` — the Pod IP is listed
4. Break the probe: `kubectl exec <pod> -- rm /usr/share/nginx/html/index.html`
5. Wait 15 seconds — Pod shows `0/1` READY, endpoints are empty, but the container is NOT restarted

**Verify:** When readiness failed, was the container restarted?

- No, the container was NOT restarted.

<img width="726" height="192" alt="image" src="https://github.com/user-attachments/assets/46fe88cc-c4cf-498a-a019-3adf47997e29" />

<img width="1327" height="941" alt="image" src="https://github.com/user-attachments/assets/43fb7d54-5a89-43a5-a06a-4be658d2dfe1" />

---

### Task 6: Startup Probe
A startup probe gives slow-starting containers extra time. While it runs, liveness and readiness probes are disabled.

1. Write a Pod manifest where the container takes 20 seconds to start (e.g., `sleep 20 && touch /tmp/started`)
2. Add a `startupProbe` checking for `/tmp/started` with `periodSeconds: 5` and `failureThreshold: 12` (60 second budget)
3. Add a `livenessProbe` that checks the same file — it only kicks in after startup succeeds

**Verify:** What would happen if `failureThreshold` were 2 instead of 12?


- If `failureThreshold` is set to `2`,the startup probe allows only 10 seconds (2 × 5s) for the container to start.
- Since the container takes 20 seconds to start, the startupProbe will fail before the app is ready,causing Kubernetes to restart the container repeatedly.

<img width="1450" height="607" alt="image" src="https://github.com/user-attachments/assets/5caccb02-2557-4a64-b930-c9a3310ff7d7" />

<img width="1760" height="297" alt="image" src="https://github.com/user-attachments/assets/53578023-7916-439e-aca3-d672339cc76f" />

`0/1 READY`: app still starting (startupProbe running)

`1/1 READY`: startup complete, livenessProbe active
  
---

### Task 7: Clean Up
Delete all pods and services you created.

<img width="872" height="557" alt="image" src="https://github.com/user-attachments/assets/9d535f2c-734c-47ac-9553-665951379431" />

---

**Requests vs limits (scheduling vs enforcement)**

`Requests`
 - Used by Kubernetes scheduler to decide where to place the Pod
 - Guarantees minimum resources

`Limits`
 - Enforced by container runtime
 - Prevents container from using more than defined resources

**What happens when CPU or memory limits are exceeded**

`CPU limit exceeded`
- Container is throttled (slowed down, not killed)

`Memory limit exceeded`
- Container is killed (OOMKilled) and restarted

**Liveness vs readiness vs startup probes**

| Probe Type          | Purpose                        | When it Runs           | If it Fails                       | Simple Meaning            |
| ------------------- | ------------------------------ | ---------------------- | --------------------------------- | ------------------------- |
| **Startup Probe**   | Check if app has started       | At container startup   | Container is restarted            | “Has app started?”        |
| **Liveness Probe**  | Check if app is still alive    | After startup succeeds | Container is restarted            | “Is app alive?”           |
| **Readiness Probe** | Check if app can serve traffic | Throughout lifecycle   | Removed from service (no traffic) | “Is app ready for users?” |

---

## Submission
1. Add `day-57-resources-probes.md` to `2026/day-57/`
2. Commit and push to your fork

---

## Learn in Public
Share on LinkedIn: "Set resource requests and limits in Kubernetes today, watched a pod get OOMKilled, and added liveness, readiness, and startup probes for self-healing."

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
