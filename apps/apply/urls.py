from django.conf.urls.defaults import *

from apply.models import Application


urlpatterns = patterns('apply.views',
    url(r'^$', 'index', name='index'),
    url(r'^apply$', 'apply', name='apply'),
    url(r'^faq$', 'faq', name='faq'),
    url(r'^mentorship$', 'mentorship', name='mentorship'),
    url(r'^thanks$', 'thanks', name='thanks'),
    url(r'^projects$', 'projects', name='projects'),
)
