from django.conf.urls.defaults import *

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    (r'^$', 'home.views.index'),
    (r'^index$', 'home.views.index'),
    (r'^logout$', 'django.contrib.auth.views.logout_then_login', 'index'),

    (r'^category/(?P<category_id>\d+)/$', 'dictionary.views.detail'),
    (r'^category', 'dictionary.views.index'),
    # Examples:
    # url(r'^$', 'Abe.views.home', name='home'),
    # url(r'^Abe/', include('Abe.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    url(r'^admin/', include(admin.site.urls)),
)
