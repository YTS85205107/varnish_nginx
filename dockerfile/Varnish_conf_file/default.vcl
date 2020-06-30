vcl 4.0;
backend default {
    .host = "127.0.0.1";
    .port = "8080";
}
acl purge {
	"localhost";
	"10.0.0.0/8";	
}
sub vcl_recv {
	if (req.method == "PURGE") {
        if (!client.ip ~ purge) {
			return(synth(405,"Not allowed."));
		}else{
			ban("req.http.host ~ .*");
			return (synth(200, "Full cache cleared"));
		}	
    }else if (req.method == "XCGFULLBAN") {
        ban("req.http.host ~ .*");
        return (synth(200, "Full cache cleared"));
    }else{
		if (req.url ~ "\.(png|gif|jpeg|jpg|ico|swf|css|js|html|htm|woff|woff2)$") {
			return(hash);
		}
    }
}
sub vcl_backend_response {	
	if (bereq.url ~ ".(png|gif|jpeg|jpg|ico|swf|css|js|html|htm|woff|woff2)$") {
		unset beresp.http.set-cookie;
		set beresp.ttl = 3600s; 
	}
}
sub vcl_deliver {
	if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
}
