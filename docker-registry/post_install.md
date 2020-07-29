## Docker Registry - Default ingress controller

### Creation of the certificate

This will help you to create a valid certifica for your registry, you need apply this YAML file 
you need remplase only `registry.example.com` by your valid domain
```yaml
apiVersion: cert-manager.io/v1alpha2
kind: Certificate
metadata:
  name: letsencrypt-prod
spec:
  secretName: registry.example.com-crt
  dnsNames:
  - registry.example.com
  acme:
    config:
    - http01:
        ingressClass: traefik
      domains:
      - registry.example.com
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
```

### External access to your services

Traefik is installed in K3s as the default ingress controller. To use it for your applications all you have to do is apply a YAML file like the one below to handle ingress:

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: registry
  namespace: default
  annotations:
    certmanager.k8s.io/cluster-issuer: letsencrypt-prod
    kubernetes.io/ingress.class: "traefik"
    nginx.ingress.kubernetes.io/proxy-body-size: 50m
    ingress.kubernetes.io/auth-type: basic
    ingress.kubernetes.io/auth-secret: auth-ingress
  labels:
    app: docker-registry
spec:
  tls:
  - hosts:
    - registry.example.com
    secretName: registry.example.com-cert
  rules:
  - host: registry.example.com
    http:
      paths:
      - path: /
        backend:
          serviceName: private-registry-docker-registry
          servicePort: 5000
```

This will open up http://registry.example.com (assuming you pointed that non-real domain record to your cluster's IPs) to the whole world.