from django.db import models
from login.models import *
from tms.models import Car

class Incident(models.Model):
    user=models.ForeignKey(User,related_name='incident_user',on_delete=models.CASCADE)
    car=models.ForeignKey(Car,related_name='incident_car',on_delete=models.CASCADE)
    incident_type=models.CharField(max_length=30, default="")
    location=models.CharField(max_length=30)
    image=models.ImageField(blank=True)

class Rescue(models.Model):
    user=models.ForeignKey(User,related_name='rescue_user',on_delete=models.CASCADE)
    car=models.ForeignKey(Car,related_name='rescue_car',on_delete=models.CASCADE)
    location=models.CharField(max_length=30)
    service_needs=models.CharField(max_length=100)
    note=models.CharField(max_length=100)
