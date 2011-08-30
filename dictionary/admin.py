from dictionary.models import Category, Term
from django.contrib import admin

class CategoryAdmin(admin.ModelAdmin):
  fieldsets = [
      (None, {'fields': ['user', 'parent', 'name']}),
      ('Date', {'fields': ['created_at']}),
  ]

class TermAdmin(admin.ModelAdmin):
  fieldsets = [
      (None, {'fields': ['user', 'category', 'name', 'content']}),
      ('Date', {'fields': ['created_at']}),
  ]

admin.site.register(Category, CategoryAdmin)
admin.site.register(Term, TermAdmin)
