from functools import wraps

from django import http
from django.conf import settings
from django.shortcuts import get_object_or_404
from django.views.decorators.cache import never_cache
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.vary import vary_on_headers

import jingo
from commons.urlresolvers import reverse
from session_csrf import anonymous_csrf
from tower import ugettext as _

from apply.forms import ApplicationForm

@anonymous_csrf
def apply(request):
    """Display the form to add a new Application to the database."""
    if request.method == 'POST':
        form = ApplicationForm(request.POST)
        if form.is_valid(): # All validation rules pass; form is savable.
            form.save()

            return http.HttpResponseRedirect(reverse('thanks'))
    else:
        form = ApplicationForm()

    return jingo.render(request, 'apply/apply.html', {'form': form})

def faq(request):
    """FAQ page for Web Forward"""
    return jingo.render(request, 'apply/faq.html')

def index(request):
    """
    Home page for Web Forward; currently a static HTML page with info about
    Web Forward and a link to the application form.
    """
    return jingo.render(request, 'apply/index.html')

def mentorship(request):
    """Mentorship page for Web Forward"""
    return jingo.render(request, 'apply/mentorship.html')

def thanks(request):
    """Thanks page; displayed after a successful application submission."""
    return jingo.render(request, 'apply/thanks.html')

def projects(request):
    """Project page for Web Forward"""
    return jingo.render(request, 'apply/projects.html')
