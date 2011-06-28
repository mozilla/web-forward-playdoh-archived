from django.conf.urls.defaults import *
from django.contrib.auth.decorators import login_required
from django.contrib import databrowse

from apply.models import Application


urlpatterns = patterns('apply.views',
    url(r'^$', 'index', name='index'),
    url(r'^apply$', 'apply', name='apply'),
    url(r'^faq$', 'faq', name='faq'),
    url(r'^mentorship$', 'mentorship', name='mentorship'),
    url(r'^thanks$', 'thanks', name='thanks'),
    url(r'^submissions/(.*)', login_required(databrowse.site.root),
        name="submissions"),
)

databrowse.site.register(Application)
