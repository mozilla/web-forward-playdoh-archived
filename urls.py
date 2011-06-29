from django.conf import settings
from django.conf.urls.defaults import *

from django.contrib import admin

import jingo


admin.autodiscover()

def _error_page(request, status):
    """Render error pages with jinja2."""
    return jingo.render(request, '%d.html' % status, status=status)

handler404 = lambda r: _error_page(r, 404)
handler500 = lambda r: _error_page(r, 500)
handler_csrf = lambda r, reason: jingo.render(r, 'csrf_error.html')

urlpatterns = patterns('',
    # Example:
    (r'', include('apply.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # (r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    (r'^admin/', include(admin.site.urls)),
)

## In DEBUG mode, serve media files through Django.
if settings.DEBUG or True:
    # Remove leading and trailing slashes so the regex matches.
    media_url = settings.MEDIA_URL.lstrip('/').rstrip('/')
    urlpatterns += patterns('',
        (r'^%s/(?P<path>.*)$' % media_url, 'django.views.static.serve',
         {'document_root': settings.MEDIA_ROOT}),
    )
