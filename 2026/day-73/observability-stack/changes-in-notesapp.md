## Step 1: Install django-prometheus
Add to your requirements.txt (in notes-app folder):

- requirements.txt
```python
django-prometheus  # ← ADD THIS LINE
```

## Step 2: Update settings.py
Open notes-app/notesapp/settings.py and make these 2 changes:

-  Add to INSTALLED_APPS
Find this section:

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    # ... other apps
    'rest_framework',
    'notes',
    'django_prometheus',  # ← ADD THIS (anywhere in the list)
]
```
- Add to MIDDLEWARE
   - Find the MIDDLEWARE list (near top of file):
   - Add two lines (one at top, one at bottom):

```python
MIDDLEWARE = [
    'django_prometheus.middleware.PrometheusBeforeMiddleware',  # ← ADD AT TOP
    
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    # ... your existing middleware (keep all of them)
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    
    'django_prometheus.middleware.PrometheusAfterMiddleware',  # ← ADD AT BOTTOM
]
```
⚠️ Important: Keep ALL your existing middleware! Just add the 2 Prometheus lines.

## Step 3: Update urls.py
- Open notes-app/notesapp/urls.py and add one line:

```python
from django.contrib import admin
from django.urls import path, include  # ← Make sure 'include' is here

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('notes.urls')),  # Your existing API routes
    path('', include('django_prometheus.urls')),  # ← ADD THIS LINE (at the end)
]
```
That's it! This automatically creates /metrics endpoint.

### Step 4: Restart & Test
```bash
# Rebuild and restart notes-app
docker-compose up -d --build notes-app

# Test metrics endpoint
curl http://localhost:8000/metrics
```