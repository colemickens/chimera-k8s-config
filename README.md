chimera-k8s-config
=================

This is the configuration that powers my home server/network.

Broadly speaking, the following things are run via this configuration:
 * auth endpoint (`oauth2_proxy` + GitHub authn + GitHub org member authz)
 * reverse proxy for my router
 * `httpd` running as a simple front for my media directory
 * `httpd` with the `Apaxy` theme running as another simple front for my media directory
 * `kube-lego` handling TLS for each endpoint
 * [todo] Plex
 * [todo] Samba

Run in this order:

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard-head.yaml
./init-nginx-ingress-helmchart.sh
./init-kube-lego-helmchart.sh
./init-oauth2proxy-secret.sh
./init-twitlistauth-secret.sh
./kapply.sh
```

Then run `fix-ingress.sh` in order to attempt to rename the `X-Original-URL` header
to the `X-Auth-Request-URL` header that oauth2_proxy (is supposed to) respect.

Notes:
* https://github.com/bitly/oauth2_proxy/issues/399
* https://github.com/bitly/oauth2_proxy/issues/400

TODO: document this better
