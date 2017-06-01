chimera-k8s-proxy
=================

Run in this order:

```
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