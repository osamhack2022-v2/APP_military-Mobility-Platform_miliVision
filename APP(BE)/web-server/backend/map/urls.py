from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.total_map, name='total_map'),
]