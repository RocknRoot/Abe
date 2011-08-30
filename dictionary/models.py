from django.db import models
from django.contrib.auth.models import User

class Category(models.Model):
  parent = models.ForeignKey('Category', null=True)
  user = models.ForeignKey(User)
  name = models.CharField(max_length=50)
  created_at = models.DateTimeField()
  updated_at = models.DateTimeField(auto_now=True, null=True, blank=True)
  def __unicode__(self):
    return self.name

class Term(models.Model):
  category = models.ForeignKey(Category, null=True, blank=True)
  user = models.ForeignKey(User)
  name = models.CharField(max_length=150)
  content = models.TextField()
  created_at = models.DateTimeField()
  updated_at = models.DateTimeField(auto_now=True, null=True, blank=True)
  def __unicode__(self):
    return self.name
