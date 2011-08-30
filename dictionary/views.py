from django.http import HttpResponse
from django.shortcuts import render_to_response
from dictionary.models import Category
from django.contrib.auth.decorators import login_required

@login_required
def index(request):
  category_list = Category.objects.filter(parent__isnull=True)
  return render_to_response('dictionary/categories.html', {'category_list': category_list})

@login_required
def detail(request, id):
  category_list = Category.objects.filter(parent=id)
  return render_to_response('dictionary/categories.html', {'category_list': category_list})
