addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  let url = new URL(request.url)
  if (url.pathname.endsWith('.html')) {
    url.pathname = url.pathname.slice(0, -5)
    return Response.redirect(url, 301)
  }
  return fetch(request)
}
