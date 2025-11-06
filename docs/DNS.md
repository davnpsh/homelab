# DNS

I use Adguard as a DNS server. I like the **DNS rewrite** feature that allows me to configure custom DNS responses for specific domain names. I use this special feature to point `*.odin.domain.tld` to an IP inside my Tailnet, without havind to add a DNS record in my registrar.

However, there's a problem: Since I don't map ports in the docker compose file, I have no way no access the Adguard configuration page.

![DNS problem](./_static/dns_problem.png)

A temporal solution: Since services in the compose file and interconnected through a docker default network and I can access the reverse proxy panel through Tailscale, I can create a stream from that to the DNS server.

![Stream creation](./_static/proxy_stream_creation.png)

I can then access to the Adguard configuration page using the IP of the Tailscale container and the random port I chose and complete the configuration to make Adguard work. After that, this stream can be deleted.

**IMPORTANT:** Also, I needed to add a stream to port 53 of the Adguard container to have plain DNS working.

![Stream port 53](./_static/proxy_stream_dns.png)
