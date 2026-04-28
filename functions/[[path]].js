export function onRequest(context) {
  const url = new URL(context.request.url);
  const redirectHosts = new Set([
    "heishenry.com",
    "www.heishenry.com",
    "www.h3nryh3.com",
  ]);

  if (redirectHosts.has(url.hostname.toLowerCase())) {
    return Response.redirect("https://h3nryh3.com/", 301);
  }

  return context.next();
}
